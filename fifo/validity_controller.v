// Data validity controller for the mixed-clock FIFO cell

module validity_controller 
(
	input   clk_put, clk_get,
	input   enable_put, enable_get,
	output  full, empty,
	output  ptok_hold//, gtok_hold
);
	
	// Local signals for full and empty states
	reg f_i=0;
	reg f_i_put=0; // initialize full to low (not full)
	reg f_i_get=0;
	reg e_i=1;
	reg e_i_put=1; // initialize empty to high (empty)
	reg e_i_get=1;
	// flag for "reading in progress"
	reg read=0;
	// flag for "reading done"
	reg valid_read=0;
	// flag for enabling writing when reading is finished
	reg write_enable=1;
	reg write_disable=0;

	// Process the state of the FIFO cell
	always @ (posedge clk_put)
	begin
		if (~write_enable & write_disable)
		begin
			f_i_put <= 1'b0;
			e_i_put <= ~f_i_put;
		end
		else
		begin
			if (enable_put & ~enable_get)
			begin
				f_i_put <= 1'b1;
				e_i_put <= ~f_i_put;
			end
			else if (~enable_put & enable_get)
			begin
				f_i_put <= 1'b0;
				e_i_put <= ~f_i_put;
			end
			else if (enable_put & enable_get) 
			begin
				if (f_i)
				begin
					f_i_put <= 1'b0;
					e_i_put <= ~f_i_put;
				end
				else if (e_i)
				begin
					f_i_put <= 1'b1;
					e_i_put <= ~f_i_put;
				end
			end 
		end
	end
	
	always @ (posedge clk_get)
	begin
		if (read) // do not allow read and write at the same time
		begin // if currently reading, allow for the read cycle to end			
			f_i_get <= 1'b1;
			e_i_get <= ~f_i_get;
			valid_read <= 1'b1; // flag that reading has finished successfully
		end
		else 
		begin
			if (~e_i & valid_read)
			begin
				write_enable <= 1'b1; // enable writing once read is valid
				f_i_get <= 1'b0;
				e_i_get <= ~f_i_get;
			end
			else
			begin
				write_enable <= 1'b0;
			end
					
			if (enable_put & ~enable_get)
			begin
				f_i_get <= 1'b1;
				e_i_get <= ~f_i_get;
			end
			else if (~enable_put & enable_get)
			begin
				f_i_get <= 1'b0;
				e_i_get <= ~f_i_get;
			end
			else if (enable_put & enable_get) 
			begin
				if (f_i)
				begin
					f_i_get <= 1'b0;
					e_i_get <= ~f_i_get;
				end
				else if (e_i)
				begin
					f_i_get <= 1'b1;
					e_i_get <= ~f_i_get;
				end
			end
		end
	end
	
	always @ (*)
	begin
		if (enable_put & enable_get & ~e_i & ~valid_read & f_i)
		begin
			read <= 1'b1;
			write_disable <= 1'b1;
		end
		else
		begin
			write_disable <= 1'b0;
		end
		
		if (valid_read)
		begin
			read <= 1'b0;
		end
		
		if (f_i_put)
		begin
			f_i <= 1'b1;
			e_i <= ~f_i;
		end
		else if (~f_i_get)
		begin
			f_i <= 1'b0;
			e_i <= ~f_i;
		end
	end

	// Catch the outgoing states of the controller 
	assign full  = f_i;
	assign empty = e_i;
	
	// catch the collision states by holding tokens
	assign ptok_hold = (~write_enable & write_disable);
	//assign gtok_hold = read;

endmodule

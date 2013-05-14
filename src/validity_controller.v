// Data validity controller for the mixed-clock FIFO cell
// Artem Iakovlev (ai2283)

module validity_controller 
(
	input   reset,
	input   clk_put, clk_get,
	input   enable_put, enable_get,
	output  full, empty,
	output  ptok_hold
);
	
	// Local signals for full and empty states
	//reg f_i=0;
	wire f_i;
	reg f_i_put=0; // initialize full to low (not full)
	reg f_i_get=0;
	//reg e_i=1;
	wire e_i;
	reg e_i_put=1; // initialize empty to high (empty)
	reg e_i_get=1;
	// flag for "reading in progress"
	//reg read=0;
	wire read;
	// flag for "reading done"
	reg valid_read=0;
	// flag for enabling writing when reading is finished
	reg write_enable=1;
	//reg write_disable=0;
	wire write_disable;

	// Process the state of the FIFO cell
	always @ (posedge clk_put)
	begin
		if (reset)
		begin
			f_i_put <= 1'b0;
			e_i_put <= 1'b1;
		end
		else if (~reset)
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
	end
	
	always @ (posedge clk_get)
	begin
		if (reset)
		begin
			f_i_get      <= 1'b0;
			e_i_get      <= 1'b1;
			valid_read   <= 1'b0;
			write_enable <= 1'b1;
		end
		else if (~reset)
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
	end
	
/* 	always @ (*)
	begin
		if (reset)
		begin
			read          <= 1'b0;
			write_disable <= 1'b0;
			f_i           <= 1'b0;
			e_i           <= 1'b1;
		end
		else if (~reset)
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
	end */
	
	// avoiding inferred latches
	assign f_i  = (reset ? 1'b0 : (f_i_put ? 1'b1 : (~f_i_get ? 1'b0 : 1'b1)));
	assign e_i  = (reset ? 1'b1 : ~f_i);
	assign read = (reset ? 1'b0 : ( (enable_put & enable_get & ~e_i & ~valid_read & f_i ? 1'b0 : 1'b0) | (valid_read ? 1'b0 : 1'b1) )); 
	assign write_disable = (reset ? 1'b0 : (enable_put & enable_get & ~e_i & ~valid_read & f_i ? 1'b1 : 1'b0));
	
	// Catch the outgoing states of the controller 
	assign full  = f_i;
	assign empty = e_i;
	
	// catch the collision states by holding tokens
	assign ptok_hold = (~write_enable & write_disable);
	//assign gtok_hold = read;

endmodule

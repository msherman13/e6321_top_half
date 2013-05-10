// Put Controller

module put_controller
(
	input   req_put, full, 
	output  en_put
);
	
	// Local signal for computing whether to pass the enable signal into FIFO 
	reg result=0;
	
	// Process the request to put data into FIFO
	always @ (*)
	begin
		if (req_put == 1'b1)
		begin
				// If the FIFO is not full 
			if (full == 1'b0)
				begin
					result <= 1'b1;
				end
			else
				begin	
					result <= 1'b0;
				end
		end
		else
		begin
			result <= 1'b0;
		end
	end
	
	// Catch the processed put request 
	assign en_put = result;
	
endmodule

// Get Controller
// Artem Iakovlev (ai2283)

module get_controller
(
	input   req_get, empty, 
	output  en_get
);
	
	// Local signal for computing whether to pass the enable signal into FIFO 
	reg result=0;
	
	// Process the request to get data from FIFO
	always @ (*)
	begin
		if (req_get == 1'b1)
		begin
				// If the FIFO is not full 
			if (empty == 1'b0)
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
	
	// Catch the processed get request 
	assign en_get = result;
	
endmodule

// Get Controller
// Artem Iakovlev (ai2283)

module get_controller
(
	input   reset,
	input   req_get, empty, 
	output  en_get
);
	
	// Local signal for computing whether to pass the enable signal into FIFO 
	reg result=0;
	
	// Process the request to get data from FIFO
	always @ (*)
	begin
		if (reset)
		begin
			result <= 1'b0;
		end
		else if (~reset)
		begin
			if (req_get)
			begin
					// If the FIFO is not full 
				if (~empty)
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
	end
	
	// Catch the processed get request 
	assign en_get = result;
	
endmodule

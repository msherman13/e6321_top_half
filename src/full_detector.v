// Full Detector
// Artem Iakovlev (ai2283)

module full_detector
#(parameter N_CELLS=16)
(
	input   reset,
	input  [N_CELLS-1:0] f_i,
	output  full
);
	
	// Local signal for computing the state of the FIFO 
	reg result=0;
	
	// Process the change in the state of the FIFO 
	always @ (*)
	begin
		if (reset)
		begin
			result <= 1'b0;
		end
		else if (~reset)
		begin
			// If all the FIFO cells have been filled up, detect 'full'
			if (f_i == {N_CELLS{1'b1}})
				result <= 1'b1;
			else
				result <= 1'b0;
		end
	end
	// Catch the calculated output condition of the FIFO 
	assign full = result;
	
endmodule

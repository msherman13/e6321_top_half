// Empty Detector
// Artem Iakovlev (ai2283)

module empty_detector
#(parameter N_CELLS=16)
(
	input  reset,
	input  clk,
	input  [N_CELLS-1:0] e_i,
	output  empty
);
	
	// Local signal for computing the state of the FIFO 
	reg result=1;
	reg flag=1;
	
	always @ (*)
	begin
		if (reset)
		begin
			flag <= 1'b1;
		end
		if (~reset)
		begin
			// If all the FIFO cells have been read, detect 'empty'
			if (e_i == {N_CELLS{1'b1}})
				flag <= 1'b1;
			else
				flag <= 1'b0;
		end
	end
	
	always @ (posedge clk)
	begin
		if (reset)
		begin
			result <= 1'b1;
		end
		else if (~reset)
		begin
			if (flag)
			begin
				result <= 1'b1;
			end
			else
			begin
				result <= 1'b0;
			end
		end
		
	end
	
	// Catch the calculated output condition of the FIFO 
	assign empty = result;
	
endmodule

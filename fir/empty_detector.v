// Empty Detector
// Artem Iakovlev (ai2283)

module empty_detector
#(parameter N_CELLS=16)
(
	input  clk,
	input  [N_CELLS-1:0] e_i,
	output  empty
);
	
	// Local signal for computing the state of the FIFO 
	reg result=1;
	reg flag=1;
	
	always @ (*)
	begin
		// If all the FIFO cells have been read, detect 'empty'
		if (e_i == {N_CELLS{1'b1}})
			flag <= 1'b1;
		else
			flag <= 1'b0;
	end
	
	always @ (posedge clk)
	begin
		if (flag == 1'b1)
		begin
			result <= 1'b1;
		end
		else
		begin
			result <= 1'b0;
		end
	end
	
	// Catch the calculated output condition of the FIFO 
	assign empty = result;
	
endmodule

// N-bit register cell for the mixed-clock FIFO cell

module reg_32
#(parameter N_BITS=32)
(
	input   clk,  enable_put,
	input  [N_BITS-1:0] data_put,
	output [N_BITS-1:0] data_get
);

	// Declare the shift register
	reg [N_BITS-1:0] sr=0;

	// Load the incoming N bits
	always @ (posedge clk)
	begin
		if (enable_put == 1'b1)
			sr <= data_put;
	end

	// Catch the outgoing N bits
	assign data_get = sr;

endmodule

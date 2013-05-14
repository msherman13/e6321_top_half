// N-bit register cell for the mixed-clock FIFO cell
// Artem Iakovlev (ai2283)

module reg_32
#(parameter N_BITS=32)
(
	input   reset,
	input   clk,  enable_put,
	input  [N_BITS-1:0] data_put,
	output [N_BITS-1:0] data_get
);

	// Declare the shift register
	reg [N_BITS-1:0] sr=0;

	// Load the incoming N bits
	always @ (posedge clk)
	begin
		if (reset)
		begin
			sr <= {N_BITS{1'b0}};
		end
		if (~reset)
		begin
			if (enable_put)
			begin
				sr <= data_put;
			end
		end
	end

	// Catch the outgoing N bits
	assign data_get = sr;

endmodule

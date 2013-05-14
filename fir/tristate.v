// Tristate buffer 
// Artem Iakovlev (ai2283)

module tristate 
#(parameter N_BITS=32)
(
	input   clk, enable,
	input  [N_BITS-1:0] di,
	output [N_BITS-1:0] do,
	output control_signal
);

// Local enable register
reg en=0;

always @ (posedge clk)
begin
	en <= enable;
end

assign do = (en ? di : {N_BITS{1'bZ}});
assign control_signal = en;

endmodule

// Initializer MUX

module init_mux_newest
(
	input   tok_xnor,
	output  tok_out
);

reg init=0;

always @ (*)
begin
	if (~tok_xnor)
	begin
		init <= 1'b1;
	end
end

assign tok_out = ((tok_xnor & ~init) ? 1'b1 : 1'b0);

endmodule

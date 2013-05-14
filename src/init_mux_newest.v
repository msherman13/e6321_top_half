// Initializer MUX
// Artem Iakovlev (ai2283)

module init_mux_newest
(
	input   reset,
	input   tok_xnor,
	output  tok_out
);

//reg init=0;
wire init;

/* always @ (*)
begin
	if (reset)
	begin
		init <= 1'b0;
	end
	else if (~reset)
	begin
		if (~tok_xnor)
		begin
			init <= 1'b1;
		end
	end
end */

//avoiding inferred latches
assign init = (reset ? 1'b0 : (~tok_xnor ? 1'b1 : 1'b0));

assign tok_out = ((tok_xnor & ~init) ? 1'b1 : 1'b0);

endmodule

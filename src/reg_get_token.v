// Get Token Register
// Artem Iakovlev (ai2283)

module reg_get_token
(
	input   reset,
	input   init,
	input   clk, enable, 
	input   tok_in, 
	output  tok_out
);

reg token=0;

always @ (posedge clk)
begin
	if (reset)
	begin
		token <= 1'b0;
	end
	if (~reset)
	begin
		if (enable)
		begin
			if (init)
			begin
				token <= 1'b1;
			end		
			else if (~tok_in)
			begin
				token <= 1'b0;
			end
			else
			begin
				token <= tok_in;
			end
		end
	end
end

// catch the outgoing token
assign tok_out = ((enable) ? token : 1'b0); 

endmodule 
// Token Register modified
// Artem Iakovlev (ai2283)

module reg_token_newestest
(
	input   init,
	input   clk_put, clk_get, enable, hold,
	input   tok_in, 
	output  tok_out,
	output  tok_xnor
);

reg token=0;
reg enable_out=0;
reg out_valid_put=1;
reg out_valid_get=1;
reg out_valid=1;

always @ (posedge clk_put)
begin
	if (enable)
	begin
		if (init)
		begin
			token <= 1'b1;
			out_valid_put <= 1'b1;
		end			
		else if (tok_in & ~hold & ~token)
		begin
			token <= tok_in;
			out_valid_put <= 1'b1;
		end		
		else if (hold | ~out_valid)
		begin
			token <= token;
			out_valid_put <= 1'b0;
		end		
		else
		begin
			token <= 1'b0;
			out_valid_put <= 1'b1;
		end		
	end
end

always @ (*)
begin
	if(token & ~hold)
		enable_out <= 1'b1;
	else
	begin
		enable_out <= 1'b0;
	end
end
	
always @ (posedge clk_get)
begin 
	 if(enable_out)
	 begin
		out_valid_get <= 1'b1;
	 end
	 else
	 begin
		out_valid_get <= 1'b0;
	 end
end

always @ (*)
begin
	if (out_valid_get)
	begin
		out_valid <= 1'b1;
	end
	else if (~out_valid_put & ~enable_out)
	begin
		out_valid <= 1'b0;
	end
end

assign tok_out = ((enable & ~hold & out_valid) ? token : 1'b0); 
assign tok_xnor = token;

endmodule 
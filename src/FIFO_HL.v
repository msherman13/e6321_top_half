// Mixed-clock FIFO cell
// Artem Iakovlev (ai2283)

module FIFO_HL
#(parameter N_BITS=32)
(
	input   reset,
	input   init_put, init_get,
	input   clk_put, clk_get,
	input   en_put,  en_get, 
	input   ptok_in, gtok_in,
	input   [N_BITS-1:0] data_put,
	output  [N_BITS-1:0] data_get,
	output  ptok_out, gtok_out,
	output  f_i, e_i,
	output  tok_xnor_put,
	output  hold
);
	
	wire [N_BITS-1:0] sr_out;
	// wires to connect the local token hold signal generated in the validity controller
	wire ptok_hold, gtok_hold;
	// Data is put into register cell only when locally calcuated enable put signal is true
    reg_32 register (reset, clk_put, en_put & ptok_in, data_put, sr_out);
	// Calculate the state of the FIFO cell (empty or full) 
	validity_controller controller (reset, clk_put, clk_get, en_put & ptok_in, en_get & gtok_in, f_i, e_i, ptok_hold);//, gtok_hold);
	// Latch for the data_get buffer
	tristate data_out (reset, clk_get, (en_get & gtok_in), sr_out, data_get, control_signal); // modify
	// Tokens
	reg hold_flag=0;
	reg hold_token=0;
	reg_token_newestest reg_ptok (reset, init_put, clk_put, clk_get, en_put, hold_token | ptok_hold, ptok_in, ptok_out, tok_xnor_put);
	reg_get_token reg_gtok (reset, init_get, clk_get, en_get, gtok_in, gtok_out);
	
	always @ (posedge clk_put)
	begin
		if (reset)
		begin
			hold_token <= 1'b0;
		end
		else if (~reset)
		begin
			if (hold_flag & ~control_signal) 
			begin
				hold_token <= 1'b1;
			end
			else
			begin
				hold_token <= 1'b0;
			end
		end
		
	end
	
	always @ (clk_get)
	begin
		if (reset)
		begin
			hold_flag  <= 1'b0;
		end
		else if (~reset)
		begin
			if (gtok_out)
			begin
				hold_flag <= 1'b1;
			end
			else
			begin
				hold_flag <= 1'b0;
			end
		end
	end
	
	assign hold = hold_token;
			
endmodule

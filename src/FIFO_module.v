// High-level description of the FIFO module
// Artem Iakovlev (ai2283)

module FIFO_module
#(parameter N_BITS=32, N_CELLS=16)
(
	input   reset,
	input   clk_put, clk_get,
	input   req_put,  req_get, 
	input   [N_BITS-1:0] data_put,
	output  [N_BITS-1:0] data_get,
	output  full_out, empty_out
);
/* 	// reset reg
	reg reset_sync=0;
	
	// clock-synchronous reset
	always @ (posedge clk_put)
	begin
		if (reset)
		begin
			reset_sync <= 1'b1;
		end
		else if (~reset)
		begin
			reset_sync <= 1'b0;
		end
	end */
	
	// Local signals for the data validity (full and empty) controllers,
	wire [N_CELLS-1:0] f_i;
	wire [N_CELLS-1:0] e_i;
	// calculated enable signals for put and get,
	wire en_put;
	wire en_get;
	// Wires for the FIFO cells tokens
	wire [N_CELLS-1:0] ptok;
	wire [N_CELLS-1:0] gtok;
	// hanging wires
	wire [N_CELLS-2:0] hang; 
	
	// hold wires
	wire [N_CELLS-1:0] hold;

	wire init_put, init_get, init_put_in, init_get_in;
	init_mux_newest init_ptok (reset, ~(ptok[1]^ptok[2]^ptok[3]^ptok[4]^ptok[5]^ptok[6]^ptok[7]^ptok[8]^ptok[9]^ptok[10]^ptok[11]^ptok[12]^ptok[13]^ptok[14]^ptok[15]^(tok_xnor_put)), init_put);
	init_mux_newest init_gtok (reset, ~(gtok[1]^gtok[2]^gtok[3]^gtok[0]^gtok[4]^gtok[5]^gtok[6]^gtok[7]^gtok[8]^gtok[9]^gtok[10]^gtok[11]^gtok[12]^gtok[13]^gtok[14]^gtok[15]), init_get);
	// Instantiate FIFO cells
	FIFO_HL fifo_cell0 (reset, init_put_in, init_get_in, clk_put, clk_get, en_put, en_get, init_put_in | ptok[0], init_get_in | gtok[0], data_put, data_get, ptok[1], gtok[1], f_i[0], e_i[0], tok_xnor_put, hold[0]); //, ptok_xnor[0], gtok_xnor[0]);
	FIFO_HL fifo_cell1 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[1], gtok[1], data_put, data_get, ptok[2], gtok[2], f_i[1], e_i[1], hang[0], hold[1]); //, ptok_xnor[1], gtok_xnor[1]);
	FIFO_HL fifo_cell2 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[2], gtok[2], data_put, data_get, ptok[3], gtok[3], f_i[2], e_i[2], hang[1], hold[2]); //, ptok_xnor[2], gtok_xnor[2]);
	FIFO_HL fifo_cell3 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[3], gtok[3], data_put, data_get, ptok[4], gtok[4], f_i[3], e_i[3], hang[2], hold[3]); //, ptok_xnor[3], gtok_xnor[3]);
	FIFO_HL fifo_cell4 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[4], gtok[4], data_put, data_get, ptok[5], gtok[5], f_i[4], e_i[4], hang[3], hold[4]); 
	FIFO_HL fifo_cell5 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[5], gtok[5], data_put, data_get, ptok[6], gtok[6], f_i[5], e_i[5], hang[4], hold[5]); 
	FIFO_HL fifo_cell6 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[6], gtok[6], data_put, data_get, ptok[7], gtok[7], f_i[6], e_i[6], hang[5], hold[6]); 
	FIFO_HL fifo_cell7 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[7], gtok[7], data_put, data_get, ptok[8], gtok[8], f_i[7], e_i[7], hang[6], hold[7]); 
	FIFO_HL fifo_cell8 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[8], gtok[8], data_put, data_get, ptok[9], gtok[9], f_i[8], e_i[8], hang[7], hold[8]); 
	FIFO_HL fifo_cell9 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[9], gtok[9], data_put, data_get, ptok[10], gtok[10], f_i[9], e_i[9], hang[8], hold[9]); 
	FIFO_HL fifo_cell10 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[10], gtok[10], data_put, data_get, ptok[11], gtok[11], f_i[10], e_i[10], hang[9], hold[10]); 
	FIFO_HL fifo_cell11 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[11], gtok[11], data_put, data_get, ptok[12], gtok[12], f_i[11], e_i[11], hang[10], hold[11]); 
	FIFO_HL fifo_cell12 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[12], gtok[12], data_put, data_get, ptok[13], gtok[13], f_i[12], e_i[12], hang[11], hold[12]); 
	FIFO_HL fifo_cell13 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[13], gtok[13], data_put, data_get, ptok[14], gtok[14], f_i[13], e_i[13], hang[12], hold[13]); 
	FIFO_HL fifo_cell14 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[14], gtok[14], data_put, data_get, ptok[15], gtok[15], f_i[14], e_i[14], hang[13], hold[14]); 
	FIFO_HL fifo_cell15 (reset, 1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[15], gtok[15], data_put, data_get, ptok[0], gtok[0], f_i[15], e_i[15], hang[14], hold[15]); 
	// Instantiate Full Detector
	full_detector full_det (reset, f_i, full);
	// Instantiate Empty Detector
	empty_detector empty_det (reset, clk_get, e_i, empty);
	// Instantiate Put Controller 
	put_controller put_ctrl (reset, req_put&~full_out, full, en_put);
	// Instantiate Get Controller 
	get_controller get_ctrl (reset, req_get&~empty_out, empty, en_get);
	// full calculation signal
	reg full_calc=0;
	
	assign init_put_in = (reset ? 1'b0 : init_put);
	assign init_get_in = (reset ? 1'b0 : init_get);
	
	//always @ (*)
	//begin
	//	if (reset)
	//	begin
	//		full_calc <= 1'b0;
	//	end
	//	if (~reset)
	//	begin
	//		if (hold > {N_CELLS{1'b0}})
	//		begin
	//			full_calc <= 1'b1;
	//		end
	//		else
	//		begin
	//			full_calc <= full;
	//		end
	//	end
	//end	
	assign full_out = full; //full_calc | full;
	assign empty_out = empty;
	
	endmodule 

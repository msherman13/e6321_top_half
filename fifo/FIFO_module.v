// High-level description of the FIFO module

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

	wire init_put, init_get;
	init_mux_newest init_ptok (~(ptok[1]^ptok[2]^ptok[3]^ptok[4]^ptok[5]^ptok[6]^ptok[7]^ptok[8]^ptok[9]^ptok[10]^ptok[11]^ptok[12]^ptok[13]^ptok[14]^ptok[15]^(tok_xnor_put)), init_put);
	init_mux_newest init_gtok (~(gtok[1]^gtok[2]^gtok[3]^gtok[0]^gtok[4]^gtok[5]^gtok[6]^gtok[7]^gtok[8]^gtok[9]^gtok[10]^gtok[11]^gtok[12]^gtok[13]^gtok[14]^gtok[15]), init_get);
	// Instantiate FIFO cells
	FIFO_HL fifo_cell0 (init_put, init_get, clk_put, clk_get, en_put, en_get, init_put | ptok[0], init_get | gtok[0], data_put, data_get, ptok[1], gtok[1], f_i[0], e_i[0], tok_xnor_put, hold[0]); //, ptok_xnor[0], gtok_xnor[0]);
	FIFO_HL fifo_cell1 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[1], gtok[1], data_put, data_get, ptok[2], gtok[2], f_i[1], e_i[1], hang[0], hold[1]); //, ptok_xnor[1], gtok_xnor[1]);
	FIFO_HL fifo_cell2 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[2], gtok[2], data_put, data_get, ptok[3], gtok[3], f_i[2], e_i[2], hang[1], hold[2]); //, ptok_xnor[2], gtok_xnor[2]);
	FIFO_HL fifo_cell3 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[3], gtok[3], data_put, data_get, ptok[4], gtok[4], f_i[3], e_i[3], hang[2], hold[3]); //, ptok_xnor[3], gtok_xnor[3]);
	FIFO_HL fifo_cell4 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[4], gtok[4], data_put, data_get, ptok[5], gtok[5], f_i[4], e_i[4], hang[3], hold[4]); 
	FIFO_HL fifo_cell5 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[5], gtok[5], data_put, data_get, ptok[6], gtok[6], f_i[5], e_i[5], hang[4], hold[5]); 
	FIFO_HL fifo_cell6 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[6], gtok[6], data_put, data_get, ptok[7], gtok[7], f_i[6], e_i[6], hang[5], hold[6]); 
	FIFO_HL fifo_cell7 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[7], gtok[7], data_put, data_get, ptok[8], gtok[8], f_i[7], e_i[7], hang[6], hold[7]); 
	FIFO_HL fifo_cell8 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[8], gtok[8], data_put, data_get, ptok[9], gtok[9], f_i[8], e_i[8], hang[7], hold[8]); 
	FIFO_HL fifo_cell9 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[9], gtok[9], data_put, data_get, ptok[10], gtok[10], f_i[9], e_i[9], hang[8], hold[9]); 
	FIFO_HL fifo_cell10 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[10], gtok[10], data_put, data_get, ptok[11], gtok[11], f_i[10], e_i[10], hang[9], hold[10]); 
	FIFO_HL fifo_cell11 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[11], gtok[11], data_put, data_get, ptok[12], gtok[12], f_i[11], e_i[11], hang[10], hold[11]); 
	FIFO_HL fifo_cell12 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[12], gtok[12], data_put, data_get, ptok[13], gtok[13], f_i[12], e_i[12], hang[11], hold[12]); 
	FIFO_HL fifo_cell13 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[13], gtok[13], data_put, data_get, ptok[14], gtok[14], f_i[13], e_i[13], hang[12], hold[13]); 
	FIFO_HL fifo_cell14 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[14], gtok[14], data_put, data_get, ptok[15], gtok[15], f_i[14], e_i[14], hang[13], hold[14]); 
	FIFO_HL fifo_cell15 (1'b0, 1'b0, clk_put, clk_get, en_put, en_get, ptok[15], gtok[15], data_put, data_get, ptok[0], gtok[0], f_i[15], e_i[15], hang[14], hold[15]); 
	// Instantiate Full Detector
	full_detector full_det (f_i, full);
	// Instantiate Empty Detector
	empty_detector empty_det (clk_get, e_i, empty);
	// Instantiate Put Controller 
	put_controller put_ctrl (req_put&~full_out, full, en_put);
	// Instantiate Get Controller 
	get_controller get_ctrl (req_get&~empty_out, empty, en_get);
	// full calculation signal
	reg full_calc=0;
	reg full_calc2=0;
	reg empty_calc=1;
	//full output control
	reg [N_CELLS-1:0] a=0;
	//empty output control
	reg [N_CELLS-1:0] b=0;
	
	always @ (posedge clk_put)
	begin
		/* if (req_put & req_get)
		begin
			// take care of full output
			casex (f_i)			
				16'b1111111111111001, 16'b1111111111110011,
				16'b1111111111100111, 16'b1111111111001111,
				16'b1111111110011111, 16'b1111111100111111,
				16'b1111111001111111, 16'b1111110011111111,
				16'b1111100111111111, 16'b1111001111111111,
				16'b1110011111111111, 16'b1100111111111111,
				16'b1001111111111111, 16'b0011111111111111,
				16'b0111111111111110, 16'b1111111111111100:
				begin
					full_calc <= 1'b1; 
					a <= f_i;
				end
				default: 
				begin
					full_calc <= 1'b0; 
					a <= {N_CELLS{1'b0}};
				end
			endcase
			
			if (full_calc)
			begin
				if ((f_i^a)&({N_CELLS{1'b1}}) == ~({N_CELLS{1'b0}}))
				begin
					full_calc <= 1'b0;
				end
				else if (full)
				begin
					full_calc <= 1'b1;
				end
			end
		
		// take care of empty output 
			/* casex (e_i)			
				16'b0000000000000001, 16'b0000000000000010,
				16'b0000000000000100, 16'b0000000000001000,
				16'b0000000000010000, 16'b0000000000100000,
				16'b0000000011000000, 16'b0000000010000000,
				16'b0000000100000000, 16'b0000001000000000,
				16'b0000010000000000, 16'b0000100000000000,
				16'b0001000000000000, 16'b0010000000000000,
				16'b0100000000000000, 16'b1000000000000000:
				begin
					empty_calc <= 1'b0; 
					b <= e_i;
				end
				default: 
				begin
					empty_calc <= 1'b1; 
					b <= {N_CELLS{1'b1}};
				end
			endcase
			
			if (~empty_calc)
			begin
				if ((e_i^b)&({N_CELLS{1'b1}}) == ~({N_CELLS{1'b0}}))
				begin
					empty_calc <= 1'b0;
				end
				else if (empty)
				begin
					empty_calc <= 1'b1;
				end
			end 
		end */
		
	end
	
	reg [N_CELLS-1:0] hold_temp = 0;
	
	/* always @ (*)
	begin
		hold_temp <= hold;
		if ((hold^hold_temp)&({N_CELLS{1'b1}}) == ~{N_CELLS{1'b0}})
		begin
			full_calc <= 1'b1;
		end
		else
		begin
			full_calc <= full;
			//hold_temp <= {N_CELLS{1'b0}};
		end
	end */
	
	always @ (*)
	begin
		if (hold > {N_CELLS{1'b0}})
		begin
			full_calc <= 1'b1;
		end
		else
		begin
			full_calc <= full;
		end
	end
	
	assign full_out = full_calc | full;
	assign empty_out = empty;//empty_calc | empty;
	
	endmodule 
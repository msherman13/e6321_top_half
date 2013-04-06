module d_mem(input		clk, write_en,
	     input[5:0]		addr,
	     inout[31:0]	data
	);

	//data memory

	reg[31:0] RAM[63:0];
	reg[31:0] data_out;
	
		// Tri-State Buffer control
	assign data = ~write_en? data_out : 'bz;
	
	data_out = RAM[addr];  // word aligned

	always @(posedge clk)
		if(write_en) RAM[addr] = data;
endmodule

module i_mem(input[5:0]		addr,
	     output[31:0]	instr);

	//instruction memory

	reg [31:0] RAM[63:0];

	initial
		begin
		  $readmemh("imemfile.dat", RAM);
		end
	assign instr = RAM[addr];  // word aligned
endmodule

module d_mem(input		clk, write_en,
	     input[5:0]		addr,
	     input[31:0]	write_data,
	     output[31:0]	read_data
	);

	//data memory

	reg[31:0] RAM[63:0];
	
	initial
		begin
		  $readmemh("../top_half/dmemfile.dat", RAM);
		end	
	assign read_data = RAM[addr];  // word aligned

	always @(posedge clk)
		if(write_en) RAM[addr] = write_data;
endmodule

module i_mem(input[5:0]		addr,
	     output[31:0]	instr);

	//instruction memory

	reg [31:0] RAM[63:0];

	initial
		begin
		  $readmemh("../top_half/imemfile.dat", RAM);
		end
	assign instr = RAM[addr];  // word aligned
endmodule

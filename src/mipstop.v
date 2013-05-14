module mipstop
(
	input clk, reset, accdone,
        output accbypassA,
        output [31:0] fullinstructionA,
        output [31:0] startaddrA,
        output [31:0] datasizeA
);
	wire [31:0] instr, readdata, pc;
	wire [31:0] dataaddr, writedata;
	wire memwrite;
	mipspipelined mips(clk, reset, accdone, instr, readdata, memwrite, pc, dataaddr, writedata, accbypassA, fullinstructionA, startaddrA, datasizeA);
	d_mem dm(clk, memwrite, dataaddr[7:2], writedata, readdata);
	i_mem im(pc[7:2], instr);
endmodule

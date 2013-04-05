module mipstop
(
	input clk, reset, accdone, 
	output memwrite,
	output [31:0] dataaddr,
	output [31:0] writedata,
        output accbypassA,
        output [5:0] startaddrA,
        output [5:0] datasizeA
);
	wire [31:0] instr, readdata, pc;
	mipspipelined mips(clk, reset, accdone, instr, readdata, memwrite, pc, dataaddr, writedata, accbypassA, startaddrA, datasizeA);
	d_mem dm(clk, memwrite, dataaddr[7:2], writedata, readdata);
	i_mem im(pc[7:2], instr);
endmodule

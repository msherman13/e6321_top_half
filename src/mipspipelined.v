module mipspipelined
(
	input clk, reset, accdone,
	input [31:0] instrF,
	input [31:0] readdataM,
	output memwriteM,
	output [31:0] pcF,
	output [31:0] aluoutM,
	output [31:0] writedataM,
        output accbypassA,
        output [5:0] startaddrA,
        output [5:0] datasizeA
);	
	wire [5:0] opD, functD;
	wire flushE, equalD;
	wire memtoregE, memtoregM, memtoregW;
	wire pcsrcD, branchD;
	wire [2:0] alucontrolE;
	wire alusrcE, regdstE, regwriteE, regwriteM, regwriteW;
        wire [5:0] startaddr, datasize;

	controller c(clk, reset, accdone, functD, opD, flushE, equalD,
		     jumpD, memtoregE, memtoregM, memtoregW,
		     memwriteM, pcsrcD, branchD, alucontrolE,
		     alusrcE, regdstE, regwriteE, regwriteM, regwriteW, accbypass);
	
	datapath dp(clk, reset, accbypass, instrF, readdataM, jumpD, memtoregE, memtoregM, memtoregW,
		    pcsrcD, branchD, alucontrolE, alusrcE, regdstE, regwriteE, regwriteM, regwriteW,
		    equalD, pcF, aluoutM, writedataM, opD, functD, flushE, startaddr, datasize);

        acc a(clk, reset, accdone, accbypass, startaddr, datasize, accbypassA, startaddrA, datasizeA);
endmodule


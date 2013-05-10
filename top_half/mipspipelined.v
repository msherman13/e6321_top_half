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
        output [31:0] fullinstructionA,
        output [31:0] startaddrA,
        output [31:0] datasizeA
);	
	wire [5:0] opD, functD;
	wire flushE, equalD;
	wire memtoregE, memtoregM, memtoregW;
	wire pcsrcD, branchD;
	wire [2:0] alucontrolE;
	wire alusrcE, regdstE, regwriteE, regwriteM, regwriteW;
        wire accbypass;
        wire [31:0] accfullinstruction;
        wire [31:0] fullinstruction;
        wire loadstartaddrW;
        wire loaddatasizeW;

	controller c(clk, reset, accdone, functD, opD, flushE, equalD, fullinstruction,
		     jumpD, memtoregE, memtoregM, memtoregW, memwriteM, 
                     pcsrcD, branchD, alucontrolE, alusrcE, 
                     regdstE, regwriteE, regwriteM, regwriteW, accbypass, accfullinstruction, loadstartaddrW, loaddatasizeW);
	
	datapath dp(clk, reset, accbypass, loadstartaddrW, loaddatasizeW, instrF, readdataM, jumpD, memtoregE, memtoregM, memtoregW,
		    pcsrcD, branchD, alucontrolE, alusrcE, regdstE, regwriteE, regwriteM, regwriteW,
		    equalD, pcF, aluoutM, writedataM, opD, functD, flushE, fullinstruction, startaddrA, datasizeA);

        acc a(clk, reset, accbypass, accfullinstruction, accbypassA, fullinstructionA);
endmodule


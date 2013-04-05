module datapath
(	input clk, reset, accbypass,
	input [31:0] instrF,
	input [31:0] readdataM,
	input jumpD,
	input memtoregE, memtoregM, memtoregW,
	input pcsrcD,
	input branchD,
	input [2:0] alucontrolE,
	input alusrcE,
	input regdstE,
	input regwriteE, regwriteM, regwriteW,
	output equalD,
	output [31:0] pcF,
	output [31:0] aluoutM,
	output [31:0] writedataM,
	output [5:0] opD,
	output [5:0] functD,
	output flushE,
        output [5:0] startaddr,
        output [5:0] datasize
);
	wire [31:0] pcplus4F, pcplus4D, pcbranchD, pcshD, pcnext;
	wire [31:0] instrD;
	wire [31:0] readdata1, readdata2;
	wire [31:0] resultW;
	wire [31:0] signimmD, signimmshD, signimmE;
	wire [31:0] aluoutE, aluoutW, srcaD, srcbD;
	wire [4:0] writeregE, writeregM, writeregW;
	wire [31:0] writedataE;
	wire [31:0] readdataW;

	wire [4:0] rsD, rtD, rdD, rsE, rtE, rdE;
	wire [31:0]srcaE, srcbE, srca2E, srcb2E, srcb3E;
	wire stallF, stallD;
	wire forwardAD, forwardBD;
	wire [1:0] forwardAE, forwardBE;
	wire flushD;

	assign rsD = instrD[25:21];
	assign rtD = instrD[20:16];
	assign rdD = instrD[15:11];
	assign opD = instrD[31:26];
	assign functD = instrD[5:0];
        assign startaddr = instrD[25:20];
        assign datasize = instrD[19:14];

	hazard h(rsD, rtD, rsE, rtE, memtoregE, memtoregM, regwriteE, regwriteM, regwriteW, 
	         writeregE, writeregM, writeregW, branchD, stallF, stallD, forwardAD, forwardBD,
		 forwardAE, forwardBE, flushE);

	//register file
	reg_file rg(clk, rsD, rtD, readdata1, readdata2, regwriteW, writeregW, resultW);
	
	//instruction fetch stage
	flopenr_32 pcreg(clk, reset, ~stallF, pcnext, pcF);

	//instruction decode stage
	assign flushD = jumpD | pcsrcD | accbypass;
	flopenrc_32 r1D(clk, reset, ~stallD, flushD, pcplus4F, pcplus4D);
	flopenrc_32 r2D(clk, reset, ~stallD, flushD, instrF, instrD);

	sign_ext se(instrD[15:0], signimmD);
	shift_left_2 sl1(signimmD, signimmshD);
	mux2_32 equalforwarda(readdata1, aluoutM, forwardAD, srcaD);
	mux2_32 equalforwardb(readdata2, aluoutM, forwardBD, srcbD);
	eqcmp eq(srcaD, srcbD, equalD);
	shift_left_2 sl2({6'b000000, instrD[25:0]}, pcshD);

	//next pc logic
	adder pcadder1(signimmshD, pcplus4D, pcbranchD);
	adder pcadder2(pcF, 32'b100, pcplus4F);
	mux4_32 pcmux(pcplus4F, pcbranchD, {pcplus4D[31:28], pcshD[27:0]}, pcF, {jumpD, pcsrcD}, accbypass, pcnext);
	

	//execute stage
	floprc_32 r1E(clk, reset, flushE, readdata1, srcaE);
	floprc_32 r2E(clk, reset, flushE, readdata2, srcbE);
	floprc_5 r3E(clk, reset, flushE, rsD, rsE);
	floprc_5 r4E(clk, reset, flushE, rtD, rtE);
	floprc_5 r5E(clk, reset, flushE, rdD, rdE);
	floprc_32 r6E(clk, reset, flushE, signimmD, signimmE);
	mux2_5 writedst(rtE, rdE, regdstE, writeregE);
	mux3_32 srcamux(srcaE, resultW, aluoutM, forwardAE, srca2E);
	mux3_32 srcbmux1(srcbE, resultW, aluoutM, forwardBE, srcb2E);
	mux2_32 srcbmux2(srcb2E, signimmE, alusrcE, srcb3E);
	ALU alu(srca2E, srcb3E, alucontrolE, aluoutE);

	//memory access stage
	flopr_32 r1M(clk, reset, aluoutE, aluoutM);
	flopr_32 r2M(clk, reset, srcb2E, writedataM);
	flopr_5 r3M(clk, reset, writeregE, writeregM);

	//write bace stage
	flopr_32 r1W(clk, reset, readdataM, readdataW);
	flopr_32 r2W(clk, reset, aluoutM, aluoutW);
	flopr_5 r3W(clk, reset, writeregM, writeregW);
	mux2_32 relsultmux(aluoutW, readdataW, memtoregW, resultW);

endmodule

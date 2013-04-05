module controller
(
	input clk, reset, accdone,
	input [5:0] functD, opD,
	input flushE,
	input equalD,
	output jumpD,
	output memtoregE, memtoregM, memtoregW,
	output memwriteM,
	output pcsrcD,
	output branchD,
	output [2:0] alucontrolE,
	output alusrcE,
	output regdstE,
	output regwriteE, regwriteM, regwriteW, accbypass
);

	wire [1:0] aluopD;
	wire regwriteD, memtoregD, memwriteD, alusrcD, regdstD;
	wire [2:0] alucontrolD;

	wire memwriteE;

	main_decode md(opD, accdone, reset, jumpD, memtoregD, memwriteD, branchD, aluopD, alusrcD, regdstD, regwriteD, accbypass);

	alu_decode  ad(functD, aluopD, alucontrolD);

	assign pcsrcD = branchD & equalD;

	//pipeline registers
	
	floprc_8 regE(clk, reset, flushE, 
			{regwriteD, memtoregD, memwriteD, alucontrolD, alusrcD, regdstD}, 
			{regwriteE, memtoregE, memwriteE, alucontrolE, alusrcE, regdstE});
	
	flopr_3 regM(clk, reset, {regwriteE, memtoregE, memwriteE}, {regwriteM, memtoregM, memwriteM});

	flopr_2 regW(clk, reset, {regwriteM, memtoregM}, {regwriteW, memtoregW});


endmodule

module main_decode(input [5:0] op,
                   input accdone,
                   input reset,
		   output jump,
		   output memtoreg,
		   output memwrite,
		   output branch,
		   output [1:0] aluop,
		   output alusrc,
		   output regdst,
		   output regwrite,
                   output accbypass);

	reg [8:0] controls;
        reg accbypass_reg;
	
	assign {regwrite, regdst, alusrc, branch, 
		memwrite,memtoreg, jump, aluop} = controls;
        assign accbypass = accbypass_reg;
	always @(*)
              begin
		case(op)
		   6'b000000 : controls <= 9'b110000010;  //R type
		   6'b001000 : controls <= 9'b101000000;  //ADDI
		   6'b100011 : controls <= 9'b101001000;  //LW
		   6'b101011 : controls <= 9'b001010000;  //SW
		   6'b000100 : controls <= 9'b000100001;  //BEQ
		   6'b000010 : controls <= 9'b000000111;  //J		   default:    controls <= 9'bxxxxxxxxx;  //???
		endcase
                if (reset) accbypass_reg <=0;
                else if ((op==6'b111111 | op==6'b111110) & ~accdone) accbypass_reg <= 1;
                else if (accdone) accbypass_reg <= 0;
	      end
endmodule

module alu_decode
(
	input  [5:0] funct,
	input  [1:0] aluop,
	output reg [2:0] alucontrol);

	always @(*)
		case(aluop)
		          2'b00 : alucontrol <= 3'b010;  //I-Type ADD
			  2'b01 : alucontrol <= 3'b110;  //I-Type SUB
			  default: 
			      case(funct)		 //R-Type
			          6'b100000 : alucontrol <= 3'b010;  //ADD
			          6'b100010 : alucontrol <= 3'b110;  //SUB
			          6'b100100 : alucontrol <= 3'b000;  //AND
			          6'b100101 : alucontrol <= 3'b001;  //OR
			          6'b101010 : alucontrol <= 3'b111;  //SLT
			          default :   alucontrol <= 3'bxxx;  //???
			      endcase
		  endcase
endmodule

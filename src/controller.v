module controller
(
	input clk, reset, accdone,
	input [5:0] functD, opD,
	input flushE,
	input equalD,
        input [31:0] fullinstruction,
	output jumpD,
	output memtoregE, memtoregM, memtoregW,
	output memwriteM,
	output pcsrcD,
	output branchD,
	output [2:0] alucontrolE,
	output alusrcE,
	output regdstE,
	output regwriteE, regwriteM, regwriteW, accbypass,
        output [31:0] accfullinstruction,
        output loadstartaddrW,
        output loaddatasizeW
);

	wire [1:0] aluopD;
	wire regwriteD, memtoregD, memwriteD, alusrcD, regdstD;
	wire [2:0] alucontrolD;
	wire memwriteE;
        wire loadstartaddrD, loadstartaddrE, loadstartaddrM;
        wire loaddatasizeD, loaddatasizeE, loaddatasizeM;

	main_decode md(clk, reset, opD, accdone, fullinstruction, jumpD, memtoregD, memwriteD, branchD, aluopD, alusrcD, regdstD, regwriteD, accbypass, accfullinstruction, loadstartaddrD, loaddatasizeD);

	alu_decode  ad(functD, aluopD, alucontrolD);

	assign pcsrcD = branchD & equalD;

	//pipeline registers
	
	floprc_10 regE(clk, reset, flushE, 
			{regwriteD, memtoregD, memwriteD, alucontrolD, alusrcD, regdstD, loadstartaddrD, loaddatasizeD}, 
			{regwriteE, memtoregE, memwriteE, alucontrolE, alusrcE, regdstE, loadstartaddrE, loaddatasizeE});
	
	flopr_5 regM(clk, reset, {regwriteE, memtoregE, memwriteE, loadstartaddrE, loaddatasizeE}, {regwriteM, memtoregM, memwriteM, loadstartaddrM, loaddatasizeM});

	flopr_4 regW(clk, reset, {regwriteM, memtoregM, loadstartaddrM, loaddatasizeM}, {regwriteW, memtoregW, loadstartaddrW, loaddatasizeW});


endmodule

module main_decode(input clk, reset,
                   input [5:0] op,
                   input accdone,
                   input [31:0] fullinstruction,
		   output jump,
		   output memtoreg,
		   output memwrite,
		   output branch,
		   output [1:0] aluop,
		   output alusrc,
		   output regdst,
		   output regwrite,
                   output reg accbypass,
                   output reg [31:0] accfullinstruction,
                   output reg loadstartaddr,
                   output reg loaddatasize);

	reg [8:0] controls;
	
	assign {regwrite, regdst, alusrc, branch, 
		memwrite,memtoreg, jump, aluop} = controls;

	always @(*)
              begin
		if (op == 6'b000000) 
                begin
                  controls = 9'b110000010;  //R type
                  loadstartaddr = 0;
                  loaddatasize = 0;
                end
		else if (op == 6'b001000) 
                begin
                  controls = 9'b101000000;  //ADDI
                  loadstartaddr = 0;
                  loaddatasize = 0;
                end
                else if (op == 6'b100011)
                begin
                  controls = 9'b101001000;  //LW
                  loadstartaddr = 0;
                  loaddatasize = 0;
                end
                else if (op == 6'b101011)
                begin
                  controls = 9'b001010000;  //SW
                  loadstartaddr = 0;
                  loaddatasize = 0;
                end
                else if (op == 6'b000100)
                begin
                  controls = 9'b000100001;  //BEQ
                  loadstartaddr = 0;
                  loaddatasize = 0;
                end
                else if (op == 6'b000010)
                begin
                  controls = 9'b000000111;  //J
                  loadstartaddr = 0;
                  loaddatasize = 0;
                end
                else if (op == 6'b111110) 
                begin
                  controls = 9'b001001000;  //loadstartaddr
                  loadstartaddr = 1;
                  loaddatasize = 0;
                end
                else if (op == 6'b111101) 
                begin 
                  controls = 9'b001001000;  //loaddatasize
                  loadstartaddr = 0;
                  loaddatasize = 1;
                end
                else if (op == 6'b111111)
                begin
                  controls = 9'b000000000;  //accelerator
                  loadstartaddr = 0;
                  loaddatasize = 0;
                end
                //else controls = 9'bxxxxxxxxx;  //???
               end

         always @(negedge clk)
               begin
                 if (reset | accdone == 1)
                 begin
                   accbypass <= 0;
                   accfullinstruction <= 0;
                 end
                 else if (op == 6'b111111)
                 begin
                   accbypass <= 1;
                   accfullinstruction <= fullinstruction;
                 end
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

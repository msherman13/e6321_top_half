// 32 bit sin calculator. Floating point.
// Using taloy serires
//
// Author Chengyuan Ma
//
module sinecalculator(
			clk,
			clk_enable,
			reset,
			data_in,
			save_enable,
			sin_data_out
			);
				
	input clk;
	input clk_enable;
	input reset;
	input save_enable;
	
	input [31:0] data_in;
	output [31:0] sin_data_out;
	wire [4:0] add_cont=5'b00000;
	wire [4:0] sub_cont=5'b10000;
	
	
	wire [31:0] m1=data_in;
	wire [31:0] m2;
	wire [31:0] m3;
	wire [31:0] m4;
	wire [31:0] m5;
	wire [31:0] prod1;
	wire [31:0] d2=32'b00111110001010101010101010101011;
	wire [31:0] d3=32'b00111100000010001000100010001000;
	wire [31:0] d4=32'b00111001010100000000110011010001;
	wire [31:0] d5=32'b00110110001110001110111100011101;
	wire [31:0] dr2;
	wire [31:0] dr3;
	wire [31:0] dr4;
	wire [31:0] dr5;
	wire [4:0]  flags;
	wire [4:0] flags1;
	wire [4:0] flags2;
	wire [4:0] flags3;
	wire [4:0] flags4;
	wire [4:0] flags5;
	wire [4:0] flags6;
	wire [4:0] flags7;
	wire [4:0] flags8;
	wire [4:0] flags9;
	wire [4:0] flags10;
	wire [4:0] flags11;
	wire [4:0] flags12;
	wire [31:0] ad12;
	wire [31:0] ad34;
	wire [31:0] ad345;


		fpmul mul1(data_in,m1,prod1,add_cont,flags);
		fpmul mul2(m1,prod1,m2,add_cont,flags1);
		fpmul mul3(m2,prod1,m3,add_cont,flags2);
		fpmul mul4(m3,prod1,m4,add_cont,flags3);
		fpmul mul5(m4,prod1,m5,add_cont,flags4);
		//divide by sth
		fpmul mul6(m2,d2,dr2,add_cont,flags5);
		fpmul mul7(m3,d3,dr3,add_cont,flags6);
		fpmul mul8(m4,d4,dr4,add_cont,flags7);
		fpmul mul9(m5,d5,dr5,add_cont,flags8);
		
		fpadd add1(m1,dr2,ad12,sub_cont,flags9);
		fpadd add2(dr3,dr4,ad34,sub_cont,flags10);
		fpadd add3(ad34,dr5,ad345,add_cont,flags11);
		fpadd add4(ad12,ad345,sin_data_out,add_cont,flags12);
			 
	endmodule
	

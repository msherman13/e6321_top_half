//*************************************************************************
// test binary to flaoting 
// 
// 
//
// input 16bit data_in
// 
//
// Author: Chengyuan Ma
//**************************************************************************




module test_mul;
reg[31:0] data_in_a;
reg[31:0] data_in_b;
reg[4:0] control;
wire[31:0] data_out;
wire[4:0] flags;
reg clk,clk_enable,reset;


//fpadd(a, b, result, control, flags)
fpmul dut(data_in_a,data_in_b,data_out,control,flags);

initial
	begin
	clk=1'b0;
	reset=1'b0;
	control=5'b0;
	
	#100

	data_in_a<=32'b01000011101000000011001100110011;
	data_in_b<=32'b01000001011000110011001100110011;
 end
	
	
	
	always begin
	#20 clk = ~clk;
	end
	endmodule 
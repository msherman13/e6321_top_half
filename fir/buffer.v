//************************************************************
//  buffur of FIR seiries in, parallel out
//
//   Author Chengyuan Ma
//************************************************************


module buffer
               (
                clk,
                enable,
                reset,
				
				
                data_in,
                Low_data_out,
				Hi_data_out,
				select,
				flags
                );
				
				
input clk;
input enable;
input reset;
input [31:0] data_in;
output [31:0] Low_data_out;
output [31:0] Hi_data_out;
output [31:0] select;
output flags;

//reg [31:0] Hi_data_out;
//reg [31:0] Low_data_out;
//reg flags;
wire [7:0] num1;
assign num1=8'b00000011;

flipflopHbu FIR_BU_F1(clk,enable,flags,reset,data_in,data_out1);
flipflopHbu FIR_BU_F2(clk,enable,flags,reset,data_out1,data_out2);
flipflopHbu FIR_BU_F3(clk,enable,flags,reset,data_out2,data_out3);
counter FIR_buff1(clk,enable,reset,flags,num1);	

assign Low_data_out=data_out3;
assign Hi_data_out=data_out2;
assign select=data_out1;	
endmodule

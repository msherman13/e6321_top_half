//****************************************************************************
// 32 bit flipflop for buffer
// clk_enable will open flip-flop
// reset will clean all values
// Author: Chengyuan Ma
//
//****************************************************************************

module flipflopHbu
               (
                clk,
                enable,
				flags,
                reset,
				
				
                data_in,
                data_out
                );
				
input clk;
input enable;
input reset;
input [31:0] data_in;
output [31:0] data_out;
reg [31:0] data_out;
input flags;

always @ (posedge clk)
if (reset==1)
    data_out<=32'b00000000000000000000000000000000;
else if (enable==1 && flags==0)//if ( clk_enable==1);
data_out<=data_in;
endmodule

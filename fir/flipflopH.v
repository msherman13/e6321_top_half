//****************************************************************************
// 32 bit flipflop
// clk_enable will open flip-flop
// reset will clean all values
// Author: Chengyuan Ma
//
//****************************************************************************


module flipflopH
               (
                clk,
                enable,
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


always @ (posedge clk)
if (reset==1)
    data_out<=32'b00000000000000000000000000000000;
else if (enable==1)
begin//if ( clk_enable==1);
data_out<=data_in;
end
endmodule







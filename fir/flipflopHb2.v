module flipflopHb2
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
input [1:0] data_in;
output [1:0] data_out;
reg [1:0] data_out;


always @ (posedge clk)
if (reset==1)
    data_out<=2'b00;
else if (enable==1)
begin//if ( clk_enable==1);
data_out<=data_in;
end
endmodule

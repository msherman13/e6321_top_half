//************************************************************
//  8 bit counter
//
//  return a "1" if centain value is reached
//
//   Author Chengyuan Ma
//************************************************************

module counter (
	clk,
	start,
	reset,
	flags,
	num
	);
	
	input clk;
	input start;
	input reset;
	input [7:0] num;
	output flags;
	
	reg flags;
	reg [7:0] temp;
	//wire enable;	
	//wire gnd=0;
	//wire vdd=1;

	
   // assign enable = start? 1'b1 : 
    //                flags? 1'b0 :
    //                1'b0;
    

	
	always @(posedge clk) begin
	 
		if (reset==1) begin
		   temp<=8'b00000000;
		   flags<=1'b0;
		end
		else if (start==1)begin
		    temp<=temp+1;
			if (temp==num) begin
				flags<=1'b1;

			end	
		end
		end
	
	endmodule
	
	

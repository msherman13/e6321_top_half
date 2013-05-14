`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:16:23 03/30/2013 
// Design Name: 
// Module Name:    sin_arg_adjust 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sin_arg_adjust(
    clk,
    reset,
    enable,
    input_data,
    output_data
    );
    
    
    input clk;
    input reset;
    input enable;
    input [31:0] input_data;
    output [31:0] output_data;

reg neg_flag=0;
reg [1:0] check;
reg [31:0] temp=0;
reg [31:0] temp2=0;
reg [31:0] pi_half=32'b00111111110010010000111111011011;
reg [31:0] pi=32'b01000000010010010000111111011011;
reg [31:0] pi_three_over_two=32'b01000000100101101100101111100100;
reg [31:0] two_pi=32'b01000000110010010000111111011011;
reg [31:0] neg_pi_half=32'b10111111110010010000111111011011;
reg [31:0] neg_pi=32'b11000000010010010000111111011011;
reg [31:0] neg_pi_three_over_two=32'b11000000100101101100101111100100;
reg [31:0] neg_two_pi=32'b11000000110010010000111111011011;
wire [31:0] temp4;
wire [31:0] temp5;
wire [31:0] temp6;
wire [31:0] temp7;
wire [31:0] temp8;
reg [4:0] control_saa=0;
reg [4:0] control_minus=5'b10000;
reg [4:0] control_plus=5'b00000;
wire [4:0] flags;
wire [4:0] flags1;
wire [4:0] flags2;
wire [4:0] flags3;
wire [4:0] flags4;
wire [4:0] flags5;
wire [4:0] flags6;



reg [31:0] output_data;

fpadd arg_adj1(pi,temp2,temp4,control_minus,flags);
fpadd arg_adj2(temp2,pi,temp5,control_minus,flags1);
fpadd arg_adj3(temp2,pi_half,temp6,control_minus,flags2);
fpadd arg_adj4(temp2,two_pi,temp7,control_minus,flags3);
fpadd arg_adj5(two_pi,temp2,temp8,control_minus,flags4);

//fpadd too_big_arg(input_data, two_pi, smaller, control_minus,flags5);
//fpadd too_small_arg(input_data, two_pi, bigger, control_minus, flags6);

always @(posedge clk) begin
	temp2=input_data;
	temp=temp2;
	check=2'b00;
	neg_flag=0;
	if (temp2[31]==1) begin
		temp2[31]=1'b0;
		neg_flag=1'b1;
	end
	// if (temp2>neg_two_pi) begin
		// temp=bigger;
		// temp2=bigger;
	// end else if(temp2>two_pi) begin
		// temp=smaller;
		// temp2=smaller;
	// end
		
	if (temp2> pi_half && (temp2<pi || temp2 == pi)) begin //>90 <=180
		temp=temp4;
		if (neg_flag==1) begin
			temp=temp5;
		end
		check=2'b01;
	end else if (temp2> pi && (temp2< pi_three_over_two || temp2 == pi_three_over_two)) begin	//>180 <=270
		temp=temp4;
		if (neg_flag==1) begin
			temp=temp5;
		end
		check=2'b10;
	end else if (temp2>pi_three_over_two && (temp2<two_pi || temp2 == two_pi)) begin	//>270 <=360
		temp=temp8;
		if (neg_flag==0) begin
			temp=temp8;
		end
		check=2'b11;
	end
	output_data=temp;
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:35:23 03/29/2013 
// Design Name: 
// Module Name:    bin_to_float 
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
module bin_to_float(
  clk,
    reset,
    enable,
   btf_data_input,
      btf_data_output
    );
    input clk;
    input reset;
    input enable;
    input [15:0] btf_data_input;
    output [31:0] btf_data_output;
	reg [31:0] btf_data_output;
	reg [15:0] temp;
always@(posedge clk) 
	if (reset==1) begin
		btf_data_output<=32'b0;
	end else begin
		
	btf_data_output[31]<=btf_data_input[15];
	temp<=btf_data_input[14:0];
	btf_data_output[7:0]<=0;
		
	if (btf_data_input[14]==1'b1)begin
		btf_data_output[30:23]<=141;
		btf_data_output[22:8]<=temp<<1;
	end else if (btf_data_input[13]==1'b1) begin
		btf_data_output[30:23]<=140;
		btf_data_output[22:8]<=temp<<2;
	end else if (btf_data_input[12]==1'b1) begin
		btf_data_output[30:23]<=139;
		btf_data_output[22:8]<=temp<<3;
	end else if (btf_data_input[11]==1'b1) begin
		btf_data_output[30:23]<=138;
		btf_data_output[22:8]<=temp<<4;
	end else if (btf_data_input[10]==1'b1) begin
		btf_data_output[30:23]<=137;
	   btf_data_output[22:8]<=temp<<5;
	end else if (btf_data_input[9]==1'b1) begin
		btf_data_output[30:23]<=136;
	    btf_data_output[22:8]<=temp<<6;
	end else if (btf_data_input[8]==1'b1) begin
		btf_data_output[30:23]<=135;
	    btf_data_output[22:8]<=temp<<7;
	end else if (btf_data_input[7]==1'b1) begin
		btf_data_output[30:23]<=134;
	   btf_data_output[22:8]<=temp<<8;
	end else if (btf_data_input[6]==1'b1) begin
		btf_data_output[30:23]<=133;
		btf_data_output[22:8]<=temp<<9;
	end else if (btf_data_input[5]==1'b1) begin
		btf_data_output[30:23]<=132;
		btf_data_output[22:8]<=temp<<10;
	end else if (btf_data_input[4]==1'b1) begin
		btf_data_output[30:23]<=131;
		btf_data_output[22:8]<=temp<<11;
	end else if (btf_data_input[3]==1'b1) begin
		btf_data_output[30:23]<=130;
		btf_data_output[22:8]<=temp<<12;
	end else if (btf_data_input[2]==1'b1) begin
		btf_data_output[30:23]<=129;
		btf_data_output[22:8]<=temp<<13;
	end else if (btf_data_input[1]==1'b1) begin
		btf_data_output[30:23]<=128;
		btf_data_output[22:8]<=temp<<14;
	end else if (btf_data_input[0]==1'b1) begin
		btf_data_output[30:23]<=127;
		btf_data_output[22:8]<=temp<<15;
		end
	end
endmodule

/******************************************************************************
**
** Module:      filt_address_calc
** Description: Top level of address calculation for 1by1 word accelerators.
**		Filesize is measures in quantity of 128-bit "words".
**
** Author:      Miles Sherman
** Affiliation: Columbia University
**
** Last Update: 03/08/2013
**
******************************************************************************/

module fft_out_address_calc (offset, filesize, enable, pause, clk, addr, done);
	input [31:0] offset, filesize;
	input enable, pause, clk;
	output [31:0] addr;
	output done;
	
	wire [31:0] count;

	counter2 counter (.filesize(filesize),.enable(enable), .pause(pause), .clk(clk),.count(count), .done(done));
	
	adder32b adder (.a(offset), .b(count), .clk(clk), .s(addr));
	
endmodule

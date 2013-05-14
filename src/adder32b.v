/******************************************************************************
**
** Module:      adder32b
** Description: 32-bit adder with no carry in or carry out. For address calc.
**
** Author:      Miles Sherman
** Affiliation: Columbia University
**
** Last Update: 03/08/2013
**
******************************************************************************/

module adder32b (a, b, s);
	input [31:0] a;
	input [31:0] b;
	output [31:0] s;


	assign s = a + b;

endmodule

module ALU(
	   input      [31:0]	 a, b,
	   input      [2:0]	 alucont,
	   output reg [31:0]     result
);
	
	wire [31:0] b2, sum, slt;
	assign b2 = alucont[2] ? ~b : b;
	assign sum = a + b2 + alucont[2];
	assign slt = sum[31];

	always @(*)
		case(alucont[1:0])
		  2'b00: result <= a & b;
		  2'b01: result <= a | b;
		  2'b10: result <= sum;
		  2'b11: result <= slt;
		endcase
	
endmodule


module adder(input  [31:0] a, b,
	     output [31:0] sum);

	     assign sum = a + b;
endmodule

module shift_left_2(input  [31:0] a,
		    output [31:0] b);

 //shift left by 2
	assign b = {a[29:0], 2'b00};
endmodule

module sign_ext(input  [15:0] a,
		output [31:0] b);
	assign b = {{16{a[15]}}, a};
endmodule

module mux2_32
	(input  [31 : 0] d0, d1,
	 input              s,
	 output [31 : 0] y);
	assign y = s ? d1 : d0;
endmodule

module mux2_5
	(input  [4 : 0] d0, d1,
	 input              s,
	 output [4 : 0] y);
	assign y = s ? d1 : d0;
endmodule

module mux3_32
	(input [31 : 0] d0, d1, d2,
	 input [1:0] s,
	 output [31 : 0] y);
	
	assign y = s[1] ? d2 : (s[0] ? d1 : d0);

endmodule

module mux4_32
	(input [31 : 0] d0, d1, d2, d3,
	 input [1:0] s,
	 input stall,
	 output [31 : 0] y);
	
	assign y = stall ? d3 : (s[1] ? d2 : (s[0] ? d1 : d0));

endmodule

module reg_file(input        clk,
		input [4:0]  addr1, addr2,
		output [31:0] rd_data1, rd_data2,
		input        write_en,
		input [4:0]  addr3,
		input [31:0] write_data);

	reg [31:0] regfile[31:0];
  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clock
  // register 0 hardwired to 0

	assign rd_data1 = (addr1 != 0) ? regfile[addr1] : 0;
	assign rd_data2 = (addr2 != 0) ? regfile[addr2] : 0;
	
	always @(negedge clk)  //注意是下降沿触发
		if (write_en) regfile[addr3] <= write_data;

endmodule

module flopr_32
(
	input			clk, reset,
	input	    [31 : 0]	d,
	output  reg [31 : 0]	q);

	always @(posedge clk, posedge reset)
		if(reset) q <= 0;
		else q <= d;
endmodule

module flopr_5
(
	input			clk, reset,
	input	    [4 : 0]	d,
	output  reg [4 : 0]	q);

	always @(posedge clk, posedge reset)
		if(reset) q <= 0;
		else q <= d;
endmodule

module flopr_3
(
	input			clk, reset,
	input	    [2 : 0]	d,
	output  reg [2 : 0]	q);

	always @(posedge clk, posedge reset)
		if(reset) q <= 0;
		else q <= d;
endmodule

module flopr_2
(
	input			clk, reset,
	input	    [1 : 0]	d,
	output  reg [1 : 0]	q);

	always @(posedge clk, posedge reset)
		if(reset) q <= 0;
		else q <= d;
endmodule

module floprc_32
	(input clk, reset, clear,
	 input [31 : 0] d,
	 output reg [31 : 0] q);

	 always @(posedge clk, posedge reset)
	     begin
	         if(reset) q <= 0;
		 else if(clear) q <= 0;
		 else q <= d;
	     end
endmodule

module floprc_8
	(input clk, reset, clear,
	 input [7 : 0] d,
	 output reg [7 : 0] q);

	 always @(posedge clk, posedge reset)
	     begin
	         if(reset) q <= 0;
		 else if(clear) q <= 0;
		 else q <= d;
	     end
endmodule

module floprc_5
	(input clk, reset, clear,
	 input [4 : 0] d,
	 output reg [4 : 0] q);

	 always @(posedge clk, posedge reset)
	     begin
	         if(reset) q <= 0;
		 else if(clear) q <= 0;
		 else q <= d;
	     end
endmodule

module flopenr_32
	(input clk, reset, en,
	 input [31 : 0] d,
	 output reg [31 : 0] q);

	 always @(posedge clk, posedge reset)
	     begin
	         if(reset) q <= 0;
		 else if(en) q <= d;
	     end
endmodule

module flopenrc_32
	(input clk, reset, en, clear,
	 input [31 : 0] d,
	 output reg [31 : 0] q);

	always @(posedge clk, posedge reset)
	    begin
	        if(reset) q <= 0;
		else if(clear) q <= 0;
		else if(en) q <= d;
	    end
endmodule

module eqcmp
(
     input [31 : 0] a, b,
     output y
);

     assign y = (a == b);
endmodule

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
		  2'b00: result = a & b;
		  2'b01: result = a | b;
		  2'b10: result = sum;
		  2'b11: result = slt;
		endcase
	
endmodule


module adder(input  [31:0] a, b,
	     output reg [31:0] sum);

	     always @(*) 
                   sum = a + b;

endmodule

module shift_left_2(input  [31:0] a,
		    output reg [31:0] b);

	always @(*)
              b = {a[29:0], 2'b00};

endmodule

module sign_ext(input  [15:0] a,
		output reg [31:0] b);

	always @(*)
              b = {{16{a[15]}}, a};

endmodule

module mux2_32
	(input  [31 : 0] d0, d1,
	 input              s,
	 output reg [31 : 0] y);

	always @(*)
              if (s == 1) y = d1;
              else y = d0;

endmodule

module mux2_5
	(input  [4 : 0] d0, d1,
	 input              s,
	 output reg [4 : 0] y);

	always @(*)
              if (s == 1) y = d1;
              else y = d0;

endmodule

module mux3_32
	(input [31 : 0] d0, d1, d2,
	 input [1:0] s,
	 output reg [31 : 0] y);
	
	always @(*)
              if (s[1] == 1) y = d2;
              else if (s[0] == 1) y = d1;
              else y = d0;

endmodule

module mux4_32
	(input [31 : 0] d0, d1, d2, d3,
	 input [1:0] s,
	 input stall,
	 output reg [31 : 0] y);
	
	always @(*)
              if (stall == 1) y = d3;
              else if (s[1] == 1) y = d2;
              else if (s[0] == 1) y = d1;
              else y = d0;

endmodule

module reg_file(input        clk,
		input [4:0]  addr1, addr2,
		output reg [31:0] rd_data1, rd_data2,
		input        write_en,
		input [4:0]  addr3,
		input [31:0] write_data);

	reg [31:0] regfile[31:0];
  // three ported register file
  // read two ports combinationally
  // write third port on rising edge of clock
  // register 0 hardwired to 0

	always @(*)
              begin
                if (addr1 != 0) rd_data1 = regfile[addr1];
                else rd_data1 = 0;
                if (addr2 != 0) rd_data2 = regfile[addr2];
                else rd_data2 = 0;
              end
	
	always @(negedge clk)  //writeback at every negative clock edge
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

module flopr_4
(
	input			clk, reset,
	input	    [3 : 0]	d,
	output  reg [3 : 0]	q);

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

module floprc_10
	(input clk, reset, clear,
	 input [9 : 0] d,
	 output reg [9 : 0] q);

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
     output reg y
);
     always @(*)
           if (a == b) y = 1;
           else y = 0;
endmodule

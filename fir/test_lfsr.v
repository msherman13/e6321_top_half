`include "./const_tb.v"
`define SD #1000

module testbench();

   reg clk, resetn;

   wire [15:0] lfsr_out;
   integer i;

   lfsr1 lfsr_0 ( .clk(clk), .resetn(resetn), .lfsr_out(lfsr_out) );

   always begin
      `HALF_CLOCK_PERIOD;
      clk = ~clk;
   end

   initial begin
       clk = 0;
       resetn = 0;
       @(posedge clk);
       @(posedge clk);
       resetn = 1;
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
       @(posedge clk);
	   for (i=0 ; i<200; i=i+1)
	   begin
			@(posedge clk);
	   end
       $finish;
   end 

endmodule // testbench


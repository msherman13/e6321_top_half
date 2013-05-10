// EXTENSIVE TESTBENCH FOR THE MIXED-CLOCK FIFO
// ARTEM IAKOVLEV (ai2283)

`timescale 1ns / 1ps
module testbench_FIFO_extensive;


  reg [31:0] mem_in [0:44100];
  reg [31:0] mem_out[0:44119];
  

  integer h;
  integer ini;
  integer k;
  integer j;
  integer i;
  integer m;
  integer w;
  reg reset;
  reg clk_put;
  reg clk_get;
  reg req_put;
  reg req_get;
  reg [31:0] data_put;
  wire [31:0] data_get;
  wire full_out, empty_out;  
  
  FIFO_module dut(reset, clk_put, clk_get, req_put, req_get, data_put, data_get, full_out, empty_out);

  always begin
  #22 clk_get = ~clk_get;
end
 always begin
  #8 clk_put=~clk_put;
end  
  initial
    begin
	$readmemb("data_in.txt", mem_in);
    m=$fopen("data_out_fifo.txt","wb");
	w=$fopen("data_out_fifo2.txt","wb");
	
	clk_put=1'b0;
	clk_get=1'b0;
	req_put=1'b0;
	req_get=1'b0;
	data_put={32{1'b0}};
	ini=1'b1;
	
    reset=1'b1;	  
	  
    #30
	reset=1'b0;

	
	i=0;
    h=0;
    while (i <= 44100) begin

			if (~full_out)
			begin
				req_put <= 1'b1;
			end
			else
			begin
				req_put <= 1'b0;
			end

			if (empty_out)
			begin
				req_get <= 1'b0;
			end
			else
			begin
				req_get <= 1'b1;
			end
		@ (posedge clk_put)
		#1
			if (~full_out)
			begin
				data_put=mem_in [i];
				i=i+1;
			end		
		//@ (posedge clk_get)
		//	if (~empty_out) 
		//	begin
		//		mem_out[h]=data_get;
		//		h=h+1;
		//	end

    end
	
    for(j = 0; j <= 44119; j = j + 1)
    begin
		$fwrite(m,"%b\n",mem_out[j]);
		$fwrite(w,"%b",mem_out[j]);
    end
    $fclose(m);
	$fclose(w);
end

always@ (posedge clk_get) begin
			if (~empty_out) 
			begin
				#22
				mem_out[h]=data_get;
				h=h+1;
			end
end

endmodule 
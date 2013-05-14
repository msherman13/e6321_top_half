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
	  
	// new fifo
	reg [15:0] reserve;         // reserve space constant
	reg [2:0] wr_sync_cntrl;    // Config input for wr side synchronizer
	reg clk_put;                // clock coming from write side of FIFO -- write signals
	reg [31:0] data_put; 		  // data to be written  
	reg req_put;          	  // write side data is valid for writing to FIFO
	reg delay_sel;        	  // choose one/two delay cell for input data
	wire not_full;        	  // low= Full or utilizing reserve space, else NOT FULL
	wire empty;           	  // true if empty, but referenced to write side
	reg reset;            	  // synchronous to read clock  --------------------------
	reg clk_get;          	  // clock coming from read side of FIFO  -- read signals 
	wire [31:0] data_get; 	  // data to be read  
	wire empty_ignore;    	  // FIFO is EMPTY (combinational in from 1st stage of FIFO)
	reg req_get;          	  // asks the FIFO for data
	wire full;            	  // true if FIFO is in reserve, but referenced to read side
	reg [2:0] rd_sync_cntrl;    // Config input for rd side synchronizer
	reg nap;                 	  // no increment read pointer signal
	wire [1:0] fifo_util;       // FIFO utilization, used for DVFS
	  
	FIFO dut(reserve,wr_sync_cntrl,clk_put,data_put,req_put,delay_sel,not_full,empty,reset,clk_get,data_get,empty_ignore,req_get,full,rd_sync_cntrl,nap,fifo_util);

	always 
	begin
		#8 clk_get = ~clk_get;
	end
	always 
	begin
		#22 clk_put=~clk_put;
	end  
	
	initial
	begin
		$readmemb("data_in.txt", mem_in);
		m=$fopen("data_out_fifo.txt","wb");
		w=$fopen("data_out_fifo2.txt","wb");
		
		clk_put = 1'b0;
		clk_get = 1'b0;
		req_put = 1'b0;
		req_get = 1'b0;
		data_put = {32{1'b0}};
		ini = 1'b1;
		// Reserve space constant
		reserve = {16{1'b0}};
		// Write and Read number of registers in the asynchronous communication beween the two frequencies
		wr_sync_cntrl = {3{1'b0}};
		rd_sync_cntrl = {3{1'b0}};
		// Delay Select, set how much delay you want in the FIFO
		delay_sel = 2'b00;
		// No Increment Read pointer signal
		nap = 1'b0;
		// reset high
		reset=1'b1;	  
		  
		#30
		reset=1'b0;

		i=0;
		h=0;
		
		while (i <= 44100) begin

			if (~full)
			begin
				req_put <= 1'b1;
			end
			else
			begin
				req_put <= 1'b0;
			end
			
			if (empty)
			begin
				req_get <= 1'b0;
			end
			else
			begin
				req_get <= 1'b1;
			end
			@ (posedge clk_put)
			#1
				if (~full)
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
		
		for (k=44035;k<=44101;k=k+1)begin
			@ (posedge clk_get)
			#1
				mem_out[k]=data_get;
		end
		
		for(j = 2; j <= 44035; j = j + 1)
		begin
			$fwrite(m,"%b\n",mem_out[j]);
			$fwrite(w,"%b",mem_out[j]);
		end
		$fclose(m);
		$fclose(w);
	end

	always @ (posedge clk_get) begin
		if (~empty) 
		begin
		#1
			mem_out[h]=data_get;
			h=h+1;
		end
	end

endmodule 
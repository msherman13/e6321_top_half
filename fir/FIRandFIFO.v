module FIRandFIFO
(
	data_put,
	CLK_put,
	CLK_get,
	req_put,
	full_to_bus,
	
	data_to_bus,
	empty_to_bus,
	req_get_frombus,
	
	bandlow,
	bandhi,	
	filter_select,
	reset,
	start_coe
);
		input [31:0] data_put;
		input CLK_put;
		input CLK_get;
		input req_put;

		input reset;
		input [15:0] bandlow;
		input [15:0] bandhi;
		input [1:0] filter_select;
        input start_coe;  
		  
		output full_to_bus;
		
		output [31:0] data_to_bus;
		output empty_to_bus;
		input req_get_frombus;
		
		
		wire [31:0] data_get;
		wire [31:0] data_out;
		wire req_get;
		wire empty;
		wire start_toread;
		wire full;
		wire hold;
		
		// new fifo
	reg [15:0] reserve_in=0;         // reserve space constant
	reg [15:0] reserve_out=0;
	reg [2:0] wr_sync_cntrl_in=0;    // Config input for wr side synchronizer 
	reg [2:0] wr_sync_cntrl_out=0;
	reg [1:0] delay_sel_in=0;        	  // choose one/two delay cell for input data
	reg [1:0] delay_sel_out=0;
	wire not_full_in;        	  // low= Full or utilizing reserve space, else NOT FULL
	wire not_full_out;
	wire empty_ignore_in;    	  // FIFO is EMPTY (combinational in from 1st stage of FIFO)
	wire empty_ignore_out;
	reg [2:0] rd_sync_cntrl_in=0;    // Config input for rd side synchronizer
	reg [2:0] rd_sync_cntrl_out=0;
	reg nap_in=0;                 	  // no increment read pointer signal
	reg nap_out=0;
	wire [1:0] fifo_util_in;       // FIFO utilization, used for DVFS
	wire [1:0] fifo_util_out; 
	  
	or FIRandFIFO_and(hold,full,empty);
	// new fifo in
	//FIFO dut(reserve,wr_sync_cntrl,clk_put,data_put,req_put,delay_sel,not_full,empty,reset,clk_get,data_get,empty_ignore,req_get,full,rd_sync_cntrl,nap,fifo_util);
	//FIFO FIFO_in(reserve_in,wr_sync_cntrl_in,CLK_put,data_put,req_put,delay_sel_in,not_full_in,empty,reset,CLK_get,data_get,empty_ignore_in,req_get,full_to_bus,rd_sync_cntrl_in,nap_in,fifo_util_in);
	// old fifo in
	FIFO_module FIFO_in(reset,CLK_put,CLK_get, req_put,req_get,data_put,data_get,full_to_bus,empty);
		
	Top_FIR FIRandFIFO_FIR(CLK_get,reset,bandlow,bandhi,filter_select,data_get,data_out,start_coe,start_toread,req_get,hold);
	// new fifo out
	//FIFO dut(reserve,wr_sync_cntrl,clk_put,data_put,req_put,delay_sel,not_full,empty,reset,clk_get,data_get,empty_ignore,req_get,full,rd_sync_cntrl,nap,fifo_util);
	FIFO_module FIFO_out(reset,CLK_get,CLK_put, start_toread,req_get_frombus,data_out,data_to_bus,full,empty_to_bus);
	// old fifo out
	//FIFO FIFO_out(reset,CLK_get,CLK_put, start_toread,req_get_frombus,data_out,data_to_bus,full,empty_to_bus);
	
	
	always @(posedge CLK_put) 
	begin
		if (reset)
		begin
			reserve_in        <= {16{1'b0}};
			reserve_out       <= {16{1'b0}};
			wr_sync_cntrl_in  <= {3{1'b0}};
			wr_sync_cntrl_out <= {3{1'b0}};
			delay_sel_in      <= 2'b00;
			delay_sel_out     <= 2'b00;
			rd_sync_cntrl_in  <= {3{1'b0}};
			rd_sync_cntrl_out <= {3{1'b0}}; 
			nap_in            <= 1'b0;
			nap_out           <= 1'b0;
		end
	end
	
	endmodule


		
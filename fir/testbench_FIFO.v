// Test bench for the FIFO block that tests the proper operation of tokens

module testbench_FIFO;
parameter N_BITS=32;
parameter N_CELLS=16;
	// local test signals
	reg    reset;
	reg    clk_put, clk_get;
	reg    req_put,  req_get; 
	reg   [N_BITS-1:0] data_put;
	wire  [N_BITS-1:0] data_get;
	wire   full_out, empty_out;
	
	// instantiate the FIFO module named 'test'
	FIFO_module test(reset, clk_put, clk_get, req_put, req_get, data_put, data_get, full_out, empty_out);
	
	// generate clocks
	always
		#8 clk_put = ~clk_put;
	always
		#22 clk_get = ~clk_get;
		
	// initialize inputs so that inputs/outputs can be displayed
	initial 
		begin
			reset = 1'b1;
			clk_put = 1'b0; // time = 0
			clk_get = 1'b0; 
			req_put = 1'b0; 
			req_get = 1'b0;
			data_put = 32'b00000000000000000000000000000000;
//#27;
			#40; 
			reset = 1'b0;
			data_put = 32'b10101010101010101010101010101010;
	
			// t = 15 ns
			// cell0 has the put token 
			// cell0 has data: 10101010101010101010101010101010
			#20;
			req_put = 1'b1;
		
			#40; 
			req_put = 1'b0;
						
			#60;
			data_put = 32'b11111000001111100000111110000011;
			
			// t = 45 ns
			// cell1 has the put token 
			// cell1 has data: 11111000001111100000111110000011
			#20;
			req_put = 1'b1;
			
			#40;
			req_put = 1'b0;
			
			#60;
			data_put = 32'b11111111111111111111111111111111;
			
			// t = 75 ns
			// cell2 has the put token 
			// cell2 has data: 11111111111111111111111111111111
			#20;
			req_put = 1'b1;
			
			#40;
			req_put = 1'b0;
			
			#60;
			data_put = 32'b11111111111111100000000000000000;
			
			// t = 105 ns
			// cell3 has the put token 
			// cell3 has data: 11111111111111100000000000000000
			#20;
			req_put = 1'b1;
			
			#40;
			req_put = 1'b0;
			
			// t = 132 ns
			// now try to read the stored data		

			// cell0 has the get token
			// read data: 10101010101010101010101010101010
			#65;
			req_get = 1'b1;
			
			// t = 156 ns
			
			#70;
			req_get = 1'b0;
			
			// t = 180 ns
			// cell1 has the get token
			// read data: 11111000001111100000111110000011
			#70;
			req_get = 1'b1;
			
			#70;
			req_get = 1'b0;
			
			// t = 228 ns
			// cell2 has the get token
			// read data: 11111111111111111111111111111111
			#70;
			req_get = 1'b1;
			
			#70;
			req_get = 1'b0;
		
			// t = 276 ns
			// cell3 has the get token
			// read data: 11111111111111100000000000000000
			#70;
			req_get = 1'b1;
			
			// t = 300 ns
			#70;
			req_get = 1'b0;
			
			// t = 350 ns
			// test when both requests are high
			#120;
			req_put = 1'b1;
			req_get = 1'b1;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#20;
			data_put = 32'b11111111111111111111111111111111;
			
			#20;
			data_put = 32'b10101010101010101010101010101010;
			
			#20;
			data_put = 32'b00000000000000000000000000000000;
			
			#2000;			
			req_put = 1'b0;
			
			#1000;
			req_get = 1'b0;
			
			#20;
			
			
		end
endmodule

//**************************************************************
//Test bench for FIR and coeff
//
// read 32bit binary input from data_in.txt file
// give one input for one clk
//
// print out 32 bit binary output to data_out txt file
// total simulation time should be 882700n
//
// Author Chengyuan Ma
//*************************************************************


`timescale 1ns / 1ps
module text_read_write;


  reg [31:0] mem_in [0:44100];
  reg [31:0] mem_out[0:44119];
  
  reg [31:0] data_put;
  integer h;
  wire [31:0] data_to_bus;
  wire full_to_bus;
  wire empty_to_bus;
  integer ini;
  integer k;
  integer j;
  integer i;
  integer m;
  integer w;
  reg CLK_put;
  reg CLK_get;
  reg req_get_frombus;
  reg reset;
  reg [1:0] filter_select;
  reg [15:0] bandlow;
  reg [15:0] bandhi;
  reg req_put;
  // reg hold;
  // wire start_togivedata;
  reg start_coe;
  FIRandFIFO dut(data_put,CLK_put,CLK_get,req_put,full_to_bus,data_to_bus,empty_to_bus,req_get_frombus,bandlow,bandhi,filter_select,reset,start_coe);
  //Top_FIR dut(clk,clk_enable,reset,data_in,data_out,start_coe,start_toread,start_togivedata,hold);

  always begin
  #22 CLK_get = ~CLK_get;
end
 always begin
  #8 CLK_put=~CLK_put;
end  
  initial
    begin
	$readmemb("data_in.txt", mem_in);
    m=$fopen("data_out2.txt","wb");
	w=$fopen("data_out_2.txt","wb");
	
	CLK_get=1'b0;
	CLK_put=1'b0;
	start_coe=1'b0;
	ini=1'b1;
	req_put<=1'b0;
    req_get_frombus<=1'b0;
	bandlow<=0;
	bandhi<=0;
	filter_select=0;
	
    reset=1'b1;
	  
	  
    #32
	reset=1'b0;
	#20
	req_get_frombus<=1'b1;
    start_coe<=1'b1;// given by comunication
	bandlow<=500;
	bandhi<=7000;
	filter_select=2'b00;
    #48
	
	i=0;
    h=0;
    while (i<=44100) begin
     #1  
	 	req_put<=1'b1;
     #15
	if (full_to_bus==1'b0) begin
	  
      data_put=mem_in [i];
	  i=i+1;
	end
	if (empty_to_bus==1'b0) begin
	mem_out[h]=data_to_bus;
    h=h+1;
	end
	//if (i==20)
    //filter_select=2'b01;
	
	//	hold=1'b1;
	//	else 
	//	hold=1'b0;
	
    end
    
	
	for (k=44101;k<=44106;k=k+1)begin
	#16
	mem_out[k]=data_to_bus;
	end
    #16  
    for(j=7;j<=44106;j=j+1)
     begin
     $fwrite(m,"%b\n",mem_out[j]);
	 $fwrite(w,"%b",mem_out[j]);
     end
    $fclose(m);
	$fclose(w);
end



endmodule 
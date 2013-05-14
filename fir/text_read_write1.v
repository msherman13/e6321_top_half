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
module text_read_write1;


  reg [31:0] mem_in [0:44100];
  reg [31:0] mem_out[0:44119];
  
  reg [31:0] data_in;
  wire [31:0] data_out;
  
  integer ini;
  integer k;
  integer j;
  integer i;
  integer m;
  integer w;
  reg clk;
  reg clk_enable;
  reg reset;
   reg [1:0] filter_select;
   reg [15:0] bandlow;
   reg [15:0] bandhi;
  reg hold;
  wire start_togivedata;
  reg start_coe;
  
  Top_FIR dut1(clk,reset,bandlow,bandhi,filter_select,data_in,data_out,start_coe,start_toread,start_togivedata,hold);
  //Top_FIR dut(clk,clk_enable,reset,data_in,data_out,start_coe,start_toread,start_togivedata,hold);

  always begin
  #10 clk = ~clk;
  end
  
  initial
    begin
	$readmemb("data_in.txt", mem_in);
    m=$fopen("data_out2_idealn.txt","wb");
	w=$fopen("data_out_2_ideal.txt","wb");
	
	clk=1'b0;
	start_coe=1'b0;
	ini=1'b1;
    hold=1'b0;
	bandlow<=0;
	bandhi<=0;
	filter_select=0;
	
    reset=1'b1;
	  clk_enable=1'b1;
	  if (ini==1'b1) begin
      data_in=32'b00000000000000000000000000000000;
	  end
	  
	  
    #12
	reset=1'b0;
	#20
	

	start_coe<=1'b1;// given by comunication
	bandlow<=500;
	bandhi<=7000;
	filter_select=2'b00;
    #500
	
	
    for (i=0; i<=44100; i=i+1) begin
	ini=1'b0;
     #20
	if (start_togivedata==1'b1) begin

    data_in=mem_in [i];
	end
	if (start_toread==1)
	mem_out[i]=data_out;

	//if (i==20)
    //filter_select=2'b01;
	
	//	hold=1'b1;
	//	else 
	//	hold=1'b0;
	
    end
    
	
	for (k=44101;k<=44106;k=k+1)begin
	#20
	mem_out[k]=data_out;
	end
    #20  
    for(j=7;j<=44106;j=j+1)
     begin
     $fwrite(m,"%b\n",mem_out[j]);
	 $fwrite(w,"%b",mem_out[j]);
     end
    $fclose(m);
	$fclose(w);
end



endmodule 
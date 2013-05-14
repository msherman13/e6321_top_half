//************************************************************
//  top level of the FIR. inculde coeff and data control
//
//   Author Chengyuan Ma
//************************************************************



module Top_FIR
               (
                clk,
                //clk_enable,
                reset,
				
			    bandlow,
			    bandhi,	
				filter_select,
				
                data_in,
                data_out,
				
			    start_coe,
			    start_toread,
			    start_togivedata,
			    hold
                );
				

				input [31:0] data_in;
				output [31:0] data_out;
								
			    input 	[15:0] bandlow;
			    input 	[15:0] bandhi;
				input [1:0] filter_select;
				input clk;
				//input clk_enable;
				input reset;
				input start_coe;
				input hold;
				output start_toread;
				output start_togivedata;
				
				wire [31:0] coeff0;
				wire [31:0] coeff1;
				wire [31:0] coeff2;
				wire [31:0] coeff3;
				wire [31:0] coeff4;
				wire [31:0] coeff5;
				wire [31:0] coeff6;
				wire [31:0] coeff7;
				wire [31:0] coeff8;
				wire [31:0] coeff9;
				wire [31:0] coeff10;
				wire [31:0] coeff11;
				wire [31:0] coeff12;
				wire coeff_enable=1'b1;
				wire [1:0] select;
				wire [15:0] Low_data_out;
				wire [15:0] Hi_data_out;
				wire flag;
				wire coeffdone;
				wire [7:0] num1=8'b00011000;
				wire [7:0] num2=8'b00000111;
				wire enable;
				wire start_toreadtemp;
				flipflopHb16 TopFIR_F1(clk,enable,reset,bandlow,Low_data_out);
				flipflopHb16 TopFIR_F2(clk,enable,reset,bandhi,Hi_data_out);
				flipflopHb2 TopFIR_F3(clk,enable,reset,filter_select,select);

                decide d1(bandlow,bandhi,filter_select,Low_data_out,Hi_data_out,select,enable);
				
			    coefficient_calculation TopFIR_coeff(clk,reset,bandlow,bandhi,filter_select,coeff0,coeff1,coeff2,coeff3,coeff4,coeff5,coeff6,coeff7,coeff8,coeff9,coeff10,coeff11,coeff12);
				
				counter Top_counter1(clk,start_coe,enable,flag,num1);
				
			    filter_FIR1 TopFIR_FIR1(clk,reset,data_in,data_out,coeff0,coeff1,coeff2,coeff3,coeff4,coeff5,coeff6,coeff7,coeff8,coeff9,coeff10,coeff11,coeff12,hold,flag);
			    counter Top_counter2(clk,flag,enable,start_toreadtemp,num2);
				
                and Top_FIRand1(start_toread,start_toreadtemp,~hold);
				and Top_FIRand2(start_togivedata,flag,~hold);

              //  or fir_or(start_togivedata,flag,~coeffdone);
				
	
			
			endmodule
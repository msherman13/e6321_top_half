//****************************************************************************
// 32 bit flipflop for buffer
// clk_enable will open flip-flop
// reset will clean all values
// Author: Chengyuan Ma
//
//****************************************************************************

module decide(

          bandlow,
		  bandhi,
		  filter_select,
		  
		  bandlowo,
		  bandhio,
		  filter_selecto,
		  
		  enable
		  );
		  
		  output enable;
		  
		  input [15:0] bandlow;
		  input [15:0] bandhi;
		  input [1:0] filter_select;
		  input [15:0] bandlowo;
		  input [15:0] bandhio;
		  input [1:0] filter_selecto;		  
		
		  or de_a1(enable, bandlow!=bandlowo, bandhi!=bandhio, filter_select!=filter_selecto);
		    
			 endmodule

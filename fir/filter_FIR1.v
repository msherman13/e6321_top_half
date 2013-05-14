//********************************************************************
//
//
// FIR
// all coeffs should be input
// all coeffs and data are control by flipflop
// only positive edge are using for flipflop
// input data already convert into 32 bit floating in this module
//
// using module flipflop fpmul and fpadd
// filter out is saved in flipflop
// author Chengyuan Ma
//
//********************************************************************



`timescale 1 ns / 1 ns

module filter_FIR1
               (
                clk,

                reset,
                filter_in,
                filter_out,
				
				coeff1,coeff2,coeff3,coeff4,coeff5,coeff6,coeff7,coeff8,coeff9,coeff10,coeff11,coeff12,coeff13,

				hold,
				start
                );

  input   clk; 

  input   reset; 
  
  input   [31:0] coeff13;
  input   [31:0] coeff1;
  input   [31:0] coeff2;
  input   [31:0] coeff3;
  input   [31:0] coeff4;
  input   [31:0] coeff5;
  input   [31:0] coeff6;
  input   [31:0] coeff7;
  input   [31:0] coeff8;
  input   [31:0] coeff9;
  input   [31:0] coeff10;
  input   [31:0] coeff11;
  input   [31:0] coeff12;
  
  
  input hold;
  input start;

	
  input   [31:0] filter_in; 
  
  
  output  [31:0] filter_out; 




  wire [31:0] coeff1w;
  wire [31:0] coeff2w;  
  wire [31:0] coeff3w;
  wire [31:0] coeff4w;
  wire [31:0] coeff5w;
  wire [31:0] coeff6w;
  wire [31:0] coeff7w;
  wire [31:0] coeff8w;
  wire [31:0] coeff9w;
  wire [31:0] coeff10w;
  wire [31:0] coeff11w;
  wire [31:0] coeff12w;
  wire [31:0] coeff13w;
  

  
  wire [31:0] data0w; 
  wire [31:0] data1w; 
  wire [31:0] data2w; 	
  wire [31:0] data3w;  
  wire [31:0] data4w;
  wire [31:0] data5w; 
  wire [31:0] data6w; 
  wire [31:0] data7w; 	
  wire [31:0] data8w;  
  wire [31:0] data9w; 
  wire [31:0] data10w; 
  wire [31:0] data11w; 
  wire [31:0] data12w; 	
  wire [31:0] data13w;  
  
  
  
  
  //wire [31:0] filter_in_fl;
  wire [4:0] control=5'b0000;
  
  
  wire [31:0] product13w; 
  wire [31:0] product12w; 
  wire [31:0] product11w; 
  wire [31:0] product10w; 
  wire [31:0] product9w; 
  wire [31:0] product8w; 
  wire [31:0] product7w; 
  wire [31:0] product6w; 
  wire [31:0] product5w; 
  wire [31:0] product4w; 
  wire [31:0] product3w; 
  wire [31:0] product2w; 
  wire [31:0] product1w; 
  
  wire [31:0] product13wS; 
  wire [31:0] product12wS; 
  wire [31:0] product11wS; 
  wire [31:0] product10wS; 
  wire [31:0] product9wS; 
  wire [31:0] product8wS; 
  wire [31:0] product7wS; 
  wire [31:0] product6wS; 
  wire [31:0] product5wS; 
  wire [31:0] product4wS; 
  wire [31:0] product3wS; 
  wire [31:0] product2wS; 
  wire [31:0] product1wS; 
  
  
  
  wire [31:0] sum10w;
  wire [31:0] sum11w;
  wire [31:0] sum12w;
  wire [31:0] sum13w;
  wire [31:0] sum14w;
  wire [31:0] sum15w;
  wire [31:0] sum16w;
  
  wire [31:0] sum10wS;
  wire [31:0] sum11wS;
  wire [31:0] sum12wS;
  wire [31:0] sum13wS;
  wire [31:0] sum14wS;
  wire [31:0] sum15wS;
  wire [31:0] sum16wS;
  

  wire [31:0] sum20w;
  wire [31:0] sum21w;
  wire [31:0] sum22w;
  wire [31:0] sum23w;
  
  wire [31:0] sum20wS;
  wire [31:0] sum21wS;
  wire [31:0] sum22wS;
  wire [31:0] sum23wS;
  

  
  wire [31:0] sum30w;
  wire [31:0] sum31w;
  
  wire [31:0] sum30wS;
  wire [31:0] sum31wS;
  
  wire [31:0] sum4; 
  wire [31:0] sum4S; 
  wire [31:0] data_out1; 
  
  wire [4:0] flags;
  wire [4:0] flags1;
  wire [4:0] flags2;
  wire [4:0] flags3;
  wire [4:0] flags4;
  wire [4:0] flags5;
  wire [4:0] flags6;
  wire [4:0] flags7;
  wire [4:0] flags8;
  wire [4:0] flags9;
  wire [4:0] flags10;
  wire [4:0] flags11;
  wire [4:0] flags12;
  wire [4:0] flags13;
  wire [4:0] flags14;
  wire [4:0] flags15;
  wire [4:0] flags16;
  wire [4:0] flags17;
  wire [4:0] flags18;
  wire [4:0] flags19;
  wire [4:0] flags20;
  wire [4:0] flags21;
  wire [4:0] flags22;
  wire [4:0] flags23;
  wire [4:0] flags24;


  // change bi to fl
  //BiToFLT BiToFLT_n1(clk,clk_enable,reset,filter_in,filter_in_fl);
  
  and Fiter_FIR_And1(enable_F1to26,~hold,start); 
  flipflopH FIR_fH1(clk,enable_F1to26,reset,coeff1,coeff1w);
  flipflopH FIR_fH2(clk,enable_F1to26,reset,coeff2,coeff2w);
  flipflopH FIR_fH3(clk,enable_F1to26,reset,coeff3,coeff3w);
  flipflopH FIR_fH4(clk,enable_F1to26,reset,coeff4,coeff4w);
  flipflopH FIR_fH5(clk,enable_F1to26,reset,coeff5,coeff5w);
  flipflopH FIR_fH6(clk,enable_F1to26,reset,coeff6,coeff6w);
  flipflopH FIR_fH7(clk,enable_F1to26,reset,coeff7,coeff7w);
  flipflopH FIR_fH8(clk,enable_F1to26,reset,coeff8,coeff8w);
  flipflopH FIR_fH9(clk,enable_F1to26,reset,coeff9,coeff9w);
  flipflopH FIR_fH10(clk,enable_F1to26,reset,coeff10,coeff10w);
  flipflopH FIR_fH11(clk,enable_F1to26,reset,coeff11,coeff11w);
  flipflopH FIR_fH12(clk,enable_F1to26,reset,coeff12,coeff12w);
  flipflopH FIR_fH13(clk,enable_F1to26,reset,coeff13,coeff13w);

  flipflopH FIR_fH14(clk,enable_F1to26,reset,filter_in,data0w);
  flipflopH FIR_fH15(clk,enable_F1to26,reset,data0w,data1w);
  flipflopH FIR_fH16(clk,enable_F1to26,reset,data1w,data2w);
  flipflopH FIR_fH17(clk,enable_F1to26,reset,data2w,data3w);
  flipflopH FIR_fH18(clk,enable_F1to26,reset,data3w,data4w);
  flipflopH FIR_fH19(clk,enable_F1to26,reset,data4w,data5w);
  flipflopH FIR_fH20(clk,enable_F1to26,reset,data5w,data6w);
  flipflopH FIR_fH21(clk,enable_F1to26,reset,data6w,data7w);
  flipflopH FIR_fH22(clk,enable_F1to26,reset,data7w,data8w);
  flipflopH FIR_fH23(clk,enable_F1to26,reset,data8w,data9w);
  flipflopH FIR_fH24(clk,enable_F1to26,reset,data9w,data10w);
  flipflopH FIR_fH25(clk,enable_F1to26,reset,data10w,data11w);
  flipflopH FIR_fH26(clk,enable_F1to26,reset,data11w,data12w); 

  fpmul filter_FIR1_mu1(data12w, coeff13w, product13w, control, flags) ;
  fpmul filter_FIR1_mu2(data11w, coeff12w, product12w, control, flags1) ;
  fpmul filter_FIR1_mu3(data10w, coeff11w, product11w, control, flags2) ;
  fpmul filter_FIR1_mu4(data9w, coeff10w, product10w, control, flags3) ;
  fpmul filter_FIR1_mu5(data8w, coeff9w, product9w, control, flags4) ;
  fpmul filter_FIR1_mu6(data7w, coeff8w, product8w, control, flags5) ;
  fpmul filter_FIR1_mu7(data6w, coeff7w, product7w, control, flags6) ;
  fpmul filter_FIR1_mu8(data5w, coeff6w, product6w, control, flags7) ;
  fpmul filter_FIR1_mu9(data4w, coeff5w, product5w, control, flags8) ;
  fpmul filter_FIR1_mu10(data3w, coeff4w, product4w, control, flags9) ;
  fpmul filter_FIR1_mu11(data2w, coeff3w, product3w, control, flags10) ;
  fpmul filter_FIR1_mu12(data1w, coeff2w, product2w, control, flags11) ;
  fpmul filter_FIR1_mu13(data0w, coeff1w, product1w, control, flags12) ;

  
  flipflopH FIR_fH27(clk,~hold,reset,product13w,product13wS);
  flipflopH FIR_fH28(clk,~hold,reset,product12w,product12wS);
  flipflopH FIR_fH29(clk,~hold,reset,product11w,product11wS);
  flipflopH FIR_fH30(clk,~hold,reset,product10w,product10wS);
  flipflopH FIR_fH31(clk,~hold,reset,product9w,product9wS);
  flipflopH FIR_fH32(clk,~hold,reset,product8w,product8wS);
  flipflopH FIR_fH33(clk,~hold,reset,product7w,product7wS);
  flipflopH FIR_fH34(clk,~hold,reset,product6w,product6wS);
  flipflopH FIR_fH35(clk,~hold,reset,product5w,product5wS);
  flipflopH FIR_fH36(clk,~hold,reset,product4w,product4wS);
  flipflopH FIR_fH37(clk,~hold,reset,product3w,product3wS);
  flipflopH FIR_fH38(clk,~hold,reset,product2w,product2wS);
  flipflopH FIR_fH39(clk,~hold,reset,product1w,product1wS);
  



  fpadd filter_FIR1_add1(product13wS, product12wS, sum10w, control, flags13) ;
  fpadd filter_FIR1_add2(product11wS, product10wS, sum11w, control, flags14) ;
  fpadd filter_FIR1_add3(product9wS, product8wS, sum12w, control, flags15) ;
  fpadd filter_FIR1_add4(product7wS, product6wS, sum13w, control, flags16) ;
  fpadd filter_FIR1_add5(product5wS, product4wS, sum14w, control, flags17) ;
  fpadd filter_FIR1_add6(product3wS, product2wS, sum15w, control, flags18) ;


  flipflopH FIR_fH40(clk,~hold,reset,sum10w,sum10wS);
  flipflopH FIR_fH41(clk,~hold,reset,sum11w,sum11wS);
  flipflopH FIR_fH42(clk,~hold,reset,sum12w,sum12wS);
  flipflopH FIR_fH43(clk,~hold,reset,sum13w,sum13wS);
  flipflopH FIR_fH44(clk,~hold,reset,sum14w,sum14wS);
  flipflopH FIR_fH45(clk,~hold,reset,sum15w,sum15wS);
  flipflopH FIR_fH46(clk,~hold,reset,product1wS,sum16wS);
  
  
	
	fpadd filter_FIR1_add7(sum10wS, sum11wS, sum20w, control, flags19) ;
	fpadd filter_FIR1_add8(sum12wS, sum13wS, sum21w, control, flags20) ;
	fpadd filter_FIR1_add9(sum14wS, sum15wS, sum22w, control, flags21) ;
	

	
  flipflopH FIR_fH47(clk,~hold,reset,sum20w,sum20wS);
  flipflopH FIR_fH48(clk,~hold,reset,sum21w,sum21wS);
  flipflopH FIR_fH49(clk,~hold,reset,sum22w,sum22wS);
  flipflopH FIR_fH50(clk,~hold,reset,sum16wS,sum23wS);
	

  
	

	fpadd filter_FIR1_add10(sum20wS, sum21wS, sum30w, control, flags22) ;
	fpadd filter_FIR1_add11(sum22wS, sum23wS, sum31w, control, flags23) ;
	
    flipflopH FIR_fH51(clk,~hold,reset,sum30w,sum30wS);
    flipflopH FIR_fH52(clk,~hold,reset,sum31w,sum31wS);


	fpadd filter_FIR1_add12(sum30wS, sum31wS, sum4, control, flags24) ;

    flipflopH FIR_fH53(clk,~hold,reset,sum4,sum4S);
	// may not use this
	flipflopH FIR_fH54(clk,~hold,reset,sum4S,data_out1);

  assign filter_out = data_out1;
endmodule 



module ram (
	clk			,
	address     , // Address Input
	data        , // Data bi-directional
	cs          , // Chip Select
	we          , // Write Enable/Read Enable
	oe            // Output Enable
	);          
parameter DATA_WIDTH = 32 ;
parameter ADDR_WIDTH = 32 ;
parameter RAM_DEPTH = 50000;

//--------------Input Ports----------------------- 
input [ADDR_WIDTH-1:0] address ;
input                                     cs, clk           ;
input                                     we          ;
input                                     oe           ; 

//--------------Inout Ports----------------------- 
inout [DATA_WIDTH-1:0]  data       ;

//--------------Internal variables---------------- 
reg [DATA_WIDTH-1:0]   data_out ;
reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];

initial
begin
	$readmemb("data_in.txt", mem);
end

//--------------Code Starts Here------------------ 

// Tri-State Buffer control 
// output : When we = 0, oe = 1, cs = 1
assign data = (cs && oe && !we) ? data_out : 32'bz; 

// Memory Write Block 
// Write Operation : When we = 1, cs = 1
always @ (address or data or cs or we or oe)
begin : MEM_WRITE
   if ( cs && we ) begin
       mem[address] = data;
   end
   else begin
   	data_out = mem[address];
   end
end

// Memory Read Block 
// Read Operation : When we = 0, oe = 1, cs = 1
/*
always @ (address or cs or we or oe)
begin : MEM_READ
    if (cs && !we && oe)  begin
         
    end
end
*/

endmodule // End of Module ram_sp_ar_aw

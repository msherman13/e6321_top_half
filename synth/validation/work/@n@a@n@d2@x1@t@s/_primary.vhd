library verilog;
use verilog.vl_types.all;
entity NAND2X1TS is
    port(
        Y               : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic
    );
end NAND2X1TS;

library verilog;
use verilog.vl_types.all;
entity AOI2BB1X2TS is
    port(
        Y               : out    vl_logic;
        A0N             : in     vl_logic;
        A1N             : in     vl_logic;
        B0              : in     vl_logic
    );
end AOI2BB1X2TS;

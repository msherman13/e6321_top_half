library verilog;
use verilog.vl_types.all;
entity AHCSHCINX4TS is
    port(
        S               : out    vl_logic;
        CO              : out    vl_logic;
        A               : in     vl_logic;
        CIN             : in     vl_logic;
        CS              : in     vl_logic
    );
end AHCSHCINX4TS;

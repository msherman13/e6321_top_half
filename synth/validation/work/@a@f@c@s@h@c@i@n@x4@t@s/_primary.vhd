library verilog;
use verilog.vl_types.all;
entity AFCSHCINX4TS is
    port(
        S               : out    vl_logic;
        CO0             : out    vl_logic;
        CO1             : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic;
        CI0N            : in     vl_logic;
        CI1N            : in     vl_logic;
        CS              : in     vl_logic
    );
end AFCSHCINX4TS;

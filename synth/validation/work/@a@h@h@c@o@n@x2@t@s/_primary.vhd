library verilog;
use verilog.vl_types.all;
entity AHHCONX2TS is
    port(
        S               : out    vl_logic;
        CON             : out    vl_logic;
        A               : in     vl_logic;
        CI              : in     vl_logic
    );
end AHHCONX2TS;

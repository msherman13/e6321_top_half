library verilog;
use verilog.vl_types.all;
entity AHCSHCONX2TS is
    port(
        S               : out    vl_logic;
        CON             : out    vl_logic;
        A               : in     vl_logic;
        CI              : in     vl_logic;
        CS              : in     vl_logic
    );
end AHCSHCONX2TS;

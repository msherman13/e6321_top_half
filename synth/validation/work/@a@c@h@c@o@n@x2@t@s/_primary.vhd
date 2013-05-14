library verilog;
use verilog.vl_types.all;
entity ACHCONX2TS is
    port(
        CON             : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic;
        CI              : in     vl_logic
    );
end ACHCONX2TS;

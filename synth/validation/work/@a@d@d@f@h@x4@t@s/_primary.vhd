library verilog;
use verilog.vl_types.all;
entity ADDFHX4TS is
    port(
        S               : out    vl_logic;
        CO              : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic;
        CI              : in     vl_logic
    );
end ADDFHX4TS;

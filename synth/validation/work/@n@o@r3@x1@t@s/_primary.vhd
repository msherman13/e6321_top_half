library verilog;
use verilog.vl_types.all;
entity NOR3X1TS is
    port(
        Y               : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic
    );
end NOR3X1TS;

library verilog;
use verilog.vl_types.all;
entity MX2X1TS is
    port(
        Y               : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic;
        S0              : in     vl_logic
    );
end MX2X1TS;

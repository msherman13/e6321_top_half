library verilog;
use verilog.vl_types.all;
entity BENCX2TS is
    port(
        S               : out    vl_logic;
        A               : out    vl_logic;
        X2              : out    vl_logic;
        M2              : in     vl_logic;
        M1              : in     vl_logic;
        M0              : in     vl_logic
    );
end BENCX2TS;

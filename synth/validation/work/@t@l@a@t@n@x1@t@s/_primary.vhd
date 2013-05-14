library verilog;
use verilog.vl_types.all;
entity TLATNX1TS is
    port(
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        D               : in     vl_logic;
        GN              : in     vl_logic
    );
end TLATNX1TS;

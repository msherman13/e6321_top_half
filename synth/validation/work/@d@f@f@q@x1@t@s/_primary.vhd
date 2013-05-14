library verilog;
use verilog.vl_types.all;
entity DFFQX1TS is
    port(
        Q               : out    vl_logic;
        D               : in     vl_logic;
        CK              : in     vl_logic
    );
end DFFQX1TS;

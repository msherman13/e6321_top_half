library verilog;
use verilog.vl_types.all;
entity DFFSHQX8TS is
    port(
        Q               : out    vl_logic;
        D               : in     vl_logic;
        CK              : in     vl_logic;
        SN              : in     vl_logic
    );
end DFFSHQX8TS;

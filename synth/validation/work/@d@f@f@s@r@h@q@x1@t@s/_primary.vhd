library verilog;
use verilog.vl_types.all;
entity DFFSRHQX1TS is
    port(
        Q               : out    vl_logic;
        D               : in     vl_logic;
        CK              : in     vl_logic;
        SN              : in     vl_logic;
        RN              : in     vl_logic
    );
end DFFSRHQX1TS;

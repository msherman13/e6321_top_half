library verilog;
use verilog.vl_types.all;
entity SEDFFHQX2TS is
    port(
        Q               : out    vl_logic;
        D               : in     vl_logic;
        CK              : in     vl_logic;
        E               : in     vl_logic;
        SE              : in     vl_logic;
        SI              : in     vl_logic
    );
end SEDFFHQX2TS;

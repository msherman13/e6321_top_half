library verilog;
use verilog.vl_types.all;
entity EDFFHQX2TS is
    port(
        Q               : out    vl_logic;
        D               : in     vl_logic;
        CK              : in     vl_logic;
        E               : in     vl_logic
    );
end EDFFHQX2TS;

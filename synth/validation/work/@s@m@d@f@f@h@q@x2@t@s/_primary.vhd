library verilog;
use verilog.vl_types.all;
entity SMDFFHQX2TS is
    port(
        Q               : out    vl_logic;
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        S0              : in     vl_logic;
        SI              : in     vl_logic;
        SE              : in     vl_logic;
        CK              : in     vl_logic
    );
end SMDFFHQX2TS;

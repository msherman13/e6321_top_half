library verilog;
use verilog.vl_types.all;
entity MDFFHQX8TS is
    port(
        Q               : out    vl_logic;
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        S0              : in     vl_logic;
        CK              : in     vl_logic
    );
end MDFFHQX8TS;

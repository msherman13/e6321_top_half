library verilog;
use verilog.vl_types.all;
entity NOR2BX4TS is
    port(
        Y               : out    vl_logic;
        AN              : in     vl_logic;
        B               : in     vl_logic
    );
end NOR2BX4TS;

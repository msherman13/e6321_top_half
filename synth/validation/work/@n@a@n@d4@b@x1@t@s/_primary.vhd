library verilog;
use verilog.vl_types.all;
entity NAND4BX1TS is
    port(
        Y               : out    vl_logic;
        AN              : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic;
        D               : in     vl_logic
    );
end NAND4BX1TS;

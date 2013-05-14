library verilog;
use verilog.vl_types.all;
entity RFRDX2TS is
    port(
        BRB             : out    vl_logic;
        RB              : in     vl_logic
    );
end RFRDX2TS;

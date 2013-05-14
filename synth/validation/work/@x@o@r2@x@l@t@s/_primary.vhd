library verilog;
use verilog.vl_types.all;
entity XOR2XLTS is
    port(
        Y               : out    vl_logic;
        A               : in     vl_logic;
        B               : in     vl_logic
    );
end XOR2XLTS;

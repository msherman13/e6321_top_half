library verilog;
use verilog.vl_types.all;
entity TLATNTSCAX6TS is
    port(
        ECK             : out    vl_logic;
        E               : in     vl_logic;
        SE              : in     vl_logic;
        CK              : in     vl_logic
    );
end TLATNTSCAX6TS;

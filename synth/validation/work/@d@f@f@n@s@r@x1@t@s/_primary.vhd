library verilog;
use verilog.vl_types.all;
entity DFFNSRX1TS is
    port(
        Q               : out    vl_logic;
        QN              : out    vl_logic;
        D               : in     vl_logic;
        CKN             : in     vl_logic;
        SN              : in     vl_logic;
        RN              : in     vl_logic
    );
end DFFNSRX1TS;

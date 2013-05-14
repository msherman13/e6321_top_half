library verilog;
use verilog.vl_types.all;
entity ram is
    generic(
        DATA_WIDTH      : integer := 32;
        ADDR_WIDTH      : integer := 32;
        RAM_DEPTH       : integer := 50000
    );
    port(
        clk             : in     vl_logic;
        address         : in     vl_logic_vector;
        data            : inout  vl_logic_vector;
        cs              : in     vl_logic;
        we              : in     vl_logic;
        oe              : in     vl_logic
    );
end ram;

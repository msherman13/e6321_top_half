library verilog;
use verilog.vl_types.all;
entity top_level is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        acc_fft_data_out: in     vl_logic_vector(31 downto 0);
        acc_fft_data_in : in     vl_logic_vector(31 downto 0);
        acc_fir_data_out: in     vl_logic_vector(31 downto 0);
        acc_fir_data_in : in     vl_logic_vector(31 downto 0);
        fft_enable      : out    vl_logic;
        fir_enable      : out    vl_logic;
        to_fft_empty    : out    vl_logic;
        from_fft_full   : out    vl_logic;
        to_fir_empty    : out    vl_logic;
        from_fir_full   : out    vl_logic;
        acc_fft_get     : out    vl_logic;
        acc_fft_put     : out    vl_logic;
        acc_fir_get     : out    vl_logic;
        acc_fir_put     : out    vl_logic;
        ram_read_enable : out    vl_logic;
        ram_write_enable: out    vl_logic;
        addr            : out    vl_logic_vector(31 downto 0);
        data_bus        : inout  vl_logic_vector(31 downto 0)
    );
end top_level;

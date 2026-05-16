library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_register_tb is
end;

architecture behavior of input_register_tb is

    component input_register
        port (
            clk      : in  std_logic;
            reset    : in  std_logic;
            CTRL_in  : in  std_logic_vector(3 downto 0);
            Rd_in    : in  std_logic_vector(3 downto 0);
            CTRL_out : out std_logic_vector(3 downto 0);
            Rd_out   : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk_tb   : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal CTRL_in_tb : std_logic_vector(3 downto 0);
    signal Rd_in_tb   : std_logic_vector(3 downto 0);
    signal CTRL_out_tb : std_logic_vector(3 downto 0);
    signal Rd_out_tb   : std_logic_vector(3 downto 0);

    constant clk_period : time := 20 ns;

begin

    DUT: input_register
        port map (
            clk      => clk_tb,
            reset    => reset_tb,
            CTRL_in  => CTRL_in_tb,
            Rd_in    => Rd_in_tb,
            CTRL_out => CTRL_out_tb,
            Rd_out   => Rd_out_tb
        );
        
    process
    begin
        while true loop
            clk_tb <= '0'; wait for clk_period / 2;
            clk_tb <= '1'; wait for clk_period / 2;
        end loop;
    end process;

    process
    begin

        reset_tb    <= '1';
        CTRL_in_tb  <= "1010";
        Rd_in_tb    <= "1100";
        wait for 20 ns;

        reset_tb <= '0';
        wait for 10 ns;

        CTRL_in_tb <= "0001";
        Rd_in_tb   <= "0010";
        wait for 20 ns;

        CTRL_in_tb <= "1111";
        Rd_in_tb   <= "0101";
        wait for 20 ns;

        CTRL_in_tb <= "0011";
        Rd_in_tb   <= "0110";
        wait for 10 ns;

        CTRL_in_tb <= "0100";
        Rd_in_tb   <= "0111";
        wait for 10 ns;

        reset_tb <= '1';
        wait for 20 ns;

        wait;

    end process;

end behavior;
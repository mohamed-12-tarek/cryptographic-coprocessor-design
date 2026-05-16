library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file_tb is
end;

architecture behavior of register_file_tb is

    component register_file
        Port (
            clk, reset, WEN : in  STD_LOGIC;
            Ra, Rb, Rd      : in  STD_LOGIC_VECTOR(3 downto 0);
            DataIn          : in  STD_LOGIC_VECTOR(15 downto 0);
            ABUS, BBUS      : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    signal clk_tb, reset_tb, WEN_tb : std_logic := '0';
    signal Ra_tb, Rb_tb, Rd_tb      : std_logic_vector(3 downto 0);
    signal DataIn_tb                : std_logic_vector(15 downto 0);
    signal ABUS_tb, BBUS_tb         : std_logic_vector(15 downto 0);

    constant clk_period : time := 20 ns;

begin

    DUT: register_file
        port map(
            clk    => clk_tb,
            reset  => reset_tb,
            WEN    => WEN_tb,
            Ra     => Ra_tb,
            Rb     => Rb_tb,
            Rd     => Rd_tb,
            DataIn => DataIn_tb,
            ABUS   => ABUS_tb,
            BBUS   => BBUS_tb
        );

    process
    begin
        while true loop
            clk_tb <= '0'; wait for clk_period/2;
            clk_tb <= '1'; wait for clk_period/2;
        end loop;
    end process;

    process
    begin

        WEN_tb <= '0';
        Ra_tb <= "0000"; 
        Rb_tb <= "0001"; 
        wait for 20 ns;

        Ra_tb <= "0100"; 
        Rb_tb <= "1110"; 
        wait for 20 ns;

        Rd_tb     <= "0011";      
        DataIn_tb <= x"AAAA";
        WEN_tb    <= '1';
        wait until rising_edge(clk_tb); 

        WEN_tb <= '0';
        Ra_tb <= "0011"; 
        wait for 20 ns;

        Rd_tb     <= "1111"; 
        DataIn_tb <= x"1234";
        WEN_tb    <= '1';
        wait until rising_edge(clk_tb);

        WEN_tb <= '0';
        Ra_tb <= "1111";
        Rb_tb <= "0011"; 
        wait for 20 ns;

        Rd_tb     <= "0001";
        DataIn_tb <= x"FFFF";
        WEN_tb    <= '0'; 
        wait until rising_edge(clk_tb);

        Ra_tb <= "0001";
        wait for 20 ns;

        wait;

    end process;

end behavior;
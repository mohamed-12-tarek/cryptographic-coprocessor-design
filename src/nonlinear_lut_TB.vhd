library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nonlinear_lut_tb is
end nonlinear_lut_tb;

architecture Behavioral of nonlinear_lut_tb is

    component nonlinear_lut
        Port (
            LUTIN  : in  STD_LOGIC_VECTOR(7 downto 0);
            LUTOUT : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal LUTIN_s  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal LUTOUT_s : STD_LOGIC_VECTOR(7 downto 0);

begin

    DUT: nonlinear_lut
        port map (
            LUTIN  => LUTIN_s,
            LUTOUT => LUTOUT_s
        );

    stim_proc: process
    begin

        LUTIN_s <= "00000000";
        wait for 10 ns;

        LUTIN_s <= "11111111";
        wait for 10 ns;

        LUTIN_s <= "10101010";
        wait for 10 ns;

        LUTIN_s <= "01010101";
        wait for 10 ns;

        LUTIN_s <= "00011110";
        wait for 10 ns;

        LUTIN_s <= "11010010";
        wait for 10 ns;

        LUTIN_s <= "00010010";
        wait for 10 ns;

        LUTIN_s <= "11101111";
        wait for 10 ns;

        LUTIN_s <= "10101100";
        wait for 10 ns;

        LUTIN_s <= "01111000";
        wait for 10 ns;

        LUTIN_s <= "10000111";
        wait for 10 ns;

        wait;

    end process;

end Behavioral;
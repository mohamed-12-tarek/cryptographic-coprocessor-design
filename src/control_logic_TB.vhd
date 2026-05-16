library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_logic_tb is
end control_logic_tb;

architecture Behavioral of control_logic_tb is

    component control_logic
        port (
            A_BUS  : in  std_logic_vector(15 downto 0);
            B_BUS  : in  std_logic_vector(15 downto 0);
            CTRL   : in  std_logic_vector(3 downto 0);
            RESULT : out std_logic_vector(15 downto 0)
        );
    end component;

    signal A_BUS_s  : std_logic_vector(15 downto 0) := (others => '0');
    signal B_BUS_s  : std_logic_vector(15 downto 0) := (others => '0');
    signal CTRL_s   : std_logic_vector(3 downto 0)  := (others => '0');
    signal RESULT_s : std_logic_vector(15 downto 0);

begin

    DUT: control_logic
        port map (
            A_BUS  => A_BUS_s,
            B_BUS  => B_BUS_s,
            CTRL   => CTRL_s,
            RESULT => RESULT_s
        );

    stim_proc: process
    begin

        A_BUS_s <= x"1234";
        B_BUS_s <= x"ABCD";

        CTRL_s <= "0000";
        wait for 10 ns;

        CTRL_s <= "0001";
        wait for 10 ns;

        CTRL_s <= "0010";
        wait for 10 ns;

        CTRL_s <= "0011";
        wait for 10 ns;

        CTRL_s <= "0100";
        wait for 10 ns;

        CTRL_s <= "0101";
        wait for 10 ns;

        CTRL_s <= "0110";
        wait for 10 ns;

        CTRL_s <= "1000";
        wait for 10 ns;

        CTRL_s <= "1001";
        wait for 10 ns;

        CTRL_s <= "1010";
        wait for 10 ns;

        CTRL_s <= "1011";
        wait for 10 ns;

        CTRL_s <= "1111";
        wait for 10 ns;

        A_BUS_s <= x"0000";
        B_BUS_s <= x"FFFF";

        CTRL_s <= "0000";
        wait for 10 ns;

        CTRL_s <= "1000";
        wait for 10 ns;

        CTRL_s <= "1011";
        wait for 10 ns;

        A_BUS_s <= x"A5A5";
        B_BUS_s <= x"5A5A";

        CTRL_s <= "0011";
        wait for 10 ns;

        CTRL_s <= "1010";
        wait for 10 ns;

        CTRL_s <= "1011";
        wait for 10 ns;

        wait;

    end process;

end Behavioral;
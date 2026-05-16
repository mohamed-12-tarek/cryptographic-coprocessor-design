library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter_tb is
end shifter_tb;

architecture Behavioral of shifter_tb is

    component shifter
        Port (
            BBUS      : in  STD_LOGIC_VECTOR(15 downto 0);
            ShiftCtrl : in  STD_LOGIC_VECTOR(3 downto 0);
            ShiftOut  : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    signal BBUS_s      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal ShiftCtrl_s : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal ShiftOut_s  : STD_LOGIC_VECTOR(15 downto 0);

begin

    DUT: shifter
        port map (
            BBUS      => BBUS_s,
            ShiftCtrl => ShiftCtrl_s,
            ShiftOut  => ShiftOut_s
        );

    stim_proc: process
    begin

        BBUS_s <= x"1234";

        ShiftCtrl_s <= "0000";
        wait for 10 ns;

        ShiftCtrl_s <= "1000";
        wait for 10 ns;

        ShiftCtrl_s <= "1001";
        wait for 10 ns;

        ShiftCtrl_s <= "1010";
        wait for 10 ns;

        BBUS_s <= x"0000";

        ShiftCtrl_s <= "1000"; 
        wait for 10 ns;

        ShiftCtrl_s <= "1001"; 
        wait for 10 ns;

        ShiftCtrl_s <= "1010"; 
        wait for 10 ns;

        BBUS_s <= x"FFFF";

        ShiftCtrl_s <= "1000";
        wait for 10 ns;

        ShiftCtrl_s <= "1001";
        wait for 10 ns;

        ShiftCtrl_s <= "1010";
        wait for 10 ns;

        BBUS_s <= x"A5A5";

        ShiftCtrl_s <= "1000";
        wait for 10 ns;

        ShiftCtrl_s <= "1001";
        wait for 10 ns;

        ShiftCtrl_s <= "1010";
        wait for 10 ns;

        ShiftCtrl_s <= "1111";
        wait for 10 ns;

        wait;

    end process;

end Behavioral;
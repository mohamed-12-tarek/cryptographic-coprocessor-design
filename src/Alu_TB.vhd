library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_TB is
end ALU_TB;

architecture Behavioral of ALU_TB is

    component ALU
        Port (
            ABUS, BBUS : in  STD_LOGIC_VECTOR(15 downto 0);
            ALUctrl    : in  STD_LOGIC_VECTOR(3 downto 0);
            ALUOUT     : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end component;

    signal ABUS_s, BBUS_s : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal ALUctrl_s      : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
    signal ALUOUT_s       : STD_LOGIC_VECTOR(15 downto 0);

begin

    DUT: ALU
        port map (
            ABUS    => ABUS_s,
            BBUS    => BBUS_s,
            ALUctrl => ALUctrl_s,
            ALUOUT  => ALUOUT_s
        );

    stim_proc: process
    begin

        ABUS_s <= std_logic_vector(to_signed(10, 16));
        BBUS_s <= std_logic_vector(to_signed(5, 16));

        ALUctrl_s <= "0000";
        wait for 10 ns;

        ALUctrl_s <= "0001";
        wait for 10 ns;

        ALUctrl_s <= "0010";
        wait for 10 ns;

        ALUctrl_s <= "0011";
        wait for 10 ns;

        ALUctrl_s <= "0100";
        wait for 10 ns;

        ALUctrl_s <= "0101";
        wait for 10 ns;

        ALUctrl_s <= "0110";
        wait for 10 ns;

        ALUctrl_s <= "1111";
        wait for 10 ns;

        ABUS_s <= std_logic_vector(to_signed(-3, 16));
        BBUS_s <= std_logic_vector(to_signed(7, 16));

        ALUctrl_s <= "0000";
        wait for 10 ns;

        ALUctrl_s <= "0001";
        wait for 10 ns;

        wait;
    end process;

end Behavioral;
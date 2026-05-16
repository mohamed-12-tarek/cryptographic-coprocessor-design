library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_register is
    port (
        clk      : in  std_logic;
        reset    : in  std_logic;
        CTRL_in  : in  std_logic_vector(3 downto 0);
        Rd_in    : in  std_logic_vector(3 downto 0);
        CTRL_out : out std_logic_vector(3 downto 0);
        Rd_out   : out std_logic_vector(3 downto 0)
    );
end input_register;


architecture Behavioral of input_register is
begin
    process(clk, reset)
    begin
        if reset = '1' then
            CTRL_out <= "0111";
            Rd_out   <= (others => '0');
        elsif rising_edge(clk) then
            CTRL_out <= CTRL_in;
            Rd_out   <= Rd_in;
        end if;
    end process;
end Behavioral;
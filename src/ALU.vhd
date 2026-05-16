library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity ALU is
    Port (
        ABUS, BBUS : in  STD_LOGIC_VECTOR(15 downto 0);
        ALUctrl    : in  STD_LOGIC_VECTOR(3 downto 0);
        ALUOUT     : out STD_LOGIC_VECTOR(15 downto 0)
    );
end ALU;
 
architecture Behavioral of ALU is
begin
    process(ABUS, BBUS, ALUctrl)
    begin
        case ALUctrl is
            when "0000" => ALUOUT <= std_logic_vector(signed(ABUS) + signed(BBUS));  -- ADD
            when "0001" => ALUOUT <= std_logic_vector(signed(ABUS) - signed(BBUS));  -- SUB
            when "0010" => ALUOUT <= ABUS and BBUS;                                      -- AND
            when "0011" => ALUOUT <= ABUS or  BBUS;                                      -- OR
            when "0100" => ALUOUT <= ABUS xor BBUS;                                      -- XOR
            when "0101" => ALUOUT <= not ABUS;                                           -- NOT
            when "0110" => ALUOUT <= ABUS;                                               -- MOV
            when others => ALUOUT <= (others => '0');                                    -- NOP 
        end case;
    end process;
end Behavioral;
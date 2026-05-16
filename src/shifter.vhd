library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity shifter is
    Port (
        BBUS      : in  STD_LOGIC_VECTOR(15 downto 0);
        ShiftCtrl : in  STD_LOGIC_VECTOR(3 downto 0);
        ShiftOut  : out STD_LOGIC_VECTOR(15 downto 0)
    );
end shifter;
 
architecture Behavioral of shifter is
begin
    process(BBUS, ShiftCtrl)
    begin
        case ShiftCtrl is
            -- ROR8: rotate right by 8 bits
            when "1000" => ShiftOut <= BBUS(7 downto 0) & BBUS(15 downto 8);
 
            -- ROR4: rotate right by 4 bits
            when "1001" => ShiftOut <= BBUS(3 downto 0) & BBUS(15 downto 4);
 
            -- SLL8: shift-left-logical 8  
            when "1010" => ShiftOut <= BBUS(7 downto 0) & x"00";
 
            when others => ShiftOut <= (others => '0');
        end case;
    end process;
end Behavioral;
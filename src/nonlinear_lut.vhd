library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity nonlinear_lut is
    Port (
        LUTIN  : in  STD_LOGIC_VECTOR(7 downto 0);
        LUTOUT : out STD_LOGIC_VECTOR(7 downto 0)
    );
end nonlinear_lut;
 
architecture Behavioral of nonlinear_lut is
begin
    process(LUTIN)
        variable u  : std_logic_vector(3 downto 0);
        variable l  : std_logic_vector(3 downto 0);
        variable su : std_logic_vector(3 downto 0);
        variable sl : std_logic_vector(3 downto 0);
    begin
        u := LUTIN(7 downto 4);
        l := LUTIN(3 downto 0);
 
        -- Upper nibble S-box
        case u is
            when "0000" => su := "0001";
            when "0001" => su := "1011";
            when "0010" => su := "1001";
            when "0011" => su := "1100";
            when "0100" => su := "1101";
            when "0101" => su := "0110";
            when "0110" => su := "1111";
            when "0111" => su := "0011";
            when "1000" => su := "1110";
            when "1001" => su := "1000";
            when "1010" => su := "0111";
            when "1011" => su := "0100";
            when "1100" => su := "1010";
            when "1101" => su := "0010";
            when "1110" => su := "0000";   
            when others => su := "0101";  
        end case;
 
        -- Lower nibble S-box
        case l is
            when "0000" => sl := "1111";
            when "0001" => sl := "0000";
            when "0010" => sl := "1101";
            when "0011" => sl := "0111";
            when "0100" => sl := "1011";
            when "0101" => sl := "1110";
            when "0110" => sl := "0101";
            when "0111" => sl := "1010";
            when "1000" => sl := "1001";
            when "1001" => sl := "0010";
            when "1010" => sl := "1100";
            when "1011" => sl := "0001";
            when "1100" => sl := "0011";
            when "1101" => sl := "0100";
            when "1110" => sl := "1000";
            when others => sl := "0110";   
        end case;
 
        LUTOUT <= su & sl;
    end process;
end Behavioral;
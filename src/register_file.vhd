library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity register_file is
    Port (
        clk, reset, WEN : in  STD_LOGIC;
        Ra, Rb, Rd      : in  STD_LOGIC_VECTOR(3 downto 0);
        DataIn          : in  STD_LOGIC_VECTOR(15 downto 0);
        ABUS, BBUS      : out STD_LOGIC_VECTOR(15 downto 0)
    );
end register_file;
 
architecture Behavioral of register_file is
    type mem_type is array(0 to 15) of std_logic_vector(15 downto 0);
    signal INIT_VALUES : mem_type := (
        0  => x"0001",
        1  => x"0002",
        2  => x"0003",
        3  => x"0004",
        4  => x"0005",
        5  => x"0006",
        6  => x"0007",
        7  => x"0008",
        8  => x"0009",
        9  => x"000A",
        10 => x"000B",
        11 => x"000C",
        12 => x"000D",
        13 => x"000E",
        14 => x"000F",
        15 => x"0010",
        others => (others => '0')
    ); 
	
	signal REG_FILE : mem_type := INIT_VALUES;

	
begin
    -- Synchronous write
    process(clk)
    begin
        if rising_edge(clk) then
			if reset = '1' then

                REG_FILE <= INIT_VALUES;
            elsif WEN = '1' then
                REG_FILE(to_integer(unsigned(Rd))) <= DataIn;
            end if;
        end if;
    end process;
 
    -- Asynchronous read
    ABUS <= REG_FILE(to_integer(unsigned(Ra)));
    BBUS <= REG_FILE(to_integer(unsigned(Rb)));
end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity crypto_coprocessor is
    port (
        clk, reset : in  std_logic;
        CTRL       : in  std_logic_vector(3 downto 0);
        Ra, Rb, Rd : in  std_logic_vector(3 downto 0);
        A, B, W    : out std_logic_vector(15 downto 0)
    );
end crypto_coprocessor;

architecture Behavioral of crypto_coprocessor is


    -- COMPONENTS													  										
	

    component register_file
        port (
            clk, reset, WEN : in  std_logic;
            Ra, Rb, Rd      : in  std_logic_vector(3 downto 0);
            DataIn          : in  std_logic_vector(15 downto 0);
            ABUS, BBUS      : out std_logic_vector(15 downto 0)
        );
    end component;

    component control_logic
        port (
            A_BUS  : in  std_logic_vector(15 downto 0);
            B_BUS  : in  std_logic_vector(15 downto 0);
            CTRL   : in  std_logic_vector(3 downto 0);
            RESULT : out std_logic_vector(15 downto 0)
        );
    end component;

    component input_register
        port (
            clk, reset : in  std_logic;

            CTRL_in : in  std_logic_vector(3 downto 0);
            Rd_in   : in  std_logic_vector(3 downto 0);

            CTRL_out : out std_logic_vector(3 downto 0);
            Rd_out   : out std_logic_vector(3 downto 0)
        );
    end component;
	
	
    -- INTERNAL SIGNALS																						
	

    signal A_s, B_s, W_s : std_logic_vector(15 downto 0);

    signal ctrl_s, rd_s : std_logic_vector(3 downto 0);

    signal wen : std_logic;

begin
	
	
    -- REGISTER FILE																						   
	
    RF: register_file
        port map(
            clk    => clk,
            reset  => reset,
            WEN    => wen,

            Ra     => Ra,
            Rb     => Rb,
            Rd     => rd_s,

            DataIn => W_s,

            ABUS   => A_s,
            BBUS   => B_s
        );
		
		
    -- CONTROL LOGIC																						   
	
    CL: control_logic
        port map(
            A_BUS  => A_s,
            B_BUS  => B_s,
            CTRL   => ctrl_s,
            RESULT => W_s
        );
		
		
    -- INPUT REGISTER (PIPELINE STAGE)								   						 
	
    IR: input_register
        port map(
            clk      => clk,
            reset    => reset,

            CTRL_in  => CTRL,
            Rd_in    => Rd,

            CTRL_out => ctrl_s,
            Rd_out   => rd_s
        );
		
		
    -- WRITE ENABLE LOGIC
    -- NOP = "0111"													  									  
	
    wen <= '0' when ctrl_s = "0111" else '1';
		
		
    -- OUTPUT PORTS																							   
	
    A <= A_s;
    B <= B_s;
    W <= W_s;

end Behavioral;
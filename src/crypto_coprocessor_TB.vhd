library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity crypto_coprocessor_tb is
end crypto_coprocessor_tb;

architecture behavior of crypto_coprocessor_tb is

    component crypto_coprocessor
        port(
            clk, reset : in  std_logic;
            CTRL       : in  std_logic_vector(3 downto 0);
            Ra, Rb, Rd : in  std_logic_vector(3 downto 0);
            A, B, W    : out std_logic_vector(15 downto 0)
        );
    end component;

    signal clk_tb, reset_tb : std_logic := '0';	  
    signal CTRL_tb : std_logic_vector(3 downto 0) := "0111"; 
    signal Ra_tb, Rb_tb, Rd_tb : std_logic_vector(3 downto 0) := "0000";  
    signal A_tb, B_tb, W_tb : std_logic_vector(15 downto 0);

    constant clk_period : time := 20 ns;

begin

    DUT: crypto_coprocessor
        port map(
            clk   => clk_tb,
            reset => reset_tb,
            CTRL  => CTRL_tb,
            Ra    => Ra_tb,
            Rb    => Rb_tb,
            Rd    => Rd_tb,
            A     => A_tb,
            B     => B_tb,
            W     => W_tb
        );
		
		
    -- CLOCK GENERATOR												 								   
	
    clk_process : process
    begin
        while true loop
            clk_tb <= '0';
            wait for clk_period / 2;

            clk_tb <= '1';
            wait for clk_period / 2;
        end loop;
    end process;
	
	
    -- STIMULUS														   										  
	
    stim_proc : process
    begin
												 
        -- RESET   
		
        reset_tb <= '1';
        CTRL_tb <= "0111"; -- NOP
        Ra_tb   <= "0101"; -- R5
        Rb_tb   <= "1110"; -- R14
        Rd_tb   <= "0000";
        wait for clk_period; 	 
													  
        -- ADD		
		
		CTRL_tb <= "0000";
        reset_tb <= '0';
        wait until falling_edge(clk_tb);
        wait until rising_edge(clk_tb);
														 
        -- SUB								 					   
		
        wait until falling_edge(clk_tb);
        CTRL_tb <= "0001";

        wait until rising_edge(clk_tb);
		
		
        -- AND										   							   
		
        wait until falling_edge(clk_tb);
        CTRL_tb <= "0010";

        wait until rising_edge(clk_tb);
													   
        -- OR																			
		
        wait until falling_edge(clk_tb);
        CTRL_tb <= "0011";
        wait until rising_edge(clk_tb);
		
		
        -- XOR										 							 
		
        wait until falling_edge(clk_tb);
        CTRL_tb <= "0100";
        wait until rising_edge(clk_tb);
		
		
        -- NOT										   							   
		
        wait until falling_edge(clk_tb);
        CTRL_tb <= "0101";
        wait until rising_edge(clk_tb);
		
		
        -- ROR8										  							 
		
        wait until falling_edge(clk_tb);
        CTRL_tb <= "1000";
        wait until rising_edge(clk_tb);
													   
        -- ROR4																		  
		
        wait until falling_edge(clk_tb);
        CTRL_tb <= "1001";
        wait until rising_edge(clk_tb);
													   
        -- SLL8										 							
		
        wait until falling_edge(clk_tb);
        CTRL_tb <= "1010";
        wait until rising_edge(clk_tb);
													   
        -- LUT									  						   
		
        wait until falling_edge(clk_tb);
        CTRL_tb <= "1011";
        wait until rising_edge(clk_tb);

		-- END										   
	
        wait;

    end process;

end behavior;



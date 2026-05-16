library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_logic is
    port (
        A_BUS  : in  std_logic_vector(15 downto 0);
        B_BUS  : in  std_logic_vector(15 downto 0);
        CTRL   : in  std_logic_vector(3 downto 0);
        RESULT : out std_logic_vector(15 downto 0)
    );
end control_logic;

architecture Behavioral of control_logic is

    component ALU
        port (
            ABUS, BBUS : in  std_logic_vector(15 downto 0);
            ALUctrl    : in  std_logic_vector(3 downto 0);
            ALUOUT     : out std_logic_vector(15 downto 0)
        );
    end component;

    component shifter
        port (
            BBUS      : in  std_logic_vector(15 downto 0);
            ShiftCtrl : in  std_logic_vector(3 downto 0);
            ShiftOut  : out std_logic_vector(15 downto 0)
        );
    end component;

    component nonlinear_lut
        port (
            LUTIN  : in  std_logic_vector(7 downto 0);
            LUTOUT : out std_logic_vector(7 downto 0)
        );
    end component;

    signal alu_out   : std_logic_vector(15 downto 0);
    signal shift_out : std_logic_vector(15 downto 0);
    signal lut_out   : std_logic_vector(7 downto 0);

begin

    --------------------------------------------------------------------
    -- Parallel combinational units
    --------------------------------------------------------------------
    U1: ALU
        port map (
            ABUS    => A_BUS,
            BBUS    => B_BUS,
            ALUctrl => CTRL,
            ALUOUT  => alu_out
        );

    U2: shifter
        port map (
            BBUS      => B_BUS,
            ShiftCtrl => CTRL,
            ShiftOut  => shift_out
        );

    U3: nonlinear_lut
        port map (
            LUTIN  => A_BUS(7 downto 0),
            LUTOUT => lut_out
        );
		
		
    -- Control multiplexing logic (combinational)					  				
	
    process(CTRL, alu_out, shift_out, lut_out, A_BUS)
    begin
        if CTRL(3) = '0' then
            -- ALU operations (0xxx)
            RESULT <= alu_out;

        else
            -- Shift / LUT operations (1xxx)

            if CTRL(1 downto 0) = "11" then
                -- LUT operation (1x11)
                RESULT <= A_BUS(15 downto 8) & lut_out;

            else
                -- Shift operations (1x00 / 1x01 / 1x10)
                RESULT <= shift_out;
            end if;

        end if;
    end process;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- VHDL Tool: Example top-level design module
entity vhdl_tool is
    Port (
        clk     : in  std_logic;
        reset   : in  std_logic;
        data_in : in  std_logic_vector(7 downto 0);
        ready   : out std_logic;
        data_out: out std_logic_vector(7 downto 0)
    );
end vhdl_tool;

architecture Behavioral of vhdl_tool is
    type state_type is (IDLE, PROCESSING, OUTPUT);
    signal current_state : state_type := IDLE;
    signal data_buffer   : std_logic_vector(7 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE;
            data_buffer   <= (others => '0');
            data_out      <= (others => '0');
            ready         <= '0';
        elsif rising_edge(clk) then
            case current_state is
                when IDLE =>
                    ready     <= '0';
                    if data_in /= x"00" then
                        data_buffer <= data_in;
                        current_state <= PROCESSING;
                    end if;
                when PROCESSING =>
                    -- Simulate a simple processing step
                    data_buffer <= std_logic_vector(unsigned(data_buffer) + 1);
                    current_state <= OUTPUT;
                when OUTPUT =>
                    data_out  <= data_buffer;
                    ready     <= '1';
                    current_state <= IDLE;
                when others =>
                    current_state <= IDLE;
            end case;
        end if;
    end process;
end Behavioral;

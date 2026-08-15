-- VHDL Tool: Digital Circuit Design & Simulation Framework
-- Author: Autonomous AI Polyglot Software Engineer
-- Description: Core VHDL module demonstrating synchronous design,
--               state machine logic, and hardware description standards.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vhdl_tool is
    Port (
        clk      : in  STD_LOGIC;
        rst_n    : in  STD_LOGIC;
        en       : in  STD_LOGIC;
        data_in  : in  STD_LOGIC_VECTOR(7 downto 0);
        ready    : out STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end vhdl_tool;

architecture Behavioral of vhdl_tool is
    type state_type is (IDLE, PROCESS, DONE);
    signal current_state, next_state : state_type;
    signal reg_data : STD_LOGIC_VECTOR(7 downto 0);
begin

    -- Sequential Process: State Register & Reset
    process(clk, rst_n)
    begin
        if rst_n = '0' then
            current_state <= IDLE;
            ready <= '0';
            data_out <= (others => '0');
        elsif rising_edge(clk) then
            current_state <= next_state;
            ready <= '1' when current_state = DONE else '0';
            data_out <= reg_data when current_state = DONE else (others => '0');
        end if;
    end process;

    -- Combinational Process: State Transitions & Data Processing
    process(current_state, en, data_in)
    begin
        next_state <= current_state;
        case current_state is
            when IDLE =>
                if en = '1' then
                    next_state <= PROCESS;
                end if;
            when PROCESS =>
                reg_data <= data_in;
                next_state <= DONE;
            when DONE =>
                if en = '1' then
                    next_state <= PROCESS;
                else
                    next_state <= IDLE;
                end if;
            when others =>
                next_state <= IDLE;
        end case;
    end process;

end Behavioral;

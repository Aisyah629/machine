library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity vhdl_data_processing_utility is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        data_in  : in  STD_LOGIC_VECTOR(7 downto 0);
        load     : in  STD_LOGIC;
        data_out : out STD_LOGIC_VECTOR(7 downto 0);
        done     : out STD_LOGIC
    );
end vhdl_data_processing_utility;

architecture Behavioral of vhdl_data_processing_utility is

    signal register_data : STD_LOGIC_VECTOR(7 downto 0);
    signal counter       : unsigned(3 downto 0) := (others => '0');
    signal state         : integer range 0 to 3 := 0;

begin

    process(clk, reset)
    begin
        if reset = '1' then
            register_data <= (others => '0');
            counter       <= (others => '0');
            state         <= 0;
            data_out      <= (others => '0');
            done          <= '0';
        elsif rising_edge(clk) then
            case state is
                when 0 =>
                    if load = '1' then
                        register_data <= data_in;
                        state         <= 1;
                    end if;
                when 1 =>
                    data_out <= register_data;
                    counter  <= counter + 1;
                    if counter = 15 then
                        state <= 2;
                    end if;
                when 2 =>
                    done <= '1';
                    state <= 3;
                when 3 =>
                    done <= '0';
                    state <= 0;
                when others =>
                    state <= 0;
            end case;
        end if;
    end process;

end Behavioral;

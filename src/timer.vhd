----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2022 05:35:56 PM
-- Design Name: 
-- Module Name: timer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity timer is
  Port ( board_clock: in std_logic;
         reset: in std_logic;
         start: in std_logic;
         sel: in std_logic;
         output: out std_logic_vector(5 downto 0)
       );
end timer;

architecture Behavioral of timer is
    
    signal clock_1hz: std_logic := '0';
    signal is_running: std_logic := '0';
    
    signal start_1: std_logic := '0';
    signal start_2: std_logic := '0';
    signal start_pulse: std_logic := '0';
    
    signal min: unsigned(5 downto 0) := (others => '0');
    signal sec: unsigned(5 downto 0) := (others => '0');
    
begin

freq_div_unit: 
        entity work.freq_div(Behavioral) 
        generic map(CLK_INPUT  => 125000000,        
                CLK_OUTPUT => 1)                
        port map(clk_in  => board_clock,
                 clk_out => clock_1hz);

start_stop: 
      process(clock_1hz) is
      begin
           if rising_edge(clock_1hz)
           then
                start_1 <= start;
                start_2 <= start_1;
           end if;           
      end process start_stop;
      start_pulse <= start_1 and (not start_2);
      
change_state:
       process(clock_1hz) is
       begin
            if rising_edge(clock_1hz)
            then
                if start_pulse = '1'
                then    
                    is_running <= not is_running;
                end if;
            end if;
       end process change_state;
   
timer_proc: 
      process (clock_1hz, reset) is 
    
      begin 
            if reset = '1'
            then
                sec <= (others => '0');
                min <= (others => '0');
            elsif rising_edge(clock_1hz)
            then
                if is_running = '1'
                then
                    if sec = 59
                    then
                        sec <= (others => '0');
                        if min = 59
                        then
                            min <= (others => '0');
                        else
                            min <= min + 1;
                        end if;
                    else
                        sec <= sec + 1;
                    end if;
                else
                    sec <= sec;
                    min <= min;
                end if;
            end if;
            
      end process timer_proc;

      output <= std_logic_vector(sec) when sel = '0'
                else std_logic_vector(min);

end Behavioral;

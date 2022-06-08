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
    
begin

-- To test simulation connect board clock directly to the clock_1hz.
freq_div_unit: 
        entity work.freq_div(Behavioral) 
        generic map(CLK_INPUT  => 125000000,        
                CLK_OUTPUT => 1)                
        port map(clk_in  => board_clock,
                 clk_out => clock_1hz);

start_stop: 
      process (start) is
      begin
            if start = '1'
            then
                is_running <= not is_running;
            end if;
      end process start_stop;

timer_proc: 
      process (clock_1hz, reset) is 
    
        variable min: unsigned(5 downto 0) := (others => '0');
        variable sec: unsigned(5 downto 0) := (others => '0');
    
      begin
      
        if is_running = '1'
        then
            if reset = '1'
            then
                min := (others => '0');
                sec := (others => '0');
            elsif rising_edge(clock_1hz)
            then
                if sec = 59
                then
                    sec := (others => '0');
                    if min = 59
                    then
                        min := (others => '0');
                    else
                        min := min + 1;
                    end if;
                else
                    sec := sec + 1;
                end if;
                
            end if;
         end if;
      
         if sel = '0'
         then
            output <= std_logic_vector(sec);
         else
            output <= std_logic_vector(min);
         end if;
         
      end process timer_proc;

end Behavioral;

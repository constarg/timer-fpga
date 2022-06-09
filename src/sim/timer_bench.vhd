----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/08/2022 02:52:57 PM
-- Design Name: 
-- Module Name: timer_bench - Behavioral
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

entity timer_bench is
--  Port ( );
end timer_bench;

architecture Behavioral of timer_bench is

    signal sim_bclock: std_logic := '0';
    signal sim_reset: std_logic := '0';
    signal sim_start: std_logic := '0';
    signal sim_sel: std_logic := '0';
    signal sim_output: std_logic_vector(5 downto 0) := (others => '0');

begin
sim_timer: 
        entity work.timer(Behavioral)      
        port map(
                  board_clock => sim_bclock,
                  reset => sim_reset,
                  start => sim_start,
                  sel => sim_sel,
                  output => sim_output
                );
       
sim_clock_p:
        process is
        begin
            wait for 500ns;
            sim_bclock <= '0';
            wait for 500ns;
            sim_bclock <= '1';
            
        end process sim_clock_p;
sim_proc:
        process is
        begin
             -- here the process.
              
        end process sim_proc;

end Behavioral;

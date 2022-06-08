----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:09:00 05/11/2015 
-- Design Name: 
-- Module Name:    freq_div - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_div is
	generic(
		CLK_INPUT 		:integer :=  100000000;									-- The board clock in Hz
		CLK_OUTPUT	 	:integer :=  1												-- The desired clock in Hz
	);
	port(
		clk_in 	: in 	std_logic;
		clk_out	: out std_logic
	);
end freq_div;

architecture Behavioral of freq_div is

	-- Constants
	constant CLK_DIVISOR :integer :=  ((CLK_INPUT / CLK_OUTPUT) / 2);	-- Frequency divisor factor
	
	-- Signals
	signal clk		  : std_logic := '0';
	signal clk_count : integer range 0 to CLK_DIVISOR-1;
	
begin

	-- FREQUENCY DIVIDER
	CLK_DIV: process (clk_in)
	
	begin
	
		if(clk_in'event and clk_in = '1') then
			if(clk_count = CLK_DIVISOR-1) then
				clk <= not clk;
				clk_count <= 0;
			else
				clk_count <= clk_count + 1;
			end if;
		end if;

	end process CLK_DIV;

	clk_out <= clk;
		
end Behavioral;


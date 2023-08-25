----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.02.2023 20:45:32
-- Design Name: 
-- Module Name: TB_timer - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_timer is
--  Port ( );
end TB_timer;

architecture Behavioral of TB_timer is

  signal Clk100 : std_logic := '0';
  signal Reset : std_logic := '1';
  signal clkout : std_logic ;

begin

my_timer : entity work.timer port map(Clk100,Reset,clkout);


Reset <= '0' after 2 ns;

Clk100 <= not Clk100 after 0.5 us; --5
  
 
end Behavioral;

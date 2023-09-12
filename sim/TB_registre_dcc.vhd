----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed - YANG Zixiao
--
-- Module Name: TB_registre_dcc - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Testbench du registre de decalage et de chargement de la Centrale DCC
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity TB_registre_dcc is
end TB_registre_dcc;

architecture Behavioral of TB_registre_dcc is

signal clk : std_logic:='0';
signal reset: std_logic:='1';
signal com_reg : std_logic_vector(1 downto 0):="00"; 
signal trame : std_logic_vector(50 downto 0) ;
signal trame_bit : std_logic;

begin

my_reg : entity work.Registre_dcc port map(clk,reset,com_reg,trame,trame_bit);


Reset <= '0' after 1 ns;

Clk <= not Clk after 5 ns;

com_reg <= "01" after 3 ns, "10" after 10 ns, "01" after 800 ns,"10" after 810 ns, "01" after 1600 ns,"10" after 1610 ns;

trame <= (50 => '1',44 => '1',42 => '1',40 => '1',38 => '1',36 => '1',others => '0');


end Behavioral;

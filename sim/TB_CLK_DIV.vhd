----------------------------------------------------------------------------------
-- Company: UPMC
-- Designed by: E.PIMOR S.HAMOUM, Spring 2017
-- Revision by: J.DENOULET, Summer 2017
--
-- Module Name: TB_CLK_DIV - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: NEXYS 4 DDR
--
--	Testbench du diviseur d'Horloge: 100 MHz --> 1 MHz
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_CLK_DIV is
end TB_CLK_DIV;

architecture Behavioral of TB_CLK_DIV is

signal Reset 	:  STD_LOGIC:='1';		-- Reset Asynchrone
signal Clk_In 	:  STD_LOGIC := '0';		-- Horloge 100 MHz de la carte Nexys
signal Clk_Out 	:  STD_LOGIC;	-- Horloge 1 MHz de sortie

begin

my_clk_div : entity work.CLK_DIV port map(Reset,Clk_In,Clk_Out);

Reset <= '0' after 2 ns;

Clk_In <= not Clk_In after 5 ns;

process
    variable clk_out_var : std_logic;
begin
    clk_out_var := '1';
    wait for 0.5 us;
    assert clk_out_var = clk_out report "Erreur sur clk_out" severity error;
    

    wait for 10 ns;
    assert false report "marche" severity note;
    wait;
end process;

end Behavioral;

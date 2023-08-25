----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed 
--
-- Module Name: TB_COMPTEUR_TEMPO - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Testbench du compteur de Temporisation de la Centrale DCC
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_COMPTEUR_TEMPO is
end TB_COMPTEUR_TEMPO;

architecture Behavioral of TB_COMPTEUR_TEMPO is
signal Clk : STD_LOGIC := '0';		-- Horloge 100 MHz
signal Reset : STD_LOGIC;		-- Reset Asynchrone
signal Clk1M : STD_LOGIC :='0';		-- Horloge 1 MHz
signal Start_Tempo	: STD_LOGIC;		-- Commande de D?marrage de la Temporisation
signal Fin_Tempo	: STD_LOGIC;		-- Drapeau de Fin de la Temporisation
begin
    my_compteur_tempo: entity work.COMPTEUR_TEMPO
        port map(
        Clk => Clk,
        Reset => Reset,
        Clk1M => Clk1M,
        Start_Tempo => Start_Tempo,
        Fin_Tempo => Fin_Tempo);
        
Clk <= not Clk after 1 ns;
Clk1M <= not Clk1M after 5 ns;
Reset <= '1', '0' after 2 ns;
Start_Tempo <= '1' after 20ns;
end Behavioral;
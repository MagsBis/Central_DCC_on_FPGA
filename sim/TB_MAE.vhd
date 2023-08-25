----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed 
--
-- Module Name: TB_MAE - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Testbench de la MAE Generale de la Centrale DCC
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_MAE is
end TB_MAE;

architecture Behavioral of TB_MAE is
signal clk100 : std_logic := '0';
signal reset,trame_bit,Fin_tempo,Fin_1,Fin_0,Ready,Fin_trame,Go_1,Go_0,Start_tempo : STD_LOGIC;
signal com_reg :std_logic_vector(1 downto 0);
begin
    my_mae: entity work.MAE
        port map(
        clk100 => clk100,
        reset => reset,
        trame_bit => trame_bit,
        Fin_tempo => Fin_tempo,
        Fin_1 => Fin_1,
        Fin_0 => Fin_0,
        Ready => Ready,
        Fin_trame => Fin_trame,
        Go_1 => Go_1,
        Go_0 => Go_0,
        Start_tempo => Start_tempo,
        com_reg => com_reg);
        
clk100 <= not clk100 after 1 ns;
reset <= '1', '0' after 2 ns;
trame_bit <= '1' after 10 ns, '0' after 20 ns;
Ready <= '1' after 5 ns, '0' after 10 ns;
Fin_1 <= '1' after 15 ns;
Fin_0 <= '1' after 25 ns;
Fin_tempo <= '0' after 2 ns, '1' after 30 ns, '0' after 32 ns;
Fin_trame <= '0' after 2 ns, '1' after 40 ns, '0' after 42 ns;
end Behavioral;
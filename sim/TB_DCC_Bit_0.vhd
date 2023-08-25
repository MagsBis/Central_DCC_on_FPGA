----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed 
--
-- Module Name: TB_DCC_Bit_0 - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Testbench du compteur de Temporisation de la Centrale DCC
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_DCC_Bit_0 is
end TB_DCC_Bit_0;

architecture Behavioral of TB_DCC_Bit_0 is
signal clk100 :  std_logic:='0';
signal clk1 :  std_logic:='0';
signal reset:  std_logic:='1';
signal Go_0 :  std_logic:='0'; 
signal Fin0 :  std_logic ;
signal dcc_0 :  std_logic;

begin

my_dcc : entity work.DCC_Bit_0 port map(clk100,clk1,reset,Go_0,Fin0,dcc_0);

clk100 <= not clk100 after 5 ns;
clk1 <= not clk1 after 0.5 us;

reset <= '0' after 10 us;

Go_0 <= '1' after 20 us, '0' after 20020 ns, '1' after 240 us , '0' after 240020 ns;

process
    variable dcc_0_var : std_logic;
begin
    dcc_0_var := '1';
    wait for 121 us;
    assert dcc_0_var = dcc_0 report "Erreur sur dcc_0" severity error;
    
    wait for 1 ns;
    assert false report "marche" severity note;
    wait;
end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed 
--
-- Module Name: TB_DCC_Bit_1 - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Testbench du generateur d'impulsion pour le bit 1 conformement au protocole DCC
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_DCC_Bit_1 is
end TB_DCC_Bit_1;

architecture Behavioral of TB_DCC_Bit_1 is
signal clk100 :  std_logic:='0';
signal clk1 :  std_logic:='0';
signal reset:  std_logic:='1';
signal Go_1 :  std_logic:='0'; 
signal Fin1 :  std_logic ;
signal dcc_1 :  std_logic;

begin

my_dcc : entity work.DCC_Bit_1 port map(clk100,clk1,reset,Go_1,Fin1,dcc_1);

clk100 <= not clk100 after 5 ns;
clk1 <= not clk1 after 0.5 us;

reset <= '0' after 10 us;

Go_1 <= '1' after 20 us, '0' after 20020 ns, '1' after 140 us , '0' after 140020 ns;

process
    variable dcc_1_var : std_logic;
begin
    dcc_1_var := '1';
    wait for 78 us;
    assert dcc_1_var = dcc_1 report "Erreur sur dcc_1" severity error;
    
    wait for 1 ns;
    assert false report "marche" severity note;
    wait;
end process;

end Behavioral;

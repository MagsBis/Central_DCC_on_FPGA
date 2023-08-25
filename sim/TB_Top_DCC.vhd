----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed 
--
-- Module Name: TB_Top_DCC - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Testbench du module principal de la Centrale DCC
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Top_DCC is
end TB_Top_DCC;

architecture Behavioral of TB_Top_DCC is

signal clk100 :  std_logic := '0';                        
signal reset:  std_logic := '1';                      
signal Interrupteur :  std_logic_vector(7 downto 0) := x"01";
signal sortie_dcc :  std_logic;

begin

my_top : entity work.Top_DCC 
    port map(clk100 => clk100,                        
            reset => reset,                         
            Interrupteur => Interrupteur,
            sortie_dcc => sortie_dcc);

clk100 <= not clk100 after 5ns;
reset <= '0' after 6 ns;

process
    variable sortie_dcc_var : std_logic;
begin
    sortie_dcc_var := '0';
    wait for 8 ms;
    assert sortie_dcc_var = sortie_dcc report "Erreur sur sortie_dcc" severity error;
    
    wait for 1 ns;
    assert false report "marche" severity note;
    wait;
end process;

end Behavioral;
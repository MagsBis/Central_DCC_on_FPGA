----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed 
--
-- Module Name: Top_DCC - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Module principal de la Centrale DCC
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_DCC is
  Port (clk100 : in std_logic;                          -- Horloge 100 MHz de la carte Basys
        reset   : in std_logic;                            -- Reset Asynchrone
        trame   : in std_logic_vector(50 downto 0);      -- trame de la carte Basys
        valFor7seg    : in std_logic_vector(5 downto 0);     -- l'etats des 6 leds
        wordFor7seg : in std_logic_vector(4 downto 0);     -- l'etats des 5 switchs(14 3 2 1 0).
        sel_seg : out std_logic_vector(3 downto 0);   -- Selection de l'Afficheur
        seg     : out std_logic_vector(7 downto 0);	  -- Valeur des Segments de l'Afficheur
        sortie_dcc : out std_logic                      -- Signal ? envoyer en entree du Boster
        );
end Top_DCC;
  
architecture Behavioral of Top_DCC is

signal clk1,trame_bit,Ready,Fin_trame,Go_1,Fin_1,Go_0,Fin_0,dcc_1,dcc_0,Start_Tempo,Fin_Tempo,data : std_logic;
signal com_reg : std_logic_vector(1 downto 0);
signal dcc_s : std_logic;


begin
aff7seg : entity work.aff_7seg_basys 
port map(   clk100 => clk100,
            reset=> reset,
            valFor7seg=> valFor7seg,
            wordFor7seg=> wordFor7seg,
            sel_seg=> sel_seg,
            seg=> seg);

reg_dcc : entity work.Registre_dcc 
port map(   clk => clk100,
            reset=> reset,
            com_reg=> com_reg,
            trame=> trame,
            trame_bit=> trame_bit,
            Ready=> Ready,
            Fin_trame=> Fin_trame);

dcc_1Bit : entity work.DCC_Bit_1 
port map(   clk100 => clk100,
            clk1 => clk1,
            reset => reset,
            Go_1 => Go_1,
            Fin_1 => Fin_1,
            dcc_1 => dcc_1);

dcc_0Bit : entity work.DCC_Bit_0 
port map(   clk100 => clk100,
            clk1 => clk1,
            reset => reset,
            Go_0 => Go_0,
            Fin_0 => Fin_0,
            dcc_0 => dcc_0);

cpt_tempo : entity work.COMPTEUR_TEMPO 
port map(   Clk => Clk100,
            Reset => Reset,
            Clk1M => Clk1,
            Start_Tempo => Start_Tempo,
            Fin_Tempo => Fin_Tempo);

clk_div: entity work.CLK_DIV 
port map(   Reset => Reset,
            Clk_In => clk100,
            Clk_Out => clk1);
            
mae : entity work.MAE 
port map(   clk100 => clk100,
            reset => reset,
            data => trame_bit,
            Fin_tempo => Fin_tempo,
            Fin_1 => Fin_1,
            Fin_0 => Fin_0,
            Ready => Ready,
            Fin_trame => Fin_trame,
            Go_1 => Go_1,
            Go_0 => Go_0,
            Start_tempo => Start_tempo,
            com_reg => com_reg);
      
sortie_dcc <= dcc_1 or dcc_0;



end Behavioral;

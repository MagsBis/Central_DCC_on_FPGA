----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed - YANG Zixiao
--
-- Module Name: MAE - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- MAE Generale de la Centrale DCC
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MAE is
  Port (clk100 : in std_logic;
        reset : in std_logic;
        data : in std_logic;
        Fin_tempo : in std_logic;
        Fin_1 : in std_logic;
        Fin_0 : in std_logic;
        Ready : in std_logic;
        Fin_trame : in std_logic;
        Go_1 : out std_logic;
        Go_0 : out std_logic;
        Start_tempo : out std_logic;
        com_reg : out std_logic_vector(1 downto 0));
end MAE;

architecture Behavioral of MAE is
type etat is (Recuperation,Decalage, DCC_0, DCC_1, Tempo_delai);
signal EP,EF: etat;	
begin
    ------------------------------------------
	-- Gestion du COmpteur de Temporisation --
	------------------------------------------
	
    process(clk100,reset)
       begin
		if reset='1' then EP <= Recuperation;   -- etat initial
		elsif rising_edge(clk100) then
			EP <= EF;                           -- Mise ?? Jour du Registre d'Etat
		end if;
    end process;
    ----------------------------------------------
	-- MAE - Evolution des Etats et des Sorties --
	----------------------------------------------

process(EP,Ready,data,Fin_trame,Fin_tempo,Fin_0,Fin_1)
        begin 
                 Go_1<='0';
                 Go_0<='0'; 
                 Start_Tempo <= '0'; 
                 com_reg <= "00";
            case (EP) is
                when Recuperation =>                                        -- etat de recuperation/chargement de la trame
                    com_reg <= "01"; Start_Tempo <= '0';                    -- etat des sorties
                    if Ready = '1' then EF <= Decalage;                     -- passe a l'etat Traitement si la trame est chargee 
                    else EF <= Recuperation;                                -- on reste dans Recuperation sinon
                    end if; 
                    
                when Decalage=>                                             -- etat de Decalage bit a bit de la trame
                    com_reg <= "10"; Go_0<= '0'; Go_1<= '0';                -- etat des sorties
                    if data = '0'and Fin_trame = '0' then EF <= DCC_0;      -- passe a l'etat DCC_0 si le bit = 0 et ce n'est pas la fin du trame
                    elsif data = '1'and Fin_trame = '0' then EF <= DCC_1;   -- passe a l'etat DCC_1 si le bit = 1 et ce n'est pas la fin du trame
                    elsif Fin_trame = '1' then EF <= Tempo_delai;           -- passe a l'etat Tempo_delai si c'est la fin de trame
                    else EF <= Decalage;                                    -- on reste dans Decalage sinon
                    end if;  
                    
                    
                when DCC_0 =>                                               -- etat DCC_0 qui genere le DCC_Bit_0
                    Go_0 <= '1';                                            -- Demarrage de la generation du bit 0
                    com_reg <= "00";                                        -- Arret du Decalage lors de la generation du bit 0 
                    if Fin_0 = '1' then EF <= Decalage;                     -- passe a l'etat Decalage si la generation du bit 0 est termine
                    else EF <= DCC_0;                                       -- on reste dans DCC_0 sinon
                    end if;
                    
                    
                when DCC_1 =>                                               -- etat DCC_1 qui genere le DCC_Bit_1
                    Go_1 <= '1';                                            -- Demarrage de la generation du bit 1
                    com_reg <= "00";                                        -- Arret du decalage lors de la generation du bit 1
                    if Fin_1 = '1' then EF <= Decalage;                     -- passe a l'etat Decalage si la generation du bit 1 est termine
                    else EF <= DCC_1;                                       -- on reste dans DCC_1 sinon
                    end if;
                
                when Tempo_delai =>                                         -- etat Tempo_delai qui genere le delai de 6ms entre chaque trame
                    com_reg <= "00";                                        -- Arret du Decalage 
                    Start_tempo <= '1';                                     -- Demarrage du comptage de 6ms
                    if Fin_tempo = '1' then EF <= Recuperation;             -- passe a l'etat Recuperation si le compteur atteint 6ms
                    else EF <= Tempo_delai;                                 -- on reste dans Tempo_delai sinon
                    end if;        
                    
             end case;
    end process;
end Behavioral;









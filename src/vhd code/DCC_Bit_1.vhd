----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed 
--
-- Module Name: DCC_Bit_1 - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Generateur d'impulsion pour le bit 1 conformement au protocole DCC
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity DCC_Bit_1 is
  Port (clk100 : in std_logic;          -- Horloge 100 MHz de la carte Basys
        clk1 : in std_logic;            -- Horloge 1 MHz du diviseur d'horloge
        reset: in std_logic;            -- Reset Asynchrone
        Go_1 : in std_logic;            -- Commande de debut d'impulsions
        Fin_1 : out std_logic ;         -- Fin d'impulsions
        dcc_1 : out std_logic);         -- Sortie DCC
end DCC_Bit_1;

architecture Behavioral of DCC_Bit_1 is
    type etat is(S0,S1,S2,S3);
    signal EP,EF : etat;
    signal fin_S,change,arret,dcc_s : std_logic;
    signal cpt : std_logic_vector(8 downto 0);
    begin

	---------------------------
	-- MAE - Registre d'Etat --
	---------------------------
process(clk100, reset)
    begin
    -- Reset Asynchrone
    if reset='1' then EP <= S0;
    -- Si on A un Front d'Horloge
    elsif rising_edge(clk100) then EP <= EF;
    end if;
end process;

	----------------------------------------------
	-- MAE - Evolution des Etats et des Sorties --
	----------------------------------------------
process(EP,Go_1,change,arret)
    begin
        case(EP) is
            -- Sortie DCC a 0
			-- On Reste dans Cet Etat tant que Go_1=0
			-- Si Go_1 passe a 1, on commence a incrementer
            when S0 => EF <= S0; dcc_s <= '0';fin_S <= '0'; 
                    if Go_1='1' then EF <= S1; end if;
                    
            --Sortie DCC reste a 0
            --lorsque le compteur atteint 58, la sortie DCC passe a 1
            when S1 => EF <= S1; dcc_s <= '0'; fin_s <= '0';
                    if Change='1' then EF <= S2; end if;
            
            --Sortie DCC est a 1
            --lorsque le compteur atteint 116, on arrete de generer la sortie DCC
            when S2 => EF <= S2; dcc_s <= '1'; fin_s <= '0';
                    if arret='1' then EF <= S3; end if;
            
            --Positionnement du signal Fin_1 a 1
            --Retour inconditionnel dans l'etat initial
            when S3 => EF <= S0; fin_S <= '1'; dcc_s <= '0';
        end case;
end process;

    -------------------------
    -- GESTION du compteur --
    -------------------------
process(clk1,reset)
    begin
        if reset='1' then cpt<= (others => '0');
        elsif rising_edge(clk1) then
            case( EP ) is
                when S0 => cpt <= (others => '0');
                when S1 => cpt <= cpt + 1; if cpt > 115 then cpt <= (others => '0'); end if;
                when S2 => cpt <= cpt + 1; if cpt > 115 then cpt <= (others => '0'); end if;
                when others => NULL;
            
            end case ;

            if cpt = x"39" then change <= '1';else change <= '0'; end if;   -- si cpt=58, passage impulsion a 1
            if cpt = x"73" then arret <= '1' ;else arret <= '0'; end if;    -- si cpt=116, fin de l'impulsion a 1

        end if;
end process;

Fin_1 <= fin_S;
dcc_1 <= dcc_S;

end Behavioral;
----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed - YANG Zixiao
--
-- Module Name: aff_7seg_basys - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Module principal pour la gestion du 7 segment display
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity aff_7seg_basys is
    Port ( clk100   : in std_logic;                            -- Horloge 100 MHz de la carte Basys
            reset   : in std_logic;                            -- Reset Asynchrone
            valFor7seg    : in std_logic_vector(5 downto 0);   -- Valeur a afficher sur le 7SD
            wordFor7seg : in std_logic_vector(4 downto 0);     -- Mot a afficher sur le 7SD
            sel_seg : out std_logic_vector(3 downto 0);        -- Selection du bloc de segments
            seg     : out std_logic_vector(7 downto 0)	      -- Caractere affiche sur les 7SD
            );
end aff_7seg_basys;

--------------------------------------------------
-- Fonctionnement Afficheurs
--------------------------------------------------
--
--		- Segments Allumes a 0, Eteints a 1
--		- Validation
--				- SEL = 0 --> Affichage des Segments
--				- SEL = 1 --> Segments Eteints

--		- Num��ro des Segments Afficheur (Point = 7)
--
--					  0
--				 --------
--				-			-
--			 5	-			- 1
--				-	  6	    -
--				 --------
--				-			-
--			 4	-			- 2
--				-			-
--				 --------
--				     3
--
--------------------------------------------------

architecture Behavioral of aff_7seg_basys is
signal counter: integer range 0 to 100000; -- Compteur de Temporisation
signal seg3   : std_logic_vector(7 downto 0);
signal seg4   : std_logic_vector(7 downto 0);
begin
    my_aff_valeur: entity work.aff_valeur
        port map(
                valFor7seg => valFor7seg,
                seg3 => seg3,
                seg4 => seg4
                );
                
    process(clk100, reset, wordFor7seg, valFor7seg)
        begin
          if rising_edge(clk100) then
			counter <= counter + 1; 
          if (counter = 99999) then counter <= 0; end if;
			-- affichage de "ADR(addresse) N(numero)"
			   if wordFor7seg = "00000" then 
			      case (counter) is
                     when 75000 => sel_seg <= not "1000"; seg <= not "01011110"; --d
                     when 50000 => sel_seg <= not "0100"; seg <= not "00111001"; --C
                     when 25000 => sel_seg <= not "0010"; seg <= not "00111001"; --C
                     when 00000 => sel_seg <= not "0001"; seg <= not "00000000"; --rien
                     when others => NULL;
                  end case;   
		       elsif reset = '1' then 
		          case (counter) is
                     when 75000 => sel_seg <= not "1000"; seg <= not "00110001"; --R
                     when 50000 => sel_seg <= not "0100"; seg <= not "01101101"; --S
                     when 25000 => sel_seg <= not "0010"; seg <= not "01111000"; --t
                     when 00000 => sel_seg <= not "0001"; seg <= not "01101101"; --S
                     when others => NULL;
                  end case;    
               elsif wordFor7seg(4) = '1' then 
                  case (counter) is    
                     when 75000 => sel_seg <= not "1000"; seg <= not "00110001"; --R
                     when 50000 => sel_seg <= not "0100"; seg <= not "01101101"; --S
                     when 25000 => sel_seg <= not "0010"; seg <= not "01111000"; --t
                     when 00000 => sel_seg <= not "0001"; seg <= not "01110001"; --F
                     when others => NULL;
                  end case;
               elsif wordFor7seg(3) = '1' then 
                  if valFor7seg(5) = '0' then  
                    case (counter) is
                        when 75000 => sel_seg <= not "1000"; seg <= not "01110001"; --F
                        when 50000 => sel_seg <= not "0100"; seg <= not "00111001"; --C
                        when 25000 => sel_seg <= not "0010"; seg <= not seg3; 
                        when 00000 => sel_seg <= not "0001"; seg <= not seg4;
                        when others => NULL;
                    end case;
                  elsif valFor7seg(5) = '1' then 
                    case (counter) is
                        when 75000 => sel_seg <= not "1000"; seg <= not "00111001"; --C
                        when 50000 => sel_seg <= not "0100"; seg <= not "00111000"; --L
                        when 25000 => sel_seg <= not "0010"; seg <= not seg3;
                        when 00000 => sel_seg <= not "0001"; seg <= not seg4;
                        when others => NULL;
                    end case;
                  end if;
               elsif wordFor7seg(2) = '1' then 
                  case (counter) is
                        when 75000 => sel_seg <= not "1000"; seg <= not "01101101"; --S
                        when 50000 => sel_seg <= not "0100"; seg <= not "01111100"; --b
                        when 25000 => sel_seg <= not "0010"; seg <= not seg3;
                        when 00000 => sel_seg <= not "0001"; seg <= not seg4;
                        when others => NULL;
                     end case;
                     
               elsif wordFor7seg(1) = '1' then 
                  case (counter) is
                        when 75000 => sel_seg <= not "1000"; seg <= not "01101101"; --S
                        when 50000 => sel_seg <= not "0100"; seg <= not "01110001"; --F
                        when 25000 => sel_seg <= not "0010"; seg <= not seg3;
                        when 00000 => sel_seg <= not "0001"; seg <= not seg4;
                        when others => NULL;
                  end case;
    
               elsif wordFor7seg(0) = '1' then     --Add N(numero du train)
                    case (counter) is
                        when 75000 => sel_seg <= not "1000"; seg <= not "01110111"; --A
                        when 50000 => sel_seg <= not "0100"; seg <= not "01011110"; --d
                        when 25000 => sel_seg <= not "0010"; seg <= not "01010000"; --r
                        when 00000 => sel_seg <= not "0001"; seg <= not seg4;
                        when others => NULL;
                  end case;
               end if;
         end if;
	end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed - YANG Zixiao
--
-- Module Name: aff_valeur - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Afficheur de valeur sur le 7 segment display
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity aff_valeur is
   Port (   valFor7seg         : in std_logic_vector(5 downto 0);         --valeur a afficher sur le 7SD
            seg3,seg4    : out std_logic_vector(7 downto 0)                --mot a afficher sur le 7SD
            );
end aff_valeur;

architecture Behavioral of aff_valeur is
begin
    process(valFor7seg)
    begin
        case (valFor7seg(4 downto 0)) is
            when "00000" =>                 --0
                seg4 <= "00111111"; --0
                seg3 <= "00111111"; --0
            when "00001" =>                 --1
                seg4 <= "00000110"; --1
                seg3 <= "00111111"; --0
            when "00010" =>                 --2
                seg4 <= "01011011"; --2
                seg3 <= "00111111"; --0
            when "00011" =>                 --3
                seg4 <= "01001111"; --3
                seg3 <= "00111111"; --0
            when "00100" =>                 --4
                seg4 <= "01100110"; --4
                seg3 <= "00111111"; --0
            when "00101" =>                 --5
                seg4 <= "01101101"; --5
                seg3 <= "00111111"; --0
            when "00110" =>                 --6
                seg4 <= "01111101"; --6
                seg3 <= "00111111"; --0
            when "00111" =>                 --7
                seg4 <= "00000111"; --7
                seg3 <= "00111111"; --0
            when "01000" =>                 --8
                seg4 <= "01111111"; --8
                seg3 <= "00111111"; --0
            when "01001" =>                 --9
                seg4 <= "01101111"; --9
                seg3 <= "00111111"; --0
            when "01010" =>                 --10
                seg4 <= "00111111"; --0
                seg3 <= "00000110"; --1
            when "01011" =>                 --11
                seg4 <= "00000110"; --1
                seg3 <= "00000110"; --1
            when "01100" =>                 --12
                seg4 <= "01011011"; --2
                seg3 <= "00000110"; --1
            when "01101" =>                 --13
                seg4 <= "01001111"; --3
                seg3 <= "00000110"; --1
            when "01110" =>                 --14
                seg4 <= "01100110"; --4
                seg3 <= "00000110"; --1
            when "01111" =>                 --15
                seg4 <= "01101101"; --5
                seg3 <= "00000110"; --1
            when "10000" =>                 --16
                seg4 <= "01111101"; --6
                seg3 <= "00000110"; --1
            when "10001" =>                 --17
                seg4 <= "00000111"; --7
                seg3 <= "00000110"; --1
            when "10010" =>                 --18
                seg4 <= "01111111"; --8
                seg3 <= "00000110"; --1
            when "10011" =>                 --19
                seg4 <= "01101111"; --9
                seg3 <= "00000110"; --1
            when "10100" =>                 --20
                seg4 <= "00111111"; --0
                seg3 <= "01011011"; --2
            when "10101" =>                 --21
                seg4 <= "00000110"; --1
                seg3 <= "01011011"; --2
            when "10110" =>                 --22
                seg4 <= "01011011"; --2
                seg3 <= "01011011"; --2
            when "10111" =>                 --23
                seg4 <= "01001111"; --3
                seg3 <= "01011011"; --2
            when "11000" =>                 --24
                seg4 <= "01100110"; --4
                seg3 <= "01011011"; --2
            when "11001" =>                 --25
                seg4 <= "01101101"; --5
                seg3 <= "01011011"; --2
            when "11010" =>                 --26
                seg4 <= "01111101"; --6
                seg3 <= "01011011"; --2
            when "11011" =>                 --27
                seg4 <= "00000111"; --7
                seg3 <= "01011011"; --2
            when "11100" =>                 --28
                seg4 <= "01111111"; --8
                seg3 <= "01011011"; --2
            when "11101" =>                 --29
                seg4 <= "01101111"; --9
                seg3 <= "01011011"; --2
            when "11110" =>                 --30
                seg4 <= "00111111"; --0
                seg3 <= "01001111"; --3
            when "11111" =>                 --31
                seg4 <= "00000110"; --1
                seg3 <= "01001111"; --3
            when others => NULL;
        end case;
    end process;
    
end Behavioral;

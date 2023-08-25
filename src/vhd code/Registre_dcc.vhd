----------------------------------------------------------------------------------
-- Company: SORBONNE UNIVERSITE
-- Designed by: BISLIEV Magomed 
--
-- Module Name: Registre_dcc - Behavioral
-- Project Name: Centrale DCC
-- Target Devices: BASYS 3
-- 
-- Registre de decalage et de chargement de la Centrale DCC
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Registre_dcc is
  Port (clk : in std_logic;                         -- Horloge 100 MHz
        reset: in std_logic;                        -- Reset Asynchrone
        com_reg : in std_logic_vector(1 downto 0);  -- Commande de chargement et decalage de la trame
        trame : in std_logic_vector(50 downto 0);   -- Trame complete
        trame_bit : out std_logic;                  -- Bit de la trame
        Ready : out std_logic;                      -- Trame prete
        Fin_trame : out std_logic);                 -- Fin de la trame
end Registre_dcc;


architecture Behavioral of Registre_dcc is
    signal trameS : std_logic_vector(50 downto 0);
    signal cpt : INTEGER range 0 to 51;
    signal ready_s : std_logic;
    signal fin_s : std_logic;
begin


process(clk, reset)
variable cpt_var : INTEGER range 0 to 51;
begin
    -- Initialisation du compteur, de ready et de Fin
    if reset='1' then cpt_var := 0; ready_s <= '0'; fin_s <= '0'; trameS<=(50 => '1',48 => '1',46 => '1',44 => '1',42 => '1',40 => '1',38 => '1',36 => '1',others => '0');
    elsif rising_edge(clk) then
        case(com_reg) is
                -- Chargement de la trame
                -- Reinitialisation du compteur 
                -- Indication que la trame est prete a etre transmise
            when "01" => trameS <= trame; cpt_var := 0; ready_s <= '1'; fin_s <= '0';
                -- Decrementation du compteur
            when "10" =>  cpt_var := cpt_var + 1; ready_s <= '0';--trame_bit <= trameS(50-cpt_var);  if cpt_var = 51 then cpt_var := 50; end if;
            when others => NULL;
        end case;
        
        -- Fin passe a 1 si toute la trame a ete transmise, reste a 0 sinon
        if cpt_var=51 then fin_s <= '1'; cpt_var:=50; 
        end if;
        cpt <= cpt_var;
    end if;
end process;

-- Acquisition de la trame
trame_bit <= trameS(50-cpt);




ready <= ready_s;
fin_trame <= fin_s;

end Behavioral;

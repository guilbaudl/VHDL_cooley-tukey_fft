----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2019 03:13:16 PM
-- Design Name: 
-- Module Name: fsmMoore - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.complex.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsmMoore is
    port (
        I_rst, I_clk : in std_logic;
        addrR1, addrR2, addrW1, addrW2 : out std_logic_vector(1 downto 0);
        
        din_rts, dout_cts : in std_logic;
        din_cts, dout_rts : out std_logic;
        
        invI, invO : out std_logic; --signaux des inverseurs
        loadInput : out std_logic; --indique si on charge des donnees exterieures ou si on charge les donnes en sortie du butterfly
        id_mem : out std_logic; -- indique la memoire a connecter en sortie de la partie operative
        
        wr_en1 : out std_logic;
        port_en_11, port_en_12 : out std_logic;
        
        wr_en2 : out std_logic;
        port_en_21, port_en_22 : out std_logic;
        
        id_W : out std_logic_vector(1 downto 0)-- indice pour savoir quel W on utilise
        );
        
end fsmMoore;

architecture Behavioral of fsmMoore is
    
    type T_state is (RST,
                     I_x0, I_x1, i_x2, I_x3, I_x4, I_x5, I_x6, I_x7,
                     O_x0, O_x1, O_x2, O_x3, O_x4, O_x5, O_x6, O_x7,
                      
                     S1B1, S1B2, S1B3, S1B4,
                     S2B1, S2B2, S2B3, S2B4,
                     S3B1, S3B2, S3B3, S3B4,
                     Wait_IN, Wait_OUT);
    
    signal S_PresentState : T_state;
    signal S_FutureState : T_state;
    
begin

    prioritary_process : process (I_clk, I_rst) is
    begin  -- process
        if (I_rst = '1') then 
            S_presentState <= RST;
            
        elsif (rising_edge(I_clk)) then 
            S_PresentState <= S_FutureState;
        end if;
    end process;
    
    define_futurestate : process (S_PresentState, S_FutureState, din_rts, dout_cts) is
    begin 
        S_FutureState <= RST;
        case S_PresentState is
        
            when RST =>
                S_FutureState <= Wait_IN;
            
            when Wait_IN =>
                if (din_rts = '1') then 
                    --ne reprend pas le calcul si interruption, doit recharger les données pour éviter des soucis si interruption lors du load
                    S_FutureState <= I_x0;
                end if;
            
            -- chargement de la mémoire   
            when I_x0 =>
                S_FutureState <= I_x1;
            when I_x1 =>
                S_FutureState <= I_x2;
            when I_x2 =>
                S_FutureState <= I_x3;
            when I_x3 =>
                S_FutureState <= I_x4;
            when I_x4 =>
                S_FutureState <= I_x5;
            when I_x5 =>
                S_FutureState <= I_x6;
            when I_x6 =>
                S_FutureState <= I_x7;
            when I_x7 =>
                S_FutureState <= S1B1;
            -- fin de chargement de la mémoire    
            
            -- dechargement de la mémoire   
            when O_x0 =>
                S_FutureState <= O_x1;
            when O_x1 =>
                S_FutureState <= O_x2;
            when O_x2 =>
                S_FutureState <= O_x3;
            when O_x3 =>
                S_FutureState <= O_x4;
            when O_x4 =>
                S_FutureState <= O_x5;
            when O_x5 =>
                S_FutureState <= O_x6;
            when O_x6 =>
                S_FutureState <= O_x7;
            when O_x7 =>
                S_FutureState <= Wait_IN;
            -- fin de dechargement de la mémoire   
            
            when S1B1 =>
                S_FutureState <= S1B2;
                
            when S1B2 =>
                S_FutureState <= S1B3;
                 
            when S1B3 =>
                S_FutureState <= S1B4;
                 
            when S1B4 =>
                S_FutureState <= S2B1;
                 
            when S2B1 =>
                S_FutureState <= S2B2;
                 
            when S2B2 =>
                S_FutureState <= S2B3;
                 
            when S2B3 =>
                S_FutureState <= S2B4;
                 
            when S2B4 =>
                S_FutureState <= S3B1;
                 
            when S3B1 =>
                S_FutureState <= S3B2;
                 
            when S3B2 =>
                S_FutureState <= S3B3;
                 
            when S3B3 =>
                S_FutureState <= S3B4;
                 
            when S3B4 =>
                S_FutureState <= Wait_OUT;
                
            when Wait_OUT =>
                S_FutureState <= Wait_OUT; 
                if (dout_cts = '1') then
                    S_FutureState <= O_x0;
                end if;
                
            when others => null;
        end case;
    end process;
    
    define_actionToDo : process (S_PresentState) is
    begin
    
    --ces ports sont toujours actifs
    port_en_11 <= '1';
    port_en_12 <= '1';
    wr_en1 <= '1';  
    port_en_21 <= '1';
    port_en_22 <= '1';
    wr_en2 <= '1';
    
    addrR1 <= "00";
    addrR2 <= "00";
    addrW1 <= "00"; --egal a r1
    addrW2 <= "00";
    
    loadInput <= '0'; -- par defaut mis a 0 (butterfly sur memoire)
    
    invI <= '0';
    invO <= '0';
    id_W <= "00";
    id_mem <= '0';

    
    din_cts <= '0';
    dout_rts <= '0';

          
        case S_PresentState is
            
            -- first stage
            when RST =>
                addrR1 <= "00";
                addrR2 <= "00";
                addrW1 <= "00"; --egal a r1
                addrW2 <= "00"; --egal a r2
                invI <= '0';
                invO <= '0';
                id_W <= "00";
                
                wr_en1 <= '0';
                wr_en2 <= '0';
                
            when Wait_IN =>
                addrW1 <= "00";
                wr_en2 <= '0';
                loadInput <= '1';
                din_cts <= '1'; --en attente d'info

            when S1B1 =>
                addrR1 <= "00";
                addrR2 <= "00";
                addrW1 <= "00"; --egal a r1
                addrW2 <= "00"; --egal a r2
                invI <= '0';
                invO <= '0';
                id_W <= "00";
                
            when S1B2 =>
                addrR1 <= "01";
                addrR2 <= "01";
                addrW1 <= "01"; --egal a r1
                addrW2 <= "01"; --egal a r2
                invI <= '0';
                invO <= '1';
                id_W <= "00";
                    
            when S1B3 =>
                addrR1 <= "10";
                addrR2 <= "10";
                addrW1 <= "10"; --egal a r1
                addrW2 <= "10"; --egal a r2
                invI <= '0';
                invO <= '0';
                id_W <= "00";
                        
            when S1B4 =>
                addrR1 <= "11";
                addrR2 <= "11";
                addrW1 <= "11"; --egal a r1
                addrW2 <= "11"; --egal a r2
                invI <= '0';
                invO <= '1';
                id_W <= "00";
            --

             
            --second stage
            when S2B1 =>
                 addrR1 <= "00";
                 addrR2 <= "01";
                 addrW1 <= "00"; --egal a r1
                 addrW2 <= "01"; --egal a r2
                 invI <= '0';
                 invO <= '0';
                 id_W <= "00";
                 
            when S2B2 =>
                 addrR1 <= "01";
                 addrR2 <= "00";
                 addrW1 <= "01"; --egal a r1
                 addrW2 <= "00"; --egal a r2
                 invI <= '1'; --a 1 mais on le met a l'etat avant
                 invO <= '0';
                 id_W <= "10";
                 
            when S2B3 =>
                 addrR1 <= "10";
                 addrR2 <= "11";
                 addrW1 <= "10"; --egal a r1
                 addrW2 <= "11"; --egal a r2
                 invI <= '0';
                 invO <= '1';
                 id_W <= "00";

            when S2B4 =>
                 addrR1 <= "11";
                 addrR2 <= "10";
                 addrW1 <= "11"; --egal a r1
                 addrW2 <= "10"; --egal a r2
                 invI <= '1';
                 invO <= '1';
                 id_W <= "10";                
            --
             
            --third stage
            when S3B1 =>
                addrR1 <= "00";
                addrR2 <= "11";
                addrW1 <= "00";
                addrW2 <= "11";
                invI <= '0';
                invO <= '0';
                id_W <= "00";
                
            when S3B2 =>
                addrR1 <= "01";
                addrR2 <= "10";
                addrW1 <= "01";
                addrW2 <= "10";
                invI <= '0';
                invO <= '1';
                id_W <= "01";
                            
            when S3B3 =>
               addrR1 <= "10";
               addrR2 <= "01";
               addrW1 <= "10";
               addrW2 <= "01";
               invI <= '1';
               invO <= '0';
               id_W <= "10";
             
            when S3B4 =>
               addrR1 <= "11";
               addrR2 <= "00";
               addrW1 <= "11";
               addrW2 <= "00";
               invI <= '1';
               invO <= '1';
               id_W <= "11";
            --
            
            when Wait_OUT =>
                dout_rts <= '1';
                wr_en1 <= '0';
                wr_en2 <= '0';
                addrR1 <= "00";
                id_mem <= '0';
                
            -- alloue la memoire aux entrees selectionnees
            when I_x0 =>
                loadInput <= '1';
                addrW1 <= "10"; -- preparation de l'adresse pour x1
                wr_en2 <= '0';
            when I_x1 =>
                loadInput <= '1';
                addrW1 <= "01";
                wr_en2 <= '0';
            when I_x2 =>
                loadInput <= '1';
                addrW1 <= "11";
                wr_en2 <= '0';
            when I_x3 =>
                loadInput <= '1';
                addrW2 <= "00";
                wr_en1 <= '0'; --les echantillons suivant sont a stocker dans la memoire 2
            when I_x4 =>
                loadInput <= '1';
                addrW2 <= "10";
                wr_en1 <= '0';
            when I_x5 =>
                loadInput <= '1';
                addrW2 <= "01";
                wr_en1 <= '0';
            when I_x6 =>
                loadInput <= '1';
                addrW2 <= "11";
                wr_en1 <= '0';
            when I_x7 =>
                loadInput <= '0'; --fin du chargement des entrees
                wr_en1 <= '0';
                wr_en2 <= '0';
            --
        
            -- indique les adresses de lecture
            when O_x0 =>
                 wr_en1 <= '0';
                wr_en2 <= '0';           
                addrR2 <= "10";
                id_mem <= '1';
            when O_x1 =>
                wr_en1 <= '0';
                wr_en2 <= '0';            
                addrR1 <= "10";
                id_mem <= '0';
            when O_x2 =>
                wr_en1 <= '0';
                wr_en2 <= '0';            
                addrR2 <= "00";
                id_mem <= '1';
            when O_x3 =>
                wr_en1 <= '0';
                wr_en2 <= '0';                
                addrR2 <= "11";
                id_mem <= '1';
            when O_x4 =>
                wr_en1 <= '0';
                wr_en2 <= '0';                
                addrR1 <= "01";
                id_mem <= '0';
            when O_x5 =>
                wr_en1 <= '0';
                wr_en2 <= '0';                
                addrR2 <= "01";
                id_mem <= '1';
            when O_x6 =>
                wr_en1 <= '0';
                wr_en2 <= '0';                
                addrR1 <= "11";
                id_mem <= '0';
            when O_x7 =>
                wr_en1 <= '0';
                wr_en2 <= '0'; 
            --
            
            
            end case;
        end process;
end Behavioral;

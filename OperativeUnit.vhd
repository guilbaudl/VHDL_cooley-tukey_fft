----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2019 04:27:17 PM
-- Design Name: 
-- Module Name: OperativeUnit - Behavioral
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
use work.complex.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OperativeUnit is
    port(
        I_rst, I_clk : in std_logic;
        invI, invO : in std_logic;
        id_W : in std_logic_vector(1 downto 0);
        
        dataOUT1, dataOUT2 : in complex_x;
        dataIN1, dataIN2 : out complex_x;
        
        loadInput : in std_logic;
        id_mem : in std_logic;
        
        din : in complex_x;
        dout : out complex_x
        );
        
end OperativeUnit;



architecture Behavioral of OperativeUnit is

    signal butIN1, butIN2, butOUT1, butOUT2 : complex_x;
    signal S_w : complex_w;
    signal S_switchOut1, S_switchOut2 : complex_x;
    
begin

    S_w <= W(conv_integer(id_w)); -- convertit le signal sur 2 bits en indice pour pour la liste

    dataIN1 <= din when(loadInput='1') else S_switchOut1;
    dataIN2 <= din when(loadInput='1') else S_switchOut2;
    
    dout <= dataOUT1 when(id_mem='0') else dataOUT2;

    
    switchIn : entity work.switch
        port map(
        in1      =>  dataOUT1,
        in2      =>  dataOUT2,
        inv      =>  invI,
        out1     =>  butIN1,
        out2     =>  butIN2);
            
   butterfly : entity work.butterfly
        port map(
        a       => butIN1,
        b       => butIN2,
        w       => S_w,
        aS      => butOUT1,
        bS      => butOUT2
        );
        
            
            
    switchOut : entity work.switch
        port map(
        in1      =>  butOUT1,
        in2      =>  butOUT2,
        inv      =>  invO,
        out1     =>  S_switchOut1,
        out2     =>  S_switchOut2);
        
            

end Behavioral;

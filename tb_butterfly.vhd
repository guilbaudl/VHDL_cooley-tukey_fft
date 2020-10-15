----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2019 02:18:24 PM
-- Design Name: 
-- Module Name: tb_butterfly - Behavioral
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
use IEEE.NUMERIC_STD.all;

use work.complex.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_butterfly is
--  Port ( );
end tb_butterfly;

architecture Behavioral of tb_butterfly is

    -- constant un_quart : integer := integer(round(0.25 * 2.0**q_w));
    -- constant a : complex_x := (to_signed(un_quart, length_x),to_signed(2*2**q_x,length_x));
    
    constant a : complex_x := ("00000000000000000001000", to_signed(-4*2**q_x,length_x));
    constant b : complex_x := (to_signed(3*2**q_x,length_x),to_signed(-4*2**q_x,length_x));
    constant w : complex_w := W(1);
    
    signal S_aS, S_bS : complex_x;

begin

    BUT : entity work.butterfly
        port map (
            a => a,
            b => b,
            w => w,
            aS => S_aS,
            bS => S_bS
            );


end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2019 11:45:20 AM
-- Design Name: 
-- Module Name: butterfly - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use work.complex.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity butterfly is
    
    port(
--        ar, ai, br, bi, wr, wi : in signed;
--        but_r1, but_i1, but_r2, but_i2 : out signed);
        a, b : in complex_x;
        w : in complex_w;
        aS, bS : out complex_x
        );
        
end entity butterfly;

architecture Behavioral of butterfly is

  function round_signed (
    constant output_size : natural;
    input                : signed)
    return signed is
    variable result : signed(output_size -1 downto 0);
  begin
    if input(input'length-output_size-1) = '1' then
      result := input(input'length-1 downto input'length-output_size) + 1;
    else
      result := input(input'length-1 downto input'length-output_size);
    end if;
    --VHDL 2008:
    --result := input(input'length-1 downto input'length-output_size) + 1 when input(input'length-output_size-1)='1' else input(input'length-1 downto input'length-output_size);
    return result;
  end round_signed;

    --signal sar, sbr : signed(length_x downto 0);

begin
--    but_r1 <= ar + br*wr - bi*wi;
--    but_i1 <= ai + br*wi + bi*wr;
    
--    but_r2 <= ar - (br*wr - bi*wi);
--    but_i2 <= ai - (br*wi + bi*wr);

    --sar  <= resize(round_signed(length_x+2, b(0) * w(0)), length_x+1);
    --sbr  <= resize(round_signed(length_x+2, b(1) * w(1)), length_x+1);
    
--     aS(0) <= resize(a(0) + round_signed(length_x+2, b(0) * w(0)) - round_signed(length_x+2, b(1) * w(1)), length_x);
--     aS(1) <= resize(a(1) + round_signed(length_x+2, b(0) * w(1))+ round_signed(length_x+2, b(1) * w(0)), length_x);
--     bS(0) <= resize(a(0) - round_signed(length_x + 2, b(0) * w(0)) - round_signed(length_x+2, b(1) * w(1)), length_x);
--     bS(1) <= resize(a(1) - (round_signed(length_x + 2, b(0) * w(1)) + round_signed(length_x + 2, b(1) * w(0))), length_x);    

     aS(0) <= resize(a(0) + round_signed(length_x+2, b(0) * w(0)) - round_signed(length_x+2, b(1) * w(1)), length_x);
     aS(1) <= resize(a(1) + round_signed(length_x+2, b(0) * w(1))+ round_signed(length_x+2, b(1) * w(0)), length_x);
     bS(0) <= resize(a(0) - (round_signed(length_x + 2, b(0) * w(0)) - round_signed(length_x+2, b(1) * w(1))), length_x);
     bS(1) <= resize(a(1) - (round_signed(length_x + 2, b(0) * w(1)) + round_signed(length_x + 2, b(1) * w(0))), length_x);

    
    
--    aS(0) <= a(0) + b(0)*w(0) - b(1)*w(1);
--    aS(1) <= a(1) + b(0)*w(1) + b(1)*w(0);
    
--    bS(0) <= a(0) - (b(0)*w(0) - b(1)*w(1));
--    bS(1) <= a(1) - (b(0)*w(1) + b(1)*w(0));

end Behavioral;

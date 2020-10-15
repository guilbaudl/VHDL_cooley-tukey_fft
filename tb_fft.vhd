----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2019 04:24:06 PM
-- Design Name: 
-- Module Name: tb_fft - Behavioral
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
use IEEE.NUMERIC_STD.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_fft is
--  Port ( );
end tb_fft;

architecture Behavioral of tb_fft is

constant clk_period : integer := 10;

signal I_clk      : std_logic := '1';
signal I_rst      : std_logic;
signal S_din      : complex_x;
signal S_dout     : complex_x;
signal S_din_rts, S_dout_rts, S_din_cts, S_dout_cts : std_logic := '0';

constant x0 : complex_x := (to_signed(0,length_x), to_signed(456*2**q_x,length_x));
constant x1 : complex_x := (to_signed(120*2**q_x,length_x),to_signed(234*2**q_x,length_x));
constant x2 : complex_x := (to_signed(234*2**q_x,length_x),to_signed(120*2**q_x,length_x));
constant x3 : complex_x := (to_signed(120*2**q_x,length_x),to_signed(0*2**q_x,length_x));
constant x4 : complex_x := (to_signed(0*2**q_x,length_x),to_signed(-120*2**q_x,length_x));
constant x5 : complex_x := (to_signed(-120*2**q_x,length_x),to_signed(-234*2**q_x,length_x));
constant x6 : complex_x := (to_signed(-234*2**q_x,length_x),to_signed(-456*2**q_x,length_x));
constant x7 : complex_x := (to_signed(-120*2**q_x,length_x),to_signed(-768*2**q_x,length_x));

signal x0_out : complex_x;
signal x1_out : complex_x;
signal x2_out : complex_x;
signal x3_out : complex_x;
signal x4_out : complex_x;
signal x5_out : complex_x;
signal x6_out : complex_x;
signal x7_out : complex_x;


begin

    FFT : entity work.fft
        port map (
        I_clk       => I_clk,
        I_rst       => I_rst,
        din         => S_din,
        din_rts     => S_din_rts,
        dout_cts    => S_dout_cts,
        dout        => S_dout,
        din_cts     => S_din_cts,
        dout_rts    => S_dout_rts
        );
        
    -- clock generation
    I_clk      <= not I_clk after 7 ns;
    I_rst      <= '0', '1'  after 13 ns, '0' after 31 ns;
    

    
    process  -- process de pilotage des entrees
    begin
          
        wait until rising_edge(I_clk);
        S_din <= x0;
        
        S_din_rts <= '1';
        
        wait until S_din_cts = '1';
        --wait until I_rst = '0';
        wait until rising_edge(I_clk);
        S_din <= x1;
        S_din_rts <= '0';
        
        wait until rising_edge(I_clk);
        S_din <= x2;
        
        wait until rising_edge(I_clk);
        S_din <= x3;
        
        wait until rising_edge(I_clk);
        S_din <= x4;
        
        wait until rising_edge(I_clk);
        S_din <= x5;
        
        wait until rising_edge(I_clk);
        S_din <= x6;
        
        wait until rising_edge(I_clk);
        S_din <= x7;

    end process;
    
    process  -- process de pilotage des sorties
    begin
    
        S_dout_cts <= '1';
        
        
        
        wait until S_dout_rts = '1';
        
        wait until rising_edge(I_clk);
        x0_out <= S_dout;

        wait until rising_edge(I_clk);
        x1_out <= S_dout;
        
        wait until rising_edge(I_clk);
        x2_out <= S_dout;
        
        wait until rising_edge(I_clk);
        x3_out <= S_dout;
        
        wait until rising_edge(I_clk);
        x4_out <= S_dout;
        
        wait until rising_edge(I_clk);
        x5_out <= S_dout;
        
        wait until rising_edge(I_clk);
        x6_out <= S_dout;
        
        wait until rising_edge(I_clk);
        x7_out <= S_dout;
     
     end process;
        
end Behavioral;

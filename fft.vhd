----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2019 05:11:43 PM
-- Design Name: 
-- Module Name: fft - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fft is
  Port (
    I_clk : in std_logic;
    I_rst : in std_logic;
    din : in complex_x;
    din_rts, dout_cts : in std_logic;
    dout : out complex_x;
    din_cts, dout_rts : out std_logic
    );
end fft;

architecture Behavioral of fft is

    
    signal S_addrR1, S_addrR2, S_addrW1, S_addrW2 : std_logic_vector(1 downto 0);
    signal S_data_out1, S_data_in1, S_data_out2, S_data_in2 : complex_x;
    signal S_invI, S_invO : std_logic;
    signal S_id_W : std_logic_vector(1 downto 0);
    signal S_wr_en1, S_wr_en2, S_port_en11, S_port_en12, S_port_en21, S_port_en22 : std_logic;
    signal S_loadInput, S_id_mem : std_logic;
    signal temp : complex_x;
    

begin

    opUnit : entity work.OperativeUnit
        port map(
        I_rst    => I_rst,
        I_clk    => I_clk,
        invI     => S_invI,
        invO     => S_invO,
        id_w     => S_id_w,
        dataOUT1 => S_data_out1,
        dataOUT2 => S_data_out2,
        dataIN1  => S_data_in1,
        dataIN2  => S_data_in2,
        loadInput=> S_loadInput,
        id_mem   => S_id_mem,
        din      => din,
        dout     => dout
        );
        
    fsm : entity work.fsmMoore
        port map(
        I_rst       => I_rst,
        I_clk       => I_clk,
        addrR1      => S_addrR1,
        addrR2      => S_addrR2,
        addrW1      => S_addrW1,
        addrW2      => S_addrW2,
        din_rts     => din_rts,
        dout_cts    => dout_cts,
        din_cts     => din_cts,
        dout_rts    => dout_rts,
        invI        => S_invI,
        invO        => S_invO,
        loadInput   => S_loadInput,
        id_mem      => S_id_mem,
        wr_en1      => S_wr_en1,
        port_en_11  => S_port_en11,
        port_en_12  => S_port_en12,
        wr_en2      => S_wr_en2,
        port_en_21  => S_port_en21,
        port_en_22  => S_port_en22,
        id_w        => S_id_W
        );
        
     mem1 : entity work.dualportRam
        port map(
        clk => I_clk,
        wr_en => S_wr_en1,
        data_in => S_data_in1,
        addr_in_0 => S_addrW1,
        addr_in_1 => S_addrR1,
        port_en_0 => S_port_en11,
        port_en_1 => S_port_en12,
        --data_out_0 => temp, --not useful
        data_out_1 =>S_data_out1
        );     
           
     mem2 : entity work.dualportRam
        port map(
        clk => I_clk,
        wr_en => S_wr_en2,
        data_in => S_data_in2,
        addr_in_0 => S_addrW2,
        addr_in_1 => S_addrR2,
        port_en_0 => S_port_en21,
        port_en_1 => S_port_en22,
        --data_out_0 => temp, --not useful
        data_out_1 =>S_data_out2
        );

end Behavioral;

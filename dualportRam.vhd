----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2019 02:10:54 PM
-- Design Name: 
-- Module Name: dualportRam - package
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
-- any Xilinx leaf cells in -this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dualportRam is
    port(   clk : in std_logic; --clock
            wr_en : in std_logic;   --write enable for port 0
            data_in : in complex_x;  --Input data to port 0.
            addr_in_0 : in std_logic_vector(1 downto 0);    --address for port 0
            addr_in_1 : in std_logic_vector(1 downto 0);    --address for port 1
            port_en_0 : in std_logic;   --enable port 0.
            port_en_1 : in std_logic;   --enable port 1.
            --data_out_0 : out complex_x;  --output data from port 0.
            data_out_1 : out complex_x   --output data from port 1.
        );
end dualportRam;


architecture Behavioral of dualportRam is

    type ram_type is array(0 to 3) of complex_x;
    signal ram : ram_type := (others => (others => (others => '0')));
    
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            --For port 0. Writing.
            if(port_en_0 = '1') then    --check enable signal
                if(wr_en = '1') then    --see if write enable is ON.
                    ram(conv_integer(addr_in_0)) <= data_in;
                end if;
            end if;
        end if;
    end process;

--always read when port is enabled.
--data_out_0 <= ram(conv_integer(addr_in_0)) when (port_en_0 = '1') else
--            (others => (others => '0'));
data_out_1 <= ram(conv_integer(addr_in_1)) when (port_en_1 = '1') else
            (others => (others => '0'));
            
end Behavioral;
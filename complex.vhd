--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.ALL;

package complex is

    ----------- definition de p et q ----------- 
    constant p_x : integer := 18;
    constant q_x : integer := 5;
    constant length_x : integer := p_x + q_x;
    
    constant p_w : integer := 2;
    constant q_w : integer := p_x + q_x - 1;
    constant length_w : integer := p_w + q_w;
    --------------------------------------------

    constant cos_pi_over_4 : integer := integer(round(cos(MATH_PI_OVER_4) * 2.0**q_w));

	type complex_x is array (0 to 1) of signed(p_x + q_x - 1 downto 0);
	
    type complex_w is array (0 to 1) of signed(p_w + q_w - 1 downto 0);
    
	type type_x is array (0 to 7) of complex_x;
	
	type type_w is array (0 to 3) of complex_w;
	
	constant W : type_w := ((to_signed(1*2**q_w, length_w), to_signed(0, length_w)),
	                         (to_signed(cos_pi_over_4, length_w), to_signed(-cos_pi_over_4, length_w)),
	                         (to_signed(0, length_w), to_signed((-1)*2**q_w, length_w)),
	                         (to_signed(-cos_pi_over_4, length_w), to_signed(-cos_pi_over_4, length_w))
	                         );
	
	
	
	
-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--
-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

end complex;

package body complex is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end complex;

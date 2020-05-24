library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;         -- Needed for shift

entity square is
    Port ( A : in   std_logic_vector (31 downto 0);
           D : out  std_logic_vector (31 downto 0));
end square;

architecture Behavioral of square is
  signal W : unsigned(31 downto 0);

  -- The ROM is represented as an array
  --
  -- TODO: change the value 7 to reflect the size of your ROM. In this
  -- there are 8 words, numbered 0 to 7.
  --
  type square_type is array (0 to 12) of std_logic_vector (31 downto 0);   
  
  -- These are the contents of the ROM in 32 bit hex words
  -- The contents of address zero comes first in this array
  --
  -- TODO: change the contents to be what you want - the array must be
  --       the same size as the value you entered above
  -- 
  constant SQUAREarr : square_type :=
	 
	  (x"00004820",  -- add $t1, $0, $0
		  --begin:
		 x"21290001", -- addi $t1, $t1, 1
		 x"200a0001", -- addi $t2, $0, 1
		 x"00005820", -- add $t3, $0, $0
		 x"212c0000", -- addi $t4, $t1, 0
		  --loop:
		 x"016a5820", -- add $t3, $t3, $t2
		 x"214a0002", -- addi $t2, $2, 2
		 x"218cffff", -- addi $t4, $t4, -1
		 x"01816022", -- 
		 x"11800001", -- beq $t4, $0, terminate
		 x"08000005", -- j loop
		  --terminate:
		 x"ac0bfff0", -- sw $t3, 0xFFFFFFF0
		 X"08000001"); -- j begin



begin
  W <= shift_right(unsigned(A), 2); -- The address is in bytes and we want a word address
  D <= SQUAREarr(to_integer(W));       -- Get the value from the array
end Behavioral;
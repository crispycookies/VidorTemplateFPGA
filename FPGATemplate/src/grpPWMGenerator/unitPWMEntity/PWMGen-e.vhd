library IEEE;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity PWMGen is
	generic(
		gRegisterBitWidth : integer := 12
	);
	port(
		iClk : in std_ulogic;
		iResetN : in std_ulogic;
		
		iPRR : in unsigned(gRegisterBitWidth-1 downto 0);
		iARR : in unsigned(gRegisterBitWidth-1 downto 0);
		
		oPulse : out std_ulogic
	);
end entity;

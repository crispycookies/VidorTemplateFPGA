library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity ADDER is
  generic(
    gBitWidth : integer := 32
  );
  port(
    iA : unsigned(gBitWidth-1 downto 0);
    iB : unsigned(gBitWidth-1 downto 0);
    iC : std_ulogic;
    oE : unsigned(gBitWidth-1 downto 0);
    oC : std_ulogic
  );
end entity;

architecture RTL of ADDER is
    signal AOp : unsigned(gBitWidth-1 downto 0);
    signal BOp : unsigned(gBitWidth-1 downto 0);
    signal COp : unsigned(gBitWidth-1 downto 0);
    signal ERes : unsigned(gBitWidth+1 downto 0);
    signal CRes : unsigned(gBitWidth+1 downto 0);
  begin
      AOp <= iA;
      BOp <= iB;
      COp <= iC;

      oE  <= ERes(gBitWidth downto 1);
      oC  <= CRes;


      ERes <= ('0'&AOp&'1') + ('0'&BOp&iC);
      CRes <= ERes(ERes'LEFT);
end architecture;

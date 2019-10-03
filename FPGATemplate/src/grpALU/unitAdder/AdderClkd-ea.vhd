library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity ADDER_CLKD is
  generic(
    gBitWidth : integer := 32
  );
  port(
    iA        : unsigned(gBitWidth-1 downto 0);
    iB        : unsigned(gBitWidth-1 downto 0);
    iC        : std_ulogic;
    iCLK      : std_ulogic;
    iRESETn   : std_ulogic;
    oE        : unsigned(gBitWidth-1 downto 0);
    oC        : std_ulogic
  );
end entity;

architecture RTL of ADDER_CLKD is
  signal oER, oERN  : unsigned(gBitWidth-1 downto 0);
  signal oCR, oCRN  : std_ulogic;
begin

ADDER: entity work.ADDER(RTL)
  generic map (
            gBitWidth => gBitWidth
            )
  port map(
            iA  =>   iA,
            iB  =>   iB,
            iC  =>   iC,
            oE  =>   oERN,
            oC  =>   oCRN
  )

REG: process(iRESETn, iClk) is
  begin
    if(iRESETn='0') then
      oER <= (others=>'0');
      oCR <= '0';
    elsif(rising_edge(iClk)) then
      oER <= oERN;
      oCR <= oCRN;
    end if;
end process

oE <= oER;
oC <= oCR;

end architecture;

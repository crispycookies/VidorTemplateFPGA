-- @author Tobias Felix Egger
-- @date 2019.6.02
-- @revision 1
-- @file Simple_RAM-ea.vhd
-- @brief Simple RAM for when one Side is supposed to Write and the other Read
-- @description
--    RAM Instantiation
--    RAM Write and Read are supposed to be from two different Devices,
--    therefore a separate read and write lane
-- @license
--	 This program is free software: you can redistribute it and/or modify
--	 it under the terms of the GNU General Public License as published by
--	 the Free Software Foundation, either version 3 of the License, or
--	 (at your option) any later version.
--
--	 This program is distributed in the hope that it will be useful,
--	 but WITHOUT ANY WARRANTY; without even the implied warranty of
--	 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--	 GNU General Public License for more details.
--
--	 You should have received a copy of the GNU General Public License
--	 along with this program.  If not, see <http://www.gnu.org/licenses/>.

library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity SIMPLE_RAM is
  generic(
    gAddressWidth     : integer;
    gDataBusWidth     : integer;
    gRamSize          : integer
  );
  port(
    iAddressWrite     : in unsigned(gAddressWidth-1 downto 0);
    iAddressRead      : in unsigned(gAddressWidth-1 downto 0);
    iDataBus          : in unsigned(gDataBusWidth-1 downto 0);
    oDataOut          : out unsigned(gDataBusWidth-1 downto 0);
    iCLK              : in std_ulogic;
    iWriteEN          : in std_ulogic;
    iReadEN           : in std_ulogic
  );
end entity;

architecture RTL of SIMPLE_RAM is
  type MEM is array(gRamSize-1 downto 0) of unsigned(gDataBusWidth-1 downto 0);
  signal RAM_BLOCK                : MEM;
  signal AddrWrite                : integer range 0 to gRamSize;
  signal AddrReadR, AddrReadNext  : integer range 0 to gRamSize;
begin

  AddrReadNext  <= to_integer(iAddressRead);

  RAMBLOCKWR: process(iCLK) is
    begin
      if(rising_edge(iCLK)) then
        AddrReadR <= AddrReadNext;
        if(iWriteEN = '1') then
          RAM_BLOCK(AddrWrite) <= iDataBus;
        end if;
        oDataOut <= RAM_BLOCK(AddrReadR);
      end if;

  end process;

end architecture;

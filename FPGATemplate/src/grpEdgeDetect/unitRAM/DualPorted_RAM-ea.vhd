-- @author Tobias Felix Egger
-- @date 2019.6.02
-- @revision 1
-- @file RAM Instantiation
-- @brief RAM De Facto Dual Ported
-- @description
--    RAM Instantiation
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

entity DUAL_PORTED_RAM is
  generic(
    gAddressWidth     : integer;
    gDataBusWidth     : integer;
    --gDataBusWidth     : integer;
    gRamSize          : integer
  );
  port(
    iAddressWriteA    : in unsigned(gAddressWidth-1 downto 0);
    iAddressReadA     : in unsigned(gAddressWidth-1 downto 0);

    iAddressWriteB    : in unsigned(gAddressWidth-1 downto 0);
    iAddressReadB     : in unsigned(gAddressWidth-1 downto 0);

    iDataBusA         : in unsigned(gDataBusWidth-1 downto 0);
    oDataOutA         : out unsigned(gDataBusWidth-1 downto 0);

    iDataBusB         : in unsigned(gDataBusWidth-1 downto 0);
    oDataOutB         : out unsigned(gDataBusWidth-1 downto 0);

    iCLK              : in std_ulogic;
    iWriteENA         : in std_ulogic;
    iWriteENB         : in std_ulogic;
    iReadENA          : in std_ulogic;
    iReadENB          : in std_ulogic
  );
end entity;

architecture RTL of DUAL_PORTED_RAM is
  type MEM is array(gRamSize-1 downto 0) of unsigned(gDataBusWidth-1 downto 0);
  shared variable RAM_BLOCK                  : MEM;
  signal          AddrWriteA                 : integer range 0 to gRamSize;
  signal          AddrWriteB                 : integer range 0 to gRamSize;
  signal          AddrReadAR, AddrReadANext  : integer range 0 to gRamSize;
  signal          AddrReadBR, AddrReadBNext  : integer range 0 to gRamSize;
begin

  AddrWriteA     <= to_integer(iAddressWriteA);
  AddrReadANext  <= to_integer(iAddressReadA);

  AddrWriteB     <= to_integer(iAddressWriteB);
  AddrReadBNext  <= to_integer(iAddressReadB);

  RAMBLOCK: process(iCLK) is
    begin
      if(rising_edge(iCLK)) then
        AddrReadAR <= AddrReadANext;
        if(iWriteENA = '1') then
          RAM_BLOCK(AddrWriteA) := iDataBusA;
          oDataOutA <= iDataBusA;
        else
          oDataOutA <= RAM_BLOCK(AddrReadANext);
        end if;
      end if;

  end process;


  RAMBLOCKB: process(iCLK) is
    begin
      if(rising_edge(iCLK)) then
        AddrReadBR <= AddrReadBNext;
        if(iWriteENB = '1') then
          RAM_BLOCK(AddrWriteB) := iDataBusB;
          oDataOutB <= iDataBusB;
        else
          oDataOutB <= RAM_BLOCK(AddrReadBNext);
        end if;
      end if;
    end process;

end architecture;

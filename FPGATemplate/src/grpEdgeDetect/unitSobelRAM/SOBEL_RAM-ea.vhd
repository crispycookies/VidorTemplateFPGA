-- @author Tobias Felix Egger
-- @date 2019.5.27
-- @revision 1
-- @file SOBEL_RAM-ea.vhd
-- @brief Configurable RAM Buffer for Sobel Matrix
-- @description
--    Sobel Buffer and Statemachine to fill the Outputbuffer
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

use work.SobelPackage.all;

entity SOBEL_RAM is
  generic(
      gBitWidth                      : integer;
      gNumOfChannels                 : integer;
      gOffset                        : integer;

      -- WeightMatrixStructure
      --A|B|C
      --D|M|F
      --G|H|I
      gWeightPerOperationA           : integer;
      gWeightPerOperationB           : integer;
      gWeightPerOperationC           : integer;
      gWeightPerOperationD           : integer;
      gWeightPerOperationM           : integer;
      gWeightPerOperationF           : integer;
      gWeightPerOperationG           : integer;
      gWeightPerOperationH           : integer;
      gWeightPerOperationi           : integer;

      -- gMatrixDimensionsRAMXY
      -- must be whole multiple of
      -- gMatrixDimensionsSobelCellsXY

      gMatrixDimensionsSobelCellsX   : integer;
      gMatrixDimensionsSobelCellsY   : integer;

      gMatrixDimensionsRAMX          : integer;
      gMatrixDimensionsRAMY          : integer
  );
  port(
      iAddress                       : unsigned(gInterfaceWidth-1 downto 0);
      iData                          : unsigned(gInterfaceWidth-1 downto 0);
      iClk                           : std_ulogic;
      iResetN                        : std_ulogic;
      iWrite                         : std_ulogic;
      iRead                          : std_ulogic;
      oData                          : unsigned(gInterfaceWidth-1 downto 0);
      oReadable                      : std_ulogic;
      oWriteable                     ; std_ulogic
  );
end entity;

architecture RTL of SOBEL_RAM is
begin

end architecture;

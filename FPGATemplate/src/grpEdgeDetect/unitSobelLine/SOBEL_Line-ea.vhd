-- @author Tobias Felix Egger
-- @date 2019.5.25
-- @revision 1
-- @file SOBEL_LINE-ea.vhd
-- @brief Configurable Operator(Sobel...)
-- @description
--    Linewise Sobel Operations
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

entity SOBEL_LINE is
  generic(
    gBitWidth       : integer;
    gNumOfChannels  : integer;
    gOffset         : integer;

    -- WeightMatrixStructure
    --A|B|C
    --D|M|F
    --G|H|I
    gWeightPerOperationA : integer;
    gWeightPerOperationB : integer;
    gWeightPerOperationC : integer;
    gWeightPerOperationD : integer;
    gWeightPerOperationM : integer;
    gWeightPerOperationF : integer;
    gWeightPerOperationG : integer;
    gWeightPerOperationH : integer;
    gWeightPerOperationi : integer;

    gLineLenght          : integer
  );
  port(
    iClk              : in std_ulogic;
    iResetN           : in std_ulogic;

    iInputLineMatrix  : in sobel_matrix_t
                            (gLineLenght-1 downto 0)
                            (2 downto 0)
                            (gNumOfChannels-1 downto 0)
                            (gBitWidth-1 downto 0);
    oOutputLine       : out sobel_line_t
                            (gLineLenght-1 downto 1)
                            (gNumOfChannels-1 downto 0)
                            (gBitWidth-1 downto 0)
  );
end entity;


architecture RTL of SOBEL_LINE is
begin

SOBEL_OPERATORS:
  for i in 1 to gLineLenght-2 generate
    SOBEL_OPERATOR:
      entity work.SOBEL(RTL)
        generic map(
          gBitWidth								=> 	gBitWidth,
          gOffset									=> 	gOffset,

          gWeightPerOperationA		=> 	gWeightPerOperationA,
          gWeightPerOperationB		=> 	gWeightPerOperationB,
          gWeightPerOperationC		=> 	gWeightPerOperationC,

          gWeightPerOperationD		=> 	gWeightPerOperationD,
          gWeightPerOperationM		=> 	gWeightPerOperationM,
          gWeightPerOperationF		=> 	gWeightPerOperationF,

          gWeightPerOperationG		=> 	gWeightPerOperationG,
          gWeightPerOperationH		=> 	gWeightPerOperationH,
          gWeightPerOperationI		=>	gWeightPerOperationI,

          gNumOfChannels				  => 	gNumOfChannels
        )
        port map(
          iInputVectorA						=> iInputLineMatrix(i-1)(2),
          iInputVectorB						=> iInputLineMatrix(i  )(2),
          iInputVectorC						=> iInputLineMatrix(i+1)(2),

          iInputVectorD						=> iInputLineMatrix(i-1)(1),
          iInputVectorM						=> iInputLineMatrix(i  )(1),
          iInputVectorF						=> iInputLineMatrix(i+1)(1),

          iInputVectorG						=> iInputLineMatrix(i-1)(0),
          iInputVectorH						=> iInputLineMatrix(i  )(0),
          iInputVectorI						=> iInputLineMatrix(i+1)(0),
          iClk 				 						=> iClk,
          iResetN				 					=> iResetN,
          oOutputVector						=> oOutputLine(i)
          );
  end generate;

end architecture;

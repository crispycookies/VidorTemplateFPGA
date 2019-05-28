-- @author Tobias Felix Egger
-- @date 2019.5.25
-- @revision 1
-- @file SOBEL_CLUSTER-ea.vhd
-- @brief Configurable Operator(Sobel...)
-- @description
--    Cluster of Sobel Operators
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

entity SOBEL_MATRIX is
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

    gMatrixDimensionsX   : integer;
    gMatrixDimensionsY   : integer
  );
  port(
    iClk         : in std_ulogic;
    iResetN      : in std_ulogic;

    iInputMatrix : in sobel_matrix_t
                      (gMatrixDimensionsX-1 downto 0)
                      (gMatrixDimensionsY-1 downto 0)
                      (gNumOfChannels-1 downto 0)
                      (gBitWidth-1 downto 0);
    -- By the nature of the Sobel Operator,
    -- the Output Matrix shrinks by 2 in x,y- Direction
    oOutputMatrix : out sobel_matrix_t
                      (gMatrixDimensionsX-3 downto 0)
                      (gMatrixDimensionsY-3 downto 0)
                      (gNumOfChannels-1 downto 0)
                      (gBitWidth-1 downto 0)
  );
end entity;


architecture RTL of SOBEL_MATRIX is
begin

  SOBEL_LINES :
        for i in 1 downto gMatrixDimensionsY-1 generate
          SOBEL_LINE_SINGUALR : entity work.SOBEL_LINE(RTL)
            generic map(
              gBitWidth           =>   gBitWidth,
              gNumOfChannels      =>   gNumOfChannels,
              gOffset             =>   gOffset,

              -- WeightMatrixStructure
              --A|B|C
              --D|M|F
              --G|H|I
              gWeightPerOperationA => gWeightPerOperationA,
              gWeightPerOperationB => gWeightPerOperationB,
              gWeightPerOperationC => gWeightPerOperationC,
              gWeightPerOperationD => gWeightPerOperationD,
              gWeightPerOperationM => gWeightPerOperationM,
              gWeightPerOperationF => gWeightPerOperationF,
              gWeightPerOperationG => gWeightPerOperationG,
              gWeightPerOperationH => gWeightPerOperationH,
              gWeightPerOperationI => gWeightPerOperationI,

              gLineLenght          => gMatrixDimensionsX
            )
            port map(
              iClk                 => iClk,
              iResetN              => iResetN,

              iInputLineMatrix     => iInputMatrix (gMatrixDimensionsX-1 downto 0)(i+1 downto i-1),
              oOutputLine          => oOutputMatrix(gMatrixDimensionsX-3 downto 0)(i-1)
            );
        end generate;
end architecture;

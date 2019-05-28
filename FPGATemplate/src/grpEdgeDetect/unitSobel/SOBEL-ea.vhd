-- @author Tobias Felix Egger
-- @date 2019.5.25
-- @revision 1
-- @file SOBEL-ea.vhd
-- @brief Configurable Operator(Sobel...)
-- @description
-- 		Operator accepts multiple channels(RGG...CMYK.. etc..).
-- 		Every Channel represents one value(e.g. Red)
--    Weight Matrix must be configured
--    You can choose your own Parameters to make either a Sobel, or,
--		for example,
--		a Prewitt Operator.
--		The Name of the Entity reflects only a possible usage, not the only.
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

package SobelPackage is
		type sobel_type_t is array(natural range<>) of unsigned(natural range<>);
		type sobel_line_t is array(natural range<>) of sobel_type_t;
		type sobel_matrix_t is array(natural range<>) of sobel_line_t;
end package;

package body SobelPackage is
end package body;

library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

use work.SobelPackage.all;

entity SOBEL is
	generic(

		gBitWidth			 : integer;
		gOffset				 : integer;

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

		gNumOfChannels		 	 : integer
	);
	port(
		iInputVectorA		 : in sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
		iInputVectorB		 : in sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
		iInputVectorC		 : in sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);

		iInputVectorD		 : in sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
		iInputVectorM		 : in sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
		iInputVectorF		 : in sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);

		iInputVectorG		 : in sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
		iInputVectorH		 : in sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
		iInputVectorI		 : in sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);

		iClk 				 		 : in std_ulogic;
		iResetN				   : in std_ulogic;

		oOutputVector		 : out sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0)
	);
end entity;

architecture RTL of SOBEL is
	signal A		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
	signal B		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
	signal C		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);

	signal D		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
	signal M		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
	signal F		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);

	signal G		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
	signal H		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
	signal I		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);

	signal O		 			 					 : sobel_type_t(gNumOfChannels-1 downto 0)(gBitWidth-1 downto 0);
begin

	  A      <= iInputVectorA;
    B      <= iInputVectorB;
    C      <= iInputVectorC;

    D      <= iInputVectorD;
    M      <= iInputVectorM;
    F      <= iInputVectorF;

    G      <= iInputVectorG;
    H      <= iInputVectorH;
    I      <= iInputVectorI;

SOBEL_CHANNELS:
	for ii in 0 to gNumOfChannels-1 generate
		SOBEL_OP:
			entity work.SOBEL_BASE(RTL)
				generic map(
				      gBitWidth								=> 		gBitWidth						,
				      gOffset									=> 		gOffset							,

				      gWeightPerOperationA		=> 		gWeightPerOperationA,
				      gWeightPerOperationB		=> 		gWeightPerOperationB,
				      gWeightPerOperationC		=> 		gWeightPerOperationC,

				      gWeightPerOperationD		=> 		gWeightPerOperationD,
				      gWeightPerOperationM		=> 		gWeightPerOperationM,
				      gWeightPerOperationF		=> 		gWeightPerOperationF,

				      gWeightPerOperationG		=> 		gWeightPerOperationG,
				      gWeightPerOperationH		=> 		gWeightPerOperationH,
				      gWeightPerOperationI		=> 		gWeightPerOperationI
				)
				port map(
							iInputVectorA						=> A(ii),
							iInputVectorB						=> B(ii),
							iInputVectorC						=> C(ii),
							iInputVectorD						=> D(ii),
							iInputVectorM						=> M(ii),
							iInputVectorF						=> F(ii),
							iInputVectorG						=> G(ii),
							iInputVectorH						=> H(ii),
							iInputVectorI						=> I(ii),
							iClk 				 						=> iClk,
							iResetN				 					=> iResetN,
							oOutputVector						=> O(ii)

				);
	end generate;

	oOutputVector <= O;

end architecture;

-- @author Tobias Felix Egger
-- @date 2019.5.25
-- @revision 1
-- @file SOBEL_BASE-ea.vhd
-- @brief Configurable Operator(Sobel...)
-- @description
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

entity SOBEL_BASE is
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
		gWeightPerOperationi : integer
	);
	port(
		iInputVectorA		 : in unsigned(gBitWidth-1 downto 0);
		iInputVectorB		 : in unsigned(gBitWidth-1 downto 0);
		iInputVectorC		 : in unsigned(gBitWidth-1 downto 0);

		iInputVectorD		 : in unsigned(gBitWidth-1 downto 0);
		iInputVectorM		 : in unsigned(gBitWidth-1 downto 0);
		iInputVectorF		 : in unsigned(gBitWidth-1 downto 0);

		iInputVectorG		 : in unsigned(gBitWidth-1 downto 0);
		iInputVectorH		 : in unsigned(gBitWidth-1 downto 0);
		iInputVectorI		 : in unsigned(gBitWidth-1 downto 0);

		iClk 				 		 : in std_ulogic;
		iResetN				   : in std_ulogic;

		oOutputVector		 : out unsigned(gBitWidth-1 downto 0)
	);
end entity;

architecture RTL of SOBEL_BASE is
	constant cSobelResetConst
										 : unsigned(gBitWidth*2-1 downto 0) := (others=>'0');
	signal SOBEL_MUL_A_R         : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_B_R         : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_C_R         : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_D_R         : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_M_R         : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_F_R         : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_G_R         : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_H_R         : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_I_R         : unsigned(gBitWidth*2-1 downto 0);

	signal SOBEL_ADD_A_B_C_R     : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_ADD_D_M_F_R     : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_ADD_G_H_I_R     : unsigned(gBitWidth*2-1 downto 0);

	signal SOBEL_DT_R 		       : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_DTSUB_R				 : unsigned(gBitWidth*2-1 downto 0);

	signal SOBEL_MUL_A_NEXT      : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_B_NEXT      : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_C_NEXT      : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_D_NEXT      : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_M_NEXT      : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_F_NEXT      : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_G_NEXT      : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_H_NEXT      : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_MUL_I_NEXT      : unsigned(gBitWidth*2-1 downto 0);

	signal SOBEL_ADD_A_B_C_NEXT  : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_ADD_D_M_F_NEXT  : unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_ADD_G_H_I_NEXT  : unsigned(gBitWidth*2-1 downto 0);

	signal SOBEL_DT_NEXT 		 		: unsigned(gBitWidth*2-1 downto 0);
	signal SOBEL_DTSUB_NEXT		  : unsigned(gBitWidth*2-1 downto 0);

	signal A		 			 : unsigned(gBitWidth-1 downto 0);
	signal B		 			 : unsigned(gBitWidth-1 downto 0);
	signal C		 			 : unsigned(gBitWidth-1 downto 0);

	signal D		 			 : unsigned(gBitWidth-1 downto 0);
	signal M		 			 : unsigned(gBitWidth-1 downto 0);
	signal F		 			 : unsigned(gBitWidth-1 downto 0);

	signal G		 			 : unsigned(gBitWidth-1 downto 0);
	signal H		 			 : unsigned(gBitWidth-1 downto 0);
	signal I		 			 : unsigned(gBitWidth-1 downto 0);

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

REGISTERING: process(iClk, iResetN) is
	begin
		if(iResetN = '0') then
			SOBEL_MUL_A_R <= cSobelResetConst;
			SOBEL_MUL_B_R <= cSobelResetConst;
			SOBEL_MUL_C_R <= cSobelResetConst;
      SOBEL_MUL_D_R <= cSobelResetConst;
		  SOBEL_MUL_M_R <= cSobelResetConst;
		  SOBEL_MUL_F_R <= cSobelResetConst;
		  SOBEL_MUL_G_R <= cSobelResetConst;
		  SOBEL_MUL_H_R <= cSobelResetConst;
		  SOBEL_MUL_I_R <= cSobelResetConst;

			SOBEL_ADD_A_B_C_R  <= cSobelResetConst;
      SOBEL_ADD_D_M_F_R  <= cSobelResetConst;
      SOBEL_ADD_G_H_I_R  <= cSobelResetConst;

			SOBEL_DT_R 		<= cSobelResetConst;
			SOBEL_DTSUB_R		<= cSobelResetConst;
		elsif(rising_edge(iClk)) then
			SOBEL_MUL_A_R <= SOBEL_MUL_A_NEXT;
			SOBEL_MUL_B_R <= SOBEL_MUL_B_NEXT;
			SOBEL_MUL_C_R <= SOBEL_MUL_C_NEXT;
			SOBEL_MUL_D_R <= SOBEL_MUL_D_NEXT;
			SOBEL_MUL_M_R <= SOBEL_MUL_M_NEXT;
			SOBEL_MUL_F_R <= SOBEL_MUL_F_NEXT;
			SOBEL_MUL_G_R <= SOBEL_MUL_G_NEXT;
			SOBEL_MUL_H_R <= SOBEL_MUL_H_NEXT;
			SOBEL_MUL_I_R <= SOBEL_MUL_I_NEXT;

			SOBEL_ADD_A_B_C_R  <= SOBEL_ADD_A_B_C_NEXT;
			SOBEL_ADD_D_M_F_R  <= SOBEL_ADD_D_M_F_NEXT;
			SOBEL_ADD_G_H_I_R  <= SOBEL_ADD_G_H_I_NEXT;

			SOBEL_DT_R    <= SOBEL_DT_NEXT;
			SOBEL_DTSUB_R <= SOBEL_DTSUB_NEXT;
		end if;

	end process;

		SOBEL_OP:
			process (all) is
			begin
				SOBEL_MUL_A_NEXT <= A*to_unsigned(gWeightPerOperationA,gBitWidth);
				SOBEL_MUL_B_NEXT <= B*to_unsigned(gWeightPerOperationB,gBitWidth);
				SOBEL_MUL_C_NEXT <= C*to_unsigned(gWeightPerOperationC,gBitWidth);
				SOBEL_MUL_D_NEXT <= D*to_unsigned(gWeightPerOperationD,gBitWidth);
				SOBEL_MUL_M_NEXT <= M*to_unsigned(gWeightPerOperationM,gBitWidth);
				SOBEL_MUL_F_NEXT <= F*to_unsigned(gWeightPerOperationF,gBitWidth);
				SOBEL_MUL_G_NEXT <= G*to_unsigned(gWeightPerOperationG,gBitWidth);
				SOBEL_MUL_H_NEXT <= H*to_unsigned(gWeightPerOperationH,gBitWidth);
				SOBEL_MUL_I_NEXT <= I*to_unsigned(gWeightPerOperationI,gBitWidth);

				SOBEL_ADD_A_B_C_NEXT <= SOBEL_MUL_A_R +SOBEL_MUL_B_R+SOBEL_MUL_C_R;
				SOBEL_ADD_D_M_F_NEXT <= SOBEL_MUL_D_R +SOBEL_MUL_M_R+SOBEL_MUL_F_R;
				SOBEL_ADD_G_H_I_NEXT <= SOBEL_MUL_G_R +SOBEL_MUL_H_R+SOBEL_MUL_I_R;

				SOBEL_DT_NEXT		  <= SOBEL_ADD_A_B_C_R
				 									 + SOBEL_ADD_D_M_F_R
													 + SOBEL_ADD_G_H_I_R;
				SOBEL_DTSUB_NEXT 	<= SOBEL_DT_R
                           - to_unsigned(gOffset, gBitWidth);
			end process;

oOutputVector <= SOBEL_DTSUB_R(gBitWidth-1 downto 0);

end architecture;

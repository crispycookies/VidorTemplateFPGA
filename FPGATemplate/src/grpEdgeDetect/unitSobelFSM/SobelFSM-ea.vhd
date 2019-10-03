library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

use work.SobelPackage.all;

entity SobelFSM is
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

  		gNumOfChannels		 	 : integer;
      gMatrixDimensionsX   : integer;
      gMatrixDimensionsY   : integer;
      gResolutionPictureX  : integer;
      gResolutionPictureY  : integer
  );
  port(
      iCLK      : in std_ulogic;
      iRESETn   : in std_ulogic;

      iMatrix   : in sobel_matrix_t(gMatrixDimensionsX-1 downto 0)
                                (gMatrixDimensionsY-1 downto 0)
                                (gNumOfChannels-1 downto 0)
                                (gBitWidth-1 downto 0);
      oMatrix   : out sobel_matrix_t(gMatrixDimensionsX-3 downto 0)
                                (gMatrixDimensionsY-3 downto 0)
                                (gNumOfChannels-1 downto 0)
                                (gBitWidth-1 downto 0)
      oAddress  : out unsigned(gBitWidth-1 downto 0)
  );
end entity;


architecture RTL of SobelFSM is

  signal

begin

SOBEL_MATRIX : entity work.SOBEL_MATRIX(RTL)
  generic map(
    gBitWidth       => gBitWidth;
    gNumOfChannels  => gBitWidth;
    gOffset         => gBitWidth;

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
    gWeightPerOperationi => gWeightPerOperationi,

    gMatrixDimensionsX   => gMatrixDimensionsX,
    gMatrixDimensionsY   => gMatrixDimensionsY
  )
  port map(
    iClk         => iClk,
    iResetN      => iRESETn,

    iInputMatrix  => iMatrix,
    oOutputMatrix => oMatrix
  );

  ADDRCOUNTER: process (all) is
    begin

  end process;  //TOBEIMPLEMENTED


end architecture;

library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

use work.TemplatePackage.all;
use work.SobelPackage.all;

entity FPGATemplate is
	port(

      iCLK     : in  std_ulogic;
      iRESETn  : in  std_ulogic;
      iSAM_INT : in  std_ulogic;
      oSAM_INT : out std_ulogic;


		  oSDRAM_CLK  :	out         std_ulogic;
		  oSDRAM_ADDR :	out 		    unsigned(11 downto 0);
		  oSDRAM_BA   :	out 		    unsigned(1 downto 0);
		  oSDRAM_CASn :	out         std_ulogic;
		  oSDRAM_CKE  :	out         std_ulogic;
		  oSDRAM_CSn  :	out         std_ulogic;
		  bSDRAM_DQ   :	inout 	    unsigned(15 downto 0);
		  oSDRAM_DQM  :	out 		    unsigned(1 downto 0);
		  oSDRAM_RASn :	out         std_ulogic;
		  oSDRAM_WEn  :	out         std_ulogic;


		  bMKR_AREF   : inout       std_ulogic;
		  bMKR_A      : inout  		  unsigned(6 downto 0);
		  bMKR_D      : inout  		  unsigned(14 downto 0);


		  bPEX_RST    :	inout       std_ulogic;
		  bPEX_PIN6   :	inout       std_ulogic;
		  bPEX_PIN8   :	inout       std_ulogic;
		  bPEX_PIN10  :	inout       std_ulogic;
		  iPEX_PIN11  :	in          std_ulogic;
		  bPEX_PIN12  :	inout       std_ulogic;
		  iPEX_PIN13  :	in          std_ulogic;
		  bPEX_PIN14  :	inout       std_ulogic;
		  bPEX_PIN16  :	inout       std_ulogic;
		  bPEX_PIN20  :	inout       std_ulogic;
		  iPEX_PIN23  :	in         	std_ulogic;
		  iPEX_PIN25  :	in         	std_ulogic;
		  bPEX_PIN28  :	inout       std_ulogic;
		  bPEX_PIN30  :	inout       std_ulogic;
		  iPEX_PIN31  :	in         	std_ulogic;
		  bPEX_PIN32  :	inout       std_ulogic;
		  iPEX_PIN33  :	in         	std_ulogic;
		  bPEX_PIN42  :	inout       std_ulogic;
		  bPEX_PIN44  :	inout       std_ulogic;
		  bPEX_PIN45  :	inout       std_ulogic;
		  bPEX_PIN46  :	inout       std_ulogic;
		  bPEX_PIN47  :	inout       std_ulogic;
		  bPEX_PIN48  :	inout       std_ulogic;
		  bPEX_PIN49  :	inout       std_ulogic;
		  bPEX_PIN51  :	inout       std_ulogic;

      bWM_PIO1    : 	inout			std_ulogic;
      bWM_PIO2    : 	inout			std_ulogic;
      bWM_PIO3    : 	inout			std_ulogic;
      bWM_PIO4    : 	inout			std_ulogic;
      bWM_PIO5    : 	inout			std_ulogic;
      bWM_PIO7    : 	inout			std_ulogic;
      bWM_PIO8    : 	inout			std_ulogic;
      bWM_PIO18   : 	inout			std_ulogic;
      bWM_PIO20   : 	inout			std_ulogic;
      bWM_PIO21   : 	inout			std_ulogic;
      bWM_PIO27   : 	inout			std_ulogic;
      bWM_PIO28   : 	inout			std_ulogic;
      bWM_PIO29   : 	inout			std_ulogic;
      bWM_PIO31   : 	inout			std_ulogic;
      iWM_PIO32   : 	in				std_ulogic;
      bWM_PIO34   : 	inout			std_ulogic;
      bWM_PIO35   : 	inout			std_ulogic;
      bWM_PIO36   : 	inout			std_ulogic;
      iWM_TX      : 	in				std_ulogic;
      oWM_RX      : 	inout			std_ulogic;
      oWM_RESET   : 	inout			std_ulogic;

		  oHDMI_TX 	  : 	out	   	  unsigned(2 downto 0);
		  oHDMI_CLK	  : 	out	      std_ulogic;

		  bHDMI_SDA   :   inout			std_ulogic;
		  bHDMI_SCL   :   inout			std_ulogic;
		  iHDMI_HPD   :   in   			std_ulogic;

		  iMIPI_D  	  :	  in  			unsigned(1 downto 0);
		  iMIPI_CLK	  :	  in        std_ulogic;
		  bMIPI_SDA	  :	  inout     std_ulogic;
		  bMIPI_SCL	  :	  inout     std_ulogic;
		  bMIPI_GP 	  :	  inout  		unsigned(1 downto 0);

      oFLASH_SCK  :	  out			  std_ulogic;
      oFLASH_CS   :	  out			  std_ulogic;
      oFLASH_MOSI :	  inout 		std_ulogic;
      iFLASH_MISO :	  inout 		std_ulogic;
      oFLASH_HOLD :	  inout 		std_ulogic;
      oFLASH_WP   :	  inout 		std_ulogic
	);
end entity;

architecture RTL of FPGATemplate is
	signal iInputVectorA		: sobel_type_t(0 downto 0)(7  downto 0);
	signal iInputVectorB		: sobel_type_t(0 downto 0)(7  downto 0);
	signal iInputVectorC		: sobel_type_t(0 downto 0)(7  downto 0);
	signal iInputVectorD		: sobel_type_t(0 downto 0)(7  downto 0);
	signal iInputVectorM		: sobel_type_t(0 downto 0)(7  downto 0);
	signal iInputVectorF		: sobel_type_t(0 downto 0)(7  downto 0);
	signal iInputVectorG		: sobel_type_t(0 downto 0)(7  downto 0);
	signal iInputVectorH		: sobel_type_t(0 downto 0)(7  downto 0);
	signal iInputVectorI		: sobel_type_t(0 downto 0)(7  downto 0);
	signal oOutputVector		: sobel_type_t(0 downto 0)(7  downto 0);
begin

		iInputVectorA(0)	<= bSDRAM_DQ(7 downto 0);
		iInputVectorB(0)	<= bSDRAM_DQ(15 downto 8);
		iInputVectorC(0)	<= bMKR_D(7 downto 0);

		iInputVectorD(0)(0) <= bWM_PIO1;
		iInputVectorD(0)(1) <= bWM_PIO2;
		iInputVectorD(0)(2) <= bWM_PIO3;
		iInputVectorD(0)(3) <= bWM_PIO4;
		iInputVectorD(0)(4) <= bWM_PIO5;
		iInputVectorD(0)(5) <= bWM_PIO7;
		iInputVectorD(0)(6) <= bWM_PIO8;
		iInputVectorD(0)(7) <= bWM_PIO18;

		iInputVectorM(0)(0) <= bWM_PIO20;
		iInputVectorM(0)(1) <= bWM_PIO21;
		iInputVectorM(0)(2) <= bWM_PIO27;
		iInputVectorM(0)(3) <= bWM_PIO28;
		iInputVectorM(0)(4) <= bWM_PIO29;
		iInputVectorM(0)(5) <= bWM_PIO31;
		iInputVectorM(0)(6) <= bWM_PIO34;
		iInputVectorM(0)(7) <= bWM_PIO35;

		iInputVectorM(0)(0) <= bPEX_PIN42;
		iInputVectorM(0)(1) <= bPEX_PIN44;
		iInputVectorM(0)(2) <= bPEX_PIN45;
		iInputVectorM(0)(3) <= bPEX_PIN46;
		iInputVectorM(0)(4) <= bPEX_PIN47;
		iInputVectorM(0)(5) <= bPEX_PIN48;
		iInputVectorM(0)(6) <= bPEX_PIN49;
		iInputVectorM(0)(7) <= bPEX_PIN51;

		iInputVectorF(0)(0) <= bPEX_RST;
		iInputVectorF(0)(1) <= bPEX_PIN6;
		iInputVectorF(0)(2) <= bPEX_PIN8;
		iInputVectorF(0)(3) <= bPEX_PIN10;
		iInputVectorF(0)(4) <= iPEX_PIN11;
	  iInputVectorF(0)(5) <= bPEX_PIN12;
	  iInputVectorF(0)(6) <= iPEX_PIN13;
	  iInputVectorF(0)(7) <= bPEX_PIN14;

		iInputVectorG(0)(0) <= bPEX_PIN16;
		iInputVectorG(0)(1) <= bPEX_PIN20;
		iInputVectorG(0)(2) <= iPEX_PIN23;
		iInputVectorG(0)(3) <= iPEX_PIN25;
		iInputVectorG(0)(4) <= bPEX_PIN28;
		iInputVectorG(0)(5) <= bPEX_PIN30;
		iInputVectorG(0)(6) <= iPEX_PIN31;
		iInputVectorG(0)(7) <= bPEX_PIN32;

		iInputVectorH(0)(0) <= iPEX_PIN33;
		iInputVectorH(0)(1) <= bPEX_PIN42;
		iInputVectorH(0)(2) <= bPEX_PIN44;
		iInputVectorH(0)(3) <= bPEX_PIN45;
		iInputVectorH(0)(4) <= bPEX_PIN46;
		iInputVectorH(0)(5) <= bPEX_PIN47;
		iInputVectorH(0)(6) <= bPEX_PIN48;
		iInputVectorH(0)(7) <= bPEX_PIN49;

		iInputVectorI(0)(0) <= bWM_PIO36;
		iInputVectorI(0)(1) <= iWM_TX;
		iInputVectorI(0)(2) <= oWM_RX;
		iInputVectorI(0)(3) <= oWM_RESET;
		iInputVectorI(0)(4) <= iMIPI_D(0);
		iInputVectorI(0)(5) <= iMIPI_CLK;
		iInputVectorI(0)(6) <= bMIPI_SDA;
		iInputVectorI(0)(7) <= bMIPI_SCL;

		oSDRAM_ADDR(7 downto 0) <= oOutputVector(0);

	SOBEL_OP:
		entity work.SOBEL(RTL)
			generic map(
						gBitWidth								=> 		8	 ,
						gOffset									=> 		125,

						gWeightPerOperationA		=> 		1,
						gWeightPerOperationB		=> 		2,
						gWeightPerOperationC		=> 		1,

						gWeightPerOperationD		=> 		0,
						gWeightPerOperationM		=> 		0,
						gWeightPerOperationF		=> 		0,

						gWeightPerOperationG		=> 	 -1,
						gWeightPerOperationH		=> 	 -2,
						gWeightPerOperationI		=>	 -1,

						gNumOfChannels				  => 		1
			)
			port map(
						iInputVectorA						=> iInputVectorA,
						iInputVectorB						=> iInputVectorB,
						iInputVectorC						=> iInputVectorC,
						iInputVectorD						=> iInputVectorD,
						iInputVectorM						=> iInputVectorM,
						iInputVectorF						=> iInputVectorF,
						iInputVectorG						=> iInputVectorG,
						iInputVectorH						=> iInputVectorH,
						iInputVectorI						=> iInputVectorI,
						iClk 				 						=> iClk,
						iResetN				 					=> iResetN,
						oOutputVector						=> oOutputVector
			);


end architecture;

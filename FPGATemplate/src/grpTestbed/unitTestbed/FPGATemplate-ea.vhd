library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

use work.TemplatePackage.all;

entity FPGATemplate is
	port(
			iCLK					: in std_ulogic;
			iRESETn				: in std_ulogic;
			oSDRAM_ADDR			: out unsigned(11 downto 0);
			oSDRAM_BA			: out unsigned(1 downto 0);
			oSDRAM_CASn			: out std_ulogic;
			oSDRAM_CKE 			: out std_ulogic;
			oSDRAM_CSn 			: out std_ulogic;
			bSDRAM_DQ			: inout unsigned(15 downto 0);
			oSDRAM_DQM			: out unsigned(1 downto 0);
			oSDRAM_RASn			: out std_ulogic;
			oSDRAM_CLK 			: out std_ulogic;
			oSDRAM_WEn 			: out std_ulogic;
			bMKR_AREF  			: inout std_ulogic;
			bMKR_A				: inout unsigned(14 downto 0);
			bPEX_PIN6 			: inout std_ulogic;
			bPEX_PIN8 			: inout std_ulogic;
			bPEX_PIN10			: inout std_ulogic;
			iPEX_PIN11			: in std_ulogic;
			bPEX_PIN12			: inout std_ulogic;
			iPEX_PIN13			: in std_ulogic;
			bPEX_PIN14			: inout std_ulogic;
			bPEX_PIN16			: inout std_ulogic;
			bPEX_PIN20			: inout std_ulogic;
			iPEX_PIN23			: in std_ulogic;
			iPEX_PIN25			: in std_ulogic;
			bPEX_PIN28			: inout std_ulogic;
			bPEX_PIN30			: inout std_ulogic;
			iPEX_PIN31			: in std_ulogic;
			bPEX_PIN32			: inout std_ulogic;
			iPEX_PIN33			: in std_ulogic;
			bPEX_PIN42			: inout std_ulogic;
			bPEX_PIN44			: inout std_ulogic;
			bPEX_PIN45			: inout std_ulogic;
			bPEX_PIN46			: inout std_ulogic;
			bPEX_PIN47			: inout std_ulogic;
			bPEX_PIN48			: inout std_ulogic;
			bPEX_PIN49			: inout std_ulogic;
			bPEX_PIN51			: inout std_ulogic;
			bPEX_RST				: inout std_ulogic;
			iWM_PIO32			: in std_ulogic;
			bWM_PIO1 			: inout std_ulogic;
			bWM_PIO2 			: inout std_ulogic;
			bWM_PIO3 			: inout std_ulogic;
			bWM_PIO4 			: inout std_ulogic;
			bWM_PIO5 			: inout std_ulogic;
			bWM_PIO7 			: inout std_ulogic;
			bWM_PIO8 			: inout std_ulogic;
			bWM_PIO16			: inout std_ulogic;
			bWM_PIO17			: inout std_ulogic;
			bWM_PIO18			: inout std_ulogic;
			bWM_PIO21			: inout std_ulogic;
			bWM_PIO20			: inout std_ulogic;
			bWM_PIO24			: inout std_ulogic;
			bWM_PIO25			: inout std_ulogic;
			bWM_PIO27			: inout std_ulogic;
			bWM_PIO28			: inout std_ulogic;
			bWM_PIO29			: inout std_ulogic;
			bWM_PIO31			: inout std_ulogic;
			bWM_PIO34			: inout std_ulogic;
			bWM_PIO35			: inout std_ulogic;
			bWM_PIO36			: inout std_ulogic;
			iWM_TX   			: in std_ulogic; 
			oWM_RX   			: out std_ulogic;
			iWM_RTS  			: in std_ulogic;
			iWM_CTS  			: in std_ulogic;
			oWM_RESET			: out std_ulogic;
			oHDMI_TX				: out unsigned(2 downto 0);
			oHDMI_CLK  			: out std_ulogic;
			bHDMI_SCL  			: inout std_ulogic;
			bHDMI_SDA  			: inout std_ulogic;
			iHDMI_HPD  			: in std_ulogic;
			iMIPI_D				: in unsigned(1 downto 0);
			iMIPI_CLK  			: in std_ulogic;
			bMIPI_SDA  			: inout std_ulogic;
			bMIPI_SCL  			: inout std_ulogic;
			bMIPI_GP				: inout unsigned(1 downto 0);
			oFLASH_MOSI			: out std_ulogic;
			iFLASH_MISO			: in std_ulogic;
			oFLASH_SCK 			: out std_ulogic;
			oFLASH_CS  			: out std_ulogic;
			oFLASH_HOLD			: out std_ulogic;
			oFLASH_WP  			: out std_ulogic;
			oSAM_INT   			: out std_ulogic;
			iSAM_INT   			: in std_ulogic
	);
end entity;

architecture RTL of FPGATemplate is
begin
	-- TODO Remove
	-- Only Necessary to have at least some logic in Design
	bWM_PIO17 <= iClk;

end architecture;
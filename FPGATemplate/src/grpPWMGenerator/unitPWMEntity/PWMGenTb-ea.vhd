library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;

entity TestbenchPWM is
end entity;

architecture RTL of TestbenchPWM is
    constant iARR : unsigned(11 downto 0) := to_unsigned(50,12);
    constant iPRR : unsigned(11 downto 0) := to_unsigned(20,12);
    constant iResetN : std_ulogic := '0';
    signal iClk : std_ulogic := '0';
    signal oPulseBasic : std_ulogic;
    signal oPulseAdvanced : std_ulogic;
begin

    iClk <= not iClk after 10 ns;


    PWMBasic: entity work.PWMGen(Basic)
        generic map(
            gRegisterBitWidth => 12
        )
        port map(
            iClk => iClk,
            iResetN => not iResetN,
            iARR => iARR,
            iPRR => iPRR,
            oPulse => oPulseBasic
        );

     PWMAdvanced: entity work.PWMGen(Advanced)
        generic map(
            gRegisterBitWidth => 12
        )
        port map(
            iClk => iClk,
            iResetN => not iResetN,
            iARR => iARR,
            iPRR => iPRR,
            oPulse => oPulseAdvanced
        );
end architecture;

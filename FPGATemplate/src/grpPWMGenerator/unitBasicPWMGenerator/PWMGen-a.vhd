

architecture BASIC of PWMGen is
	signal CurrentCountRegisterR, CurrentCountRegisterRNext : unsigned(gRegisterBitWidth-1 downto 0);
begin

REGISTERING: process(iClk, iResetN) is
begin
	if(iResetN = '0') then
		CurrentCountRegisterR  <= (others=>'0');
	elsif(rising_edge(iClk)) then
		CurrentCountRegisterR <= CurrentCountRegisterRNext;
	end if;
end process;


COMB: process(iARR, iPRR, CurrentCountRegisterR, iClk) is
begin
        -- Power On Reset
        -- Filter MetaValue
        
   
    CurrentCountRegisterRNext <= CurrentCountRegisterR;
		
        if(CurrentCountRegisterR(0) = 'X' or CurrentCountRegisterR(0) = 'U') then
            CurrentCountRegisterRNext <= (others=>'0');
			oPulse <= '0';
		elsif(CurrentCountRegisterR >= iARR) then
			CurrentCountRegisterRNext <= (others=>'0');
			oPulse <= '0';
		elsif(CurrentCountRegisterR >= iPRR) then
			CurrentCountRegisterRNext <= CurrentCountRegisterR +1 ;
			oPulse <= '0';
		else 
			CurrentCountRegisterRNext <= CurrentCountRegisterR +1 ;
            oPulse <= '1';
		end if;
   
end process;
end architecture;

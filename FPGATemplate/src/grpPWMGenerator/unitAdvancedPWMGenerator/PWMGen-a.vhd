

architecture ADVANCED of PWMGen is
	signal CurrentCountRegisterR, CurrentCountRegisterRNext : unsigned(gRegisterBitWidth-1 downto 0);
	signal SyncedARRR, SyncedARRRNext : unsigned(gRegisterBitWidth-1 downto 0);
	signal SyncedPRRR, SyncedPRRRNext : unsigned(gRegisterBitWidth-1 downto 0);
begin

REGISTERING: process(iClk, iResetN) is
begin
	if(iResetN = '0') then
		CurrentCountRegisterR  <= (others=>'0');
		SyncedARRR <= (others=>'0');
		SyncedPRRR <= (others=>'0');
	elsif(rising_edge(iClk)) then
		CurrentCountRegisterR <= CurrentCountRegisterRNext;
		SyncedARRR <= SyncedARRRNext;
		SyncedPRRR <= SyncedPRRRNext;
	end if;
end process;


COMB: process(SyncedARRR, SyncedPRRR, CurrentCountRegisterR,iARR,iPRR) is
begin
	SyncedARRRNext<=iARR;
	SyncedPRRRNext<=iPRR;

	CurrentCountRegisterRNext <= (others=>'0');
	
	if((SyncedARRR /= iARR) or (SyncedPRRR /= iPRR)) then
		CurrentCountRegisterRNext <= (others=>'0');
		oPulse <= '0';
	else
		if(CurrentCountRegisterR >= SyncedARRR) then
			CurrentCountRegisterRNext <= (others=>'0');
			oPulse <= '0';
		elsif(CurrentCountRegisterR >= SyncedPRRR) then
			CurrentCountRegisterRNext <= CurrentCountRegisterR +1 ;
			oPulse <= '0';
		else 
			CurrentCountRegisterRNext <= CurrentCountRegisterR +1 ;
			oPulse <= '1';
		end if;
	end if;
end process;
end architecture;

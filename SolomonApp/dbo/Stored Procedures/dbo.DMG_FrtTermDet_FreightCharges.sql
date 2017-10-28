 create procedure DMG_FrtTermDet_FreightCharges
	@FrtTermsID		varchar(10),
	@OrderVal		decimal(25,9),
	@FreightPct		decimal(25,9) OUTPUT,
	@HandlingChg		decimal(25,9) OUTPUT,
	@HandlingChgLine	decimal(25,9) OUTPUT,
	@InvcAmtPct		decimal(25,9) OUTPUT
as
	select top 1
		@FreightPct = FreightPct,
		@HandlingChg = HandlingChg,
		@HandlingChgLine = HandlingChgLine,
		@InvcAmtPct = InvcAmtPct
	from	FrtTermDet
	where	FrtTermsID = @FrtTermsID
	and	MinOrderVal <= @OrderVal
	order by
		MinOrderVal desc

	if @@ROWCOUNT = 0 begin
		set @FreightPct = 0
		set @HandlingChg = 0
		set @HandlingChgLine = 0
		set @InvcAmtPct = 0
		return 0	--Failure
	end
	else
		--select @FreightPct, @HandlingChg, @HandlingChgLine, @InvcAmtPct
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_FrtTermDet_FreightCharges] TO [MSDSL]
    AS [dbo];


 create proc DMG_CreditInfo_OrdShipBal
	@CpnyID		varchar(10),
	@CustID		varchar(15),
	@ExclOrdNbr	varchar(15),
	@ExclShipperID	varchar(15),
	@OpenBal	decimal(25,9) OUTPUT
as
	declare @DecPl			smallint
	declare	@TotShip		decimal(25,9)
	declare	@UnshippedBalance	decimal(25,9)

	set 	@TotShip = 0
	set	@UnshippedBalance = 0

	--Get the base currency precision
	exec DMG_GetBaseCurrencyPrecision @CpnyID, @DecPl OUTPUT

	-- Get the open sales order total.
--	select	@UnshippedBalance = sum(h.UnshippedBalance)
--	from	SOHeader  h
--	join	Terms	  t
--	  on	t.TermsID = h.TermsID

--	where	h.CustID = @CustID
--	  and	h.Status = 'O'
--	  and	h.OrdNbr <> @ExclOrdNbr
-- --	  and	h.CpnyID = @CpnyID
--	  and	t.CreditChk = 1

	-- Get the open shipper total.
--	select	@TotShip = sum(sh.TotInvc)
	select	@TotShip = sum(sh.BalDue)
	from	SOShipHeader sh (NOLOCK)

	join	Terms t (NOLOCK)
	  on	t.TermsID = sh.TermsID

	join	SOType y (NOLOCK)
	  on	y.CpnyID = @CpnyID
	  and	y.SOTypeID = sh.SOTypeID

	where	sh.CustID = @CustID
	  and	sh.ShipRegisterID = ''
	  and	sh.Cancelled = 0
	  and	sh.ShipperID <> @ExclShipperID
--	  and	sh.CpnyID = @CpnyID
	  and	t.CreditChk = 1
	  and	y.Behavior in ('CM', 'CS', 'DM', 'INVC', 'RMSH', 'SO', 'WC')

	-- Return open sales order total + the open shipper total.
	set @OpenBal = round(coalesce(@UnshippedBalance, 0) + coalesce(@TotShip, 0), @DecPl)
	--select @OpenBal



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditInfo_OrdShipBal] TO [MSDSL]
    AS [dbo];


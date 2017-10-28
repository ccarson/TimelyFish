 create proc ADG_CreditInfo_OrdShipBal
	@CpnyID		varchar(10),
	@CustID		varchar(15),
	@ExclOrdNbr	varchar(15),
	@ExclShipperID	varchar(15)
as
	declare	@TotShip		float
	declare	@UnshippedBalance	float

	select 	@TotShip = 0
	select	@UnshippedBalance = 0

	-- Get the open sales order total.
	select	@UnshippedBalance = sum(h.UnshippedBalance)
	from	SOHeader  h
	join	Terms	  t
	  on	t.TermsID = h.TermsID

	join	SOType y (nolock)
	  on	y.CpnyID = h.CpnyID
	and	y.SOTypeID = h.SOTypeID

	where	h.CustID = @CustID
	  and	h.Status = 'O'
	  and	h.OrdNbr <> @ExclOrdNbr
-- --	  and	h.CpnyID = @CpnyID
	  and	t.CreditChk = 1
          and	y.Behavior in ('CM', 'CS', 'DM', 'INVC', 'MO', 'RMA', 'RMSH', 'SO', 'WC')

	-- Get the open shipper total.
--	select	@TotShip = sum(sh.TotInvc)
	select	@TotShip = sum(sh.BalDue)
	from	SOShipHeader sh (nolock)

	join	Terms t (nolock)
	on	t.TermsID = sh.TermsID

	join	SOType y (nolock)
	on	y.CpnyID = sh.CpnyID
	and	y.SOTypeID = sh.SOTypeID

	where	sh.CustID = @CustID
	and	sh.ShipRegisterID = ''
	and	sh.Cancelled = 0
	and	sh.ShipperID <> @ExclShipperID
--	and	sh.CpnyID = @CpnyID
	and	t.CreditChk = 1
	and	y.Behavior in ('CM', 'CS', 'DM', 'INVC', 'MO', 'RMA', 'RMSH', 'SO', 'WC')

	-- Return open sales order total + the open shipper total.
	select	coalesce(@UnshippedBalance, 0) + coalesce(@TotShip, 0)



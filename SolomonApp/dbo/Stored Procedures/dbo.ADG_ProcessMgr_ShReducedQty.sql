 create proc ADG_ProcessMgr_ShReducedQty
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5),
	@ProgID CHAR(8),
	@UserID Char(10)
as
	set nocount on

	-- Make sure that no records are in SOShipReducedQty
	delete from SOShipReducedQty

	-- Insert into SOShipReducedQty with the line and plan
	-- quantities and request dates for each specified line on
	-- the shipper.
	-- Cancelled shippers and lines with an item or site change
	-- are treated as if the open line quantity had dropped to zero.
	insert into SOShipReducedQty (InvtID, SiteID, LineQty, PlanQty, Crtd_DateTime, Crtd_Prog,
		Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User)

	select	p.InvtID,
		p.SiteID,
		'LineQty' = case h.Cancelled
				when 1 then
					0
				else
					case
						when ((p.InvtID <> l.InvtID) or (p.SiteID <> h.SiteID)) then
							0
						else
							(l.QtyPick - l.QtyShip)
					end
				end,
		'PlanQty' = -p.Qty,
		getdate(), @ProgID, @UserID, GetDate(), @ProgId, @UserID

	from	SOPlan p

	join	SOShipHeader h
	on	h.CpnyID = p.CpnyID
	and	h.ShipperID = p.SOShipperID

	join	SOShipLine	l
	on	l.CpnyID = p.CpnyID
	and	l.ShipperID = p.SOShipperID
	and	l.LineRef = p.SOShipperLineRef

	where	p.CpnyID = @CpnyID
	and	p.SOShipperID = @ShipperID
	and	p.SOShipperLineRef like @LineRef

	set nocount off

	-- Select from the temporary table the item/site combinations
	-- with a reduced quantity.
	select		InvtID,
			SiteID

	from		SOShipReducedQty
	where		LineQty < PlanQty
	group by	InvtID,
			SiteID

	-- Make sure that no records are in SOShipReducedQty
	delete from SOShipReducedQty



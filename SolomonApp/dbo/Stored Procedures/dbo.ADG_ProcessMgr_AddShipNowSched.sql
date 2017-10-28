 create proc ADG_ProcessMgr_AddShipNowSched
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),	-- can be wildcard
	@SchedRef	varchar(5)	-- can be wildcard
as
	declare	@CancelDate	smalldatetime

	select	@CancelDate = getdate()

	select	SOSched.CpnyID,
		SOSched.OrdNbr,
		SOSched.LineRef,
		SOSched.SchedRef

	from	SOSched

	join	SOHeader
	on	SOHeader.CpnyID = SOSched.CpnyID
	and	SOHeader.OrdNbr = SOSched.OrdNbr

	join	SOType
	on	SOType.CpnyID = SOSched.CpnyID
	and	SOType.SOTypeID = SOHeader.SOTypeID

	join	Site
	on	Site.SiteID = SOSched.SiteID

	where	SOSched.CpnyID = @CpnyID
	and	SOSched.OrdNbr = @OrdNbr
	and	SOSched.LineRef + '' like @LineRef
	and	SOSched.SchedRef + '' like @SchedRef
	and	SOSched.Status = 'O'
	and	SOSched.CancelDate > @CancelDate
	and	SOSched.QtyOrd > 0
	and	SOSched.AutoPO = 0	-- Don't select any Bound SO/POs. These must always wait for the PO to be received.
	and	Site.S4Future09 = 1	-- S4Future09 = Ship Regardless of Availability
	and	SOType.Behavior in ('SO', 'CS', 'MO', 'INVC', 'RMA', 'RMSH', 'SERV', 'TR', 'WC', 'WO')



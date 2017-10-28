 create proc ADG_Plan_QSOAlloc
	@InvtID		varchar(30),
	@SiteID		varchar(10),
	@QtyPrec	smallint
as
	select	isnull(sum(round(case
				when SOLine.UnitMultDiv = 'M' then (SOSched.QtyOrd -  SOSched.QtyShip) * SOLine.CnvFact
				when SOLine.CnvFact <> 0 then (SOSched.QtyOrd -  SOSched.QtyShip) / SOLine.CnvFact
				else 0 end, @QtyPrec)), 0) QtyAllocSO

	from	SOSched (NOLOCK)

	join	SOLine (NOLOCK)	-- Use NOLOCK to eliminate a deadlock problem
	on	SOLine.CpnyID = SOSched.CpnyID
	and	SOLine.OrdNbr = SOSched.OrdNbr
	and SOLine.LineRef = SOSched.LineRef

	join	SOHeader (NOLOCK)	-- Use NOLOCK to eliminate a deadlock problem
	on	SOHeader.CpnyID = SOSched.CpnyID
	and	SOHeader.OrdNbr = SOSched.OrdNbr

	join	SOType (NOLOCK)
	on	SOType.CpnyID = SOHeader.CpnyID
	and	SOType.SOTypeID = SOHeader.SOTypeID

	where	SOLine.InvtID = @InvtID
	and	SOSched.SiteID = @SiteID
	and	SOSched.Status = 'O'
	and	abs(SOSched.QtyOrd - SOSched.QtyShip) >= 0.000000005
	and	SOSched.DropShip = 0
	and SOSched.LotSerialEntered = 1
	and	SOType.Behavior in ('SO', 'INVC', 'WC')



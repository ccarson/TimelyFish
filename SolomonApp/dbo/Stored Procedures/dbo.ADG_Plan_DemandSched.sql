 create proc ADG_Plan_DemandSched
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
as
	select	SOSched.AutoPO,
		SOSched.CancelDate,
		SOSched.DropShip,
		SOSched.LotSerialEntered,
		SOSched.PriorityDate,
		SOSched.PrioritySeq,
		SOSched.PriorityTime,
		SOSched.PromDate,
		SOSched.QtyOrd,
		SOSched.QtyShip,
		SOSched.ReqDate,
		SOSched.ReqPickDate,
		SOSched.ShipViaID,
		SOSched.SiteID,
		SOSched.Status,
		SOSched.TransitTime,
		SOSched.WeekendDelivery,

		SOHeader.BuildAssyTime,
		SOHeader.BuildAvailDate,
		SOHeader.Priority,
		SOHeader.ShipCmplt,

		SOLine.CnvFact,
		SOLine.InvtID,
		SOLine.UnitMultDiv,

		SOType.Behavior

	from	SOHeader

	join	SOSched
	on	SOSched.CpnyID = SOHeader.CpnyID
	and	SOSched.OrdNbr = SOHeader.OrdNbr

	join	SOLine
	on	SOLine.CpnyID = SOHeader.CpnyID
	and	SOLine.OrdNbr = SOHeader.OrdNbr
	and	SOLine.LineRef = SOSched.LineRef

	join	SOType
	on	SOType.CpnyID = SOHeader.CpnyID
	and	SOType.SOTypeID = SOHeader.SOTypeID

	where	SOHeader.CpnyID = @CpnyID
	and	SOHeader.OrdNbr = @OrdNbr
	and	SOSched.LineRef = @LineRef
	and	SOSched.SchedRef = @SchedRef

	option (force order)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_DemandSched] TO [MSDSL]
    AS [dbo];


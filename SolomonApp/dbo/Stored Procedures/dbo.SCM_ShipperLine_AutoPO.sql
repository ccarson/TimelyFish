 create proc SCM_ShipperLine_AutoPO
	@CpnyID			varchar(10),
	@ShipperID		varchar(30),
	@ShipperLineRef 	varchar(10)
as
	select	top 1 os.AutoPO

	from	SOSched os

	  join	SOShipSched ss
	  on	ss.CpnyID = os.CpnyID
	  and	ss.OrdNbr = os.OrdNbr
	  and	ss.OrdLineRef = os.LineRef
	  and	ss.OrdSchedRef = os.SchedRef

	where	ss.CpnyID = @CpnyID
	  and	ss.ShipperID = @ShipperID
	  and	ss.ShipperLineRef = @ShipperLineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_ShipperLine_AutoPO] TO [MSDSL]
    AS [dbo];


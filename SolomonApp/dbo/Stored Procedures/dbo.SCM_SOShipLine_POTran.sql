 create proc SCM_SOShipLine_POTran
	@CpnyID		varchar( 10 ),
	@ShipperID	varchar( 15 ),
	@LineRef	varchar( 15 )
	AS

	SELECT		DISTINCT POTran.*
	FROM 		SOShipSched
			INNER JOIN SOSched
			ON SOShipsched.CpnyID = SOSched.CpnyID
			AND SOShipsched.OrdNbr = SOSched.OrdNbr
			AND SOShipSched.OrdLineRef = SOSched.LineRef
			AND SOShipSched.OrdSchedref = SOSched.SchedRef
			INNER JOIN POAlloc
			ON SOSched.CpnyID = POAlloc.CpnyID
			AND SOSched.OrdNbr = POAlloc.SOOrdNbr
			AND SOShipSched.OrdLineRef = POAlloc.SOLineRef
			AND SOSched.SchedRef = POAlloc.SOSchedRef
			INNER JOIN POTran
			ON POAlloc.CpnyID = POTran.CpnyID
			AND POAlloc.PONbr = POTran.PONbr
			AND POAlloc.POLineRef = POTran.POLineRef
		WHERE 		SOShipSched.CpnyID = @CpnyID
			AND SOShipSched.ShipperID = @ShipperID
			AND SOShipSched.ShipperLineRef Like @LineRef



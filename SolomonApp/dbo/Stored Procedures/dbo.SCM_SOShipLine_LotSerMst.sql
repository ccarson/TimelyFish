 create proc SCM_SOShipLine_LotSerMst
	@CpnyID		varchar( 10 ),
	@ShipperID	varchar( 15 ),
	@LineRef	varchar( 15 )
	AS

	SELECT		DISTINCT LotSerMst.*
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
			INNER JOIN LotSerT
			ON POTran.CpnyId = LotSerT.CpnyID
			AND POTran.BatNbr = LotSerT.BatNbr
			AND POTran.RcptNbr = LotSerT.RefNbr
			AND POTran.Lineref = LotSert.InTRANLineRef
			INNER JOIN LotSerMst
			ON LotSerT.InvtID = LotSerMst.InvtID
			AND LotSerT.SiteID = LotSerMst.SiteID
			AND LotSerT.WhseLoc = LotSerMst.WhseLoc
			AND LotSerT.LotSerNbr = LotSerMst.LotSerNbr
		WHERE 		SOShipSched.CpnyID = @CpnyID
			AND SOShipSched.ShipperID = @ShipperID
			AND SOShipSched.ShipperLineRef Like @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_SOShipLine_LotSerMst] TO [MSDSL]
    AS [dbo];


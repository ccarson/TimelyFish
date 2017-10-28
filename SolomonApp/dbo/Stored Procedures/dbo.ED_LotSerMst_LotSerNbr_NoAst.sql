 CREATE PROCEDURE ED_LotSerMst_LotSerNbr_NoAst
	@InvtID		varchar (30),
	@SiteID 	varchar (10),
	@CpnyID		varchar (10),
	@ShipperID 	varchar (15),
	@LineRef	varchar (5),
	@LotSerNbr	varchar (25)
AS
	SELECT 	LotSerMst.LotSerNbr, LotSerMst.WhseLoc, LotSerMst.QtyOnHand
	FROM 	LotSerMst INNER JOIN SOShipLot ON SOShipLot.LotSerNbr = LotSerMst.LotSerNbr
	WHERE 	LotSerMst.InvtID = @InvtID AND
	 	LotSerMst.SiteID = @SiteID AND
		SOShipLot.CpnyID = @CpnyID AND
		SOShipLot.ShipperID = @ShipperID AND
		SOShipLot.LineRef = @LineRef AND
	 	LotSerMst.LotSerNbr like @LotSerNbr AND
		LotSerMst.LotSerNbr <> '*' AND
		(LotSerMst.QtyOnHand - LotSerMst.QtyShipNotInv - LotSerMst.QtyAlloc) >= 0
	ORDER BY LotSerMst.LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED_LotSerMst_LotSerNbr_NoAst] TO [MSDSL]
    AS [dbo];


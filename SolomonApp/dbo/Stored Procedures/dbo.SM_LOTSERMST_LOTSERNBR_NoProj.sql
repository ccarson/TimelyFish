 CREATE PROCEDURE SM_LOTSERMST_LOTSERNBR_NoProj
    @InvtID		varchar (30),
    @SiteID 	varchar (10),
    @WhseLoc	varchar (10),
    @LotSerNbr	varchar (25)
AS
    SELECT *
      FROM LotSerMst
     WHERE InvtID like @InvtID	
      AND SiteID like @SiteID	
      AND WhseLoc like @WhseLoc
      AND LotSerNbr like @LotSerNbr
      AND Status = 'A'
      AND (QtyOnHand - QtyAllocProjIN) > 0.0
     ORDER BY InvtId, SiteID, WhseLoc, LotSerNbr



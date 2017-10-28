 CREATE Proc WOLotSerMst_LotSerNbr
   @InvtID          varchar (30),
   @SiteID          varchar (10),
   @WhseLoc         varchar (10),
	@Today			smallDateTime
AS
   Select           *
   FROM             LotSerMst
   WHERE            InvtId = @InvtID and
                    SiteId = @SiteID and
                    WhseLoc = @WhseLoc and
                    (QtyOnHand - QtyAlloc - QtyShipNotInv - QtyWORlsedDemand) > 0 AND
                    (expDate >= @Today or expDate = '01/01/1900')
   ORDER BY         InvtId, LotSerNbr



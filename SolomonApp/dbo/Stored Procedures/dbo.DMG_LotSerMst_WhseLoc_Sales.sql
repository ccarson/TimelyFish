 CREATE PROCEDURE DMG_LotSerMst_WhseLoc_Sales
	@InvtID		varchar (30),
	@InvtID2	varchar (30),
	@LotSerNbr	varchar (25),
	@SiteID 	varchar (10),
	@WhseLoc	varchar (10)
AS

SELECT LocTable.WhseLoc, LotSerMst.LotSerNbr, LotSerMst.QtyOnHand
FROM LocTable
	left outer join LotSerMst
		on LocTable.SiteID = LotSerMst.SiteID
		and LocTable.WhseLoc = LotSerMst.WhseLoc
        and LotSerMst.InvtID = @InvtID
        and LotSerMst.LotSerNbr like @LotSerNbr
        and (LotSerMst.QtyOnHand - LotSerMst.QtyShipNotInv) <> 0
WHERE LocTable.SiteID like @SiteID	
	and LocTable.WhseLoc like @WhseLoc	
	and LocTable.SalesValid <> 'N'
order by LotSerMst.QtyOnHand desc, LocTable.WhseLoc



 CREATE PROCEDURE DMG_LotSerMst_WhseLoc_Rtns
	@InvtID		varchar (30),
	@InvtID2	varchar (30),
	@SiteID 	varchar (10),
	@WhseLoc	varchar (10)
AS
	--The LotSerNbr = '' selection is used to not show qty's and serial
	--numbers because returns don't need them.
SELECT LocTable.WhseLoc, LotSerMst.LotSerNbr, LotSerMst.QtyOnHand
FROM LocTable
	left outer join LotSerMst
		on LocTable.SiteID = LotSerMst.SiteID
		and LocTable.WhseLoc = LotSerMst.WhseLoc
        and LotSerMst.InvtID = @InvtID
        and LotSerMst.LotSerNbr = ''
WHERE LocTable.SiteID like @SiteID
	and LocTable.WhseLoc like @WhseLoc	
	and LocTable.ReceiptsValid <> 'N'
order by LotSerMst.QtyOnHand desc, LocTable.WhseLoc



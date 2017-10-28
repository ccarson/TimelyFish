 CREATE PROCEDURE DMG_Location_WhseLoc_Kits1
	@InvtID		varchar (30),
	@InvtID2	varchar (30),
	@SiteID 	varchar (10),
	@WhseLoc	varchar (10)
AS

	SELECT	LocTable.WhseLoc, Location.QtyOnHand
	FROM	LocTable
		left outer join Location
			on LocTable.SiteID = Location.SiteID
			and LocTable.WhseLoc = Location.WhseLoc
	WHERE Location.InvtID = @InvtID
	and	(LocTable.InvtIDValid = 'Y' and  LocTable.InvtID = @InvtID2  or LocTable.InvtIDValid <> 'Y')
	and 	LocTable.SiteID like @SiteID
	and 	LocTable.WhseLoc like @WhseLoc
	and	LocTable.AssemblyValid <> 'N'
        and	LocTable.WhseLoc <> '*'
        order by Location.QtyOnHand desc, LocTable.WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Location_WhseLoc_Kits1] TO [MSDSL]
    AS [dbo];


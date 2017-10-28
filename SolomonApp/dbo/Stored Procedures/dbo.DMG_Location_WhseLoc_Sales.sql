 CREATE PROCEDURE DMG_Location_WhseLoc_Sales
	@InvtID		varchar (30),
	@InvtID2	varchar (30),
	@SiteID 	varchar (10),
	@WhseLoc	varchar (10)
AS
	SELECT	LocTable.WhseLoc, Location.QtyOnHand
	FROM	LocTable
		LEFT OUTER JOIN Location
			ON LocTable.SiteID = Location.SiteID
			AND LocTable.WhseLoc = Location.WhseLoc
			AND Location.InvtID LIKE @InvtID
	WHERE (LocTable.InvtIDValid = 'Y' AND LocTable.InvtID LIKE @InvtID2 OR LocTable.InvtIDValid <> 'Y')
	AND	LocTable.SalesValid <> 'N'
	AND	LocTable.SiteID LIKE @SiteID
	AND	LocTable.WhseLoc LIKE @WhseLoc
	ORDER BY Location.QtyOnHand DESC, LocTable.WhseLoc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Location_WhseLoc_Sales] TO [MSDSL]
    AS [dbo];


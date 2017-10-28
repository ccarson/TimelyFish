 CREATE PROCEDURE WOLocation_InvtID_SiteID_LocTable
	@InvtID          varchar( 30 ),
	@SiteID          varchar( 10 )

AS
	SELECT           *
	FROM             Location L LEFT OUTER JOIN LocTable T
	ON               L.SiteID = T.SiteID and
	                 L.WhseLoc = T.WhseLoc
	WHERE            L.InvtID = @InvtID and
	                 L.SiteID LIKE @SiteID
	ORDER BY         L.InvtID, L.SiteID, L.WhseLoc



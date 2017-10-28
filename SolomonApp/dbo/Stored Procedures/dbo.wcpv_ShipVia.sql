 CREATE Procedure wcpv_ShipVia(
	@ShopperID VARCHAR(32) = '%',
	@ShipViaID VARCHAR(15) = '%'
)As

	SELECT	s.Descr, u.ShopperID, s.CpnyID, s.ShipViaID
	FROM	ShipVia s (NOLOCK)
	JOIN    WCUser u (NOLOCK) ON u.ShopperID LIKE @ShopperID
	JOIN    WCUserGroup ug  (NOLOCK) ON ug.UserGroupID = u.UserGroupID AND ug.CpnyID = s.CpnyID
	WHERE	s.ShipViaID LIKE @ShipViaID
	ORDER BY s.Descr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[wcpv_ShipVia] TO [MSDSL]
    AS [dbo];


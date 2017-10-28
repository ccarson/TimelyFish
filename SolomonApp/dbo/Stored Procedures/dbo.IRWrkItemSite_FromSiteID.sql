 CREATE PROCEDURE IRWrkItemSite_FromSiteID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM IRWrkItemSite
	WHERE FromSiteID LIKE @parm1
	ORDER BY FromSiteID



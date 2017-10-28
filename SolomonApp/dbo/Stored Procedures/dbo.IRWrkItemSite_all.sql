 CREATE PROCEDURE IRWrkItemSite_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM IRWrkItemSite
	WHERE SiteID LIKE @parm1
	ORDER BY SiteID



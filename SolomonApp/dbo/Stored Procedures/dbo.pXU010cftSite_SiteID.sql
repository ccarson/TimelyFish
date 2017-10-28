CREATE PROCEDURE pXU010cftSite_SiteID
	-- CREATED BY: TJones
	-- CREATED ON: 6/06/05
	@parm1 varchar(6)
	AS
	SELECT *
	FROM cftSite
	WHERE SiteID LIKE @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXU010cftSite_SiteID] TO [MSDSL]
    AS [dbo];


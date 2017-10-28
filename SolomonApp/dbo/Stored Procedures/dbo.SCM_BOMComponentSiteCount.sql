 CREATE PROCEDURE SCM_BOMComponentSiteCount
	@parm1 varchar( 30 ), @parm2 varchar ( 10 )
AS
	SELECT Count(Distinct SiteID) FROM Component WHERE
		KitID = @parm1 and
		KitSiteID = @parm2 and
		KitStatus = 'A'



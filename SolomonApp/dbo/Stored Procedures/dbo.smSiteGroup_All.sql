 CREATE PROCEDURE
	smSiteGroup_All
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smSiteGroup
	WHERE
		CustSiteGroupID LIKE @parm1
	ORDER BY
		CustSiteGroupID



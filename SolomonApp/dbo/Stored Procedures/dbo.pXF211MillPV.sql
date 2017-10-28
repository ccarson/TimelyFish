CREATE PROCEDURE pXF211MillPV 
	@parm1 AS  varchar(6)
	AS 
	SELECT c.ContactID, c.ContactName
	FROM
	cftContact c
	JOIN cftContactRoleType rt ON c.ContactID = rt.ContactID
	WHERE rt.RoleTypeID = '010' and c.StatusTypeId = '1' AND c.ContactID LIKE @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF211MillPV] TO [MSDSL]
    AS [dbo];


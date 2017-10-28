 CREATE PROCEDURE Component_KitID_CmpnentID_KitSite_KitStatus
	@parm1 varchar( 30 ),
	@parm2 varchar( 30 ),
	@parm3 varchar( 10 ),
	@parm4 varchar( 1 )

AS
	SELECT *
	FROM Component
	WHERE KitID LIKE @parm1
	   AND CmpnentID LIKE @parm2
	   AND KitSiteID LIKE @parm3
	   AND KitStatus LIKE @parm4

	ORDER BY KitID,
	   CmpnentID,
	   KitSiteID,
	   KitStatus



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_KitID_CmpnentID_KitSite_KitStatus] TO [MSDSL]
    AS [dbo];


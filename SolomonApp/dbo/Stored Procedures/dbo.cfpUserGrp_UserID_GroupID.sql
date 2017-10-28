CREATE PROCEDURE cfpUserGrp_UserID_GroupID
	(@UserID varchar(47), @GroupID varchar(47))
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
	AS
	SELECT * FROM SolomonSystem.dbo.UserGrp (NOLOCK)
	WHERE UserID = @UserID AND GroupID = @GroupID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpUserGrp_UserID_GroupID] TO [MSDSL]
    AS [dbo];


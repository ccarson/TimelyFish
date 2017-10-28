

CREATE Proc XDDUser_All
 	@UserID  	varchar( 47 )  
AS  
	SELECT		*   
 	FROM		XDDUser
 	WHERE		XDDUser.UserID LIKE @UserID  
 	ORDER BY  	XDDUser.UserID  

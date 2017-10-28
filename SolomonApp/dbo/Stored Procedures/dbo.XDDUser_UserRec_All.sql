

CREATE Proc XDDUser_UserRec_All  
 	@UserID  	varchar( 47 )  
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'

AS  
	SELECT		*   
 	FROM		XDDUser LEFT OUTER JOIN vs_UserRec
 			ON XDDUser.UserID = vs_UserRec.UserID
 	WHERE		XDDUser.UserID LIKE @UserID  
 	ORDER BY  	XDDUser.UserID  

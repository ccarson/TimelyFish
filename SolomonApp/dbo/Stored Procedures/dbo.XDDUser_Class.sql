

CREATE Proc XDDUser_Class
 	@UserID  	varchar( 47 )  
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'

AS  
	SELECT		*   
 	FROM		XDDUser U (nolock) LEFT OUTER JOIN vs_UserRec S (nolock)
 			ON U.UserID = S.UserID and S.RecType = 'U'
 	WHERE		U.UserID LIKE @UserID  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDUser_Class] TO [MSDSL]
    AS [dbo];


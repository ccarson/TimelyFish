

CREATE Proc XDDUserRec_Approver2_PV
 	@UserID  	varchar( 47 )
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS  

	SELECT		*   
 	FROM		XDDUser
 	WHERE		AmtAppLvl2 = 1
			and UserID LIKE @UserID
 	ORDER BY  	UserID  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDUserRec_Approver2_PV] TO [MSDSL]
    AS [dbo];


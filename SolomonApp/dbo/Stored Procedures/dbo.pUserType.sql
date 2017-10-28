CREATE PROC [dbo].[pUserType] 
	@UserName varchar(30),
	@UserStatus varchar(30) OUTPUT
	As
		
	Select @UserStatus=(UserType) 
	from dbo.MarketUserType
	where UserID=@UserName


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUserType] TO [MSDSL]
    AS [dbo];


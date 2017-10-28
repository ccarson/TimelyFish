
CREATE procedure WSL_AccessWebSeviceRights
  
  @page  int
 ,@size  int
 ,@sort   nvarchar(200),
 @CpnyID varchar(10), 
@UserID varchar(47),  
@Methods varchar(1024),
@WinUser varchar(85) as 
  SET NOCOUNT ON
  DECLARE
    @lbound int,
    @ubound int

if (@UserID = '') Begin  set @UserID = (SELECT userID FROM vs_USERREC WHERE RecType = 'U' AND [WindowsUserAcct] = @WinUser AND defaultuser = 1) end

  IF @page = 0  -- Don't do paging
	  BEGIN
		SELECT AccessRights,MethodName FROM [vs_WebServiceAccessRi] rights (nolock) WHERE 
		(RecType = 'U' and UserId = @UserID or UserId in ( select GroupID from vs_usergrp where UserID=@UserID)) AND 
		(CompanyID = @CpnyID or CompanyID='[ALL]') and MethodName like @Methods and AccessRights = 1
	  END
  ELSE
	  BEGIN
		IF @page < 1 SET @page = 1
		IF @size < 1 SET @size = 1
		SET @lbound = (@page-1) * @size
		SET @ubound = @page * @size + 1

		BEGIN
		with PagingCTE AS
				( SELECT  TOP( @ubound-1) AccessRights,MethodName,ROW_NUMBER() OVER(ORDER BY @sort ) AS row
				 FROM [vs_WebServiceAccessRi] rights (nolock) WHERE 
						(RecType = 'U' and UserId = @UserID or UserId in ( select GroupID from vs_usergrp where UserID=@UserID)) AND 
						(CompanyID = @CpnyID or CompanyID='[ALL]') and MethodName like @Methods and AccessRights = 1
				)
					SELECT  AccessRights, MethodName
					FROM PagingCTE                     
					WHERE  row >  @lbound  AND
						   row <  @ubound 
					ORDER BY row
		END
	  END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_AccessWebSeviceRights] TO [MSDSL]
    AS [dbo];


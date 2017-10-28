CREATE PROCEDURE WSL_UserList
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (47) -- UserID
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'UserId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  UserId [User ID],  
			 UserName [User Name]
			 FROM vs_UserRec (nolock)
			 where UserId like ' + quotename(@parm1,'''') + '
			   and RecType = ''U''
			 ORDER BY ' + @sort
	  END		 
  ELSE
	  BEGIN
			IF @page < 1 SET @page = 1
			IF @size < 1 SET @size = 1
			SET @lbound = (@page-1) * @size
			SET @ubound = @page * @size + 1
			SET @STMT = 
				'WITH PagingCTE AS
				(
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') 
				UserId, 
				UserName,  
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM vs_UserRec (nolock)
				WHERE UserId like ' + quotename(@parm1,'''') + '
	              and RecType = ''U''
				) 
				SELECT  UserId [User ID], UserName [User Name]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_UserList] TO [MSDSL]
    AS [dbo];


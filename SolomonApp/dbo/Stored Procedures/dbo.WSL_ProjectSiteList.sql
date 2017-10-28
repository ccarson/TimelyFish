
CREATE PROCEDURE WSL_ProjectSiteList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (4) -- terminal code
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'PJSITE.TerminalCode'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT TerminalCode [Site ID], TerminalName [Description], emailaddress [EMail]
			 FROM PJSITE(nolock)
			 where TerminalCode LIKE ' + QUOTENAME(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') TerminalCode, TerminalName, emailaddress
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJSITE(nolock)
					where TerminalCode LIKE ' + QUOTENAME(@parm1,'''') + '
				) 
				SELECT TerminalCode [Site ID], TerminalName [Description], emailaddress [EMail]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectSiteList] TO [MSDSL]
    AS [dbo];


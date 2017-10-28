
CREATE PROCEDURE WSL_ActiveSubAcctList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (24) -- sub
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'subacct.sub'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Sub [Subaccount], Descr [Description]
			 FROM Subacct(nolock)
			 where Active = 1
			  and  Sub LIKE ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Sub, Descr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Subacct(nolock)
					where Active = 1
			  		and  Sub LIKE ' + quotename(@parm1,'''') + '
				) 
				SELECT Sub [Subaccount], Descr [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ActiveSubAcctList] TO [MSDSL]
    AS [dbo];


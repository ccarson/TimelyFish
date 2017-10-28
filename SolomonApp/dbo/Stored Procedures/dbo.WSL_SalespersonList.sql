CREATE PROCEDURE WSL_SalespersonList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- SlsperId 
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'SlsperId'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT SlsperId [Salesperson ID], Name [Name], Phone [Phone], Zip [Postal Code]
			 FROM Salesperson (nolock)
			 WHERE SlsperId LIKE ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SlsperId, Name, Phone, Zip,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Salesperson (nolock)
				WHERE SlsperId LIKE ' + quotename(@parm1,'''') + '
				) 
				SELECT SlsperId [Salesperson ID], Name [Name], Phone [Phone], Zip [Postal Code]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

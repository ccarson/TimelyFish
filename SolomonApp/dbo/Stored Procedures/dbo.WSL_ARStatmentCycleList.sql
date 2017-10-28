CREATE PROCEDURE WSL_ARStatmentCycleList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (2) -- StmtCycleId
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'StmtCycleId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT StmtCycleId [Cycle ID], LastStmtDate [Last Stmt], LastAgeDate [Last Aged], LastFinChrgDate [Last Fin Chrg]
			 FROM ARStmt (nolock)
			 WHERE StmtCycleId LIKE ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') StmtCycleId, LastStmtDate, LastAgeDate, LastFinChrgDate,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM ARStmt (nolock)
				WHERE StmtCycleId LIKE ' + quotename(@parm1,'''') + '
				) 
				SELECT StmtCycleId [Cycle ID], LastStmtDate [Last Stmt], LastAgeDate [Last Aged], LastFinChrgDate [Last Fin Chrg]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

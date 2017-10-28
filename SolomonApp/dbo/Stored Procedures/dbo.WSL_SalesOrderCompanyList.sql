
CREATE PROCEDURE WSL_SalesOrderCompanyList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@BaseCuryID varchar(4) -- 
 ,@DatabaseName varchar(30) -- 
 ,@CpnyID varchar(10) -- 
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CpnyID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT vs_company.CpnyID [Company ID], vs_company.CpnyName [Company Name]
			 FROM vs_company(nolock)
			 where BaseCuryID LIKE ' + quotename(@BaseCuryID,'''') + ' AND DatabaseName LIKE ' + quotename(@DatabaseName,'''') + ' AND CpnyID LIKE ' + quotename(@CpnyID,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') vs_company.CpnyID, vs_company.CpnyName
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM vs_company(nolock)
					where BaseCuryID LIKE ' + quotename(@BaseCuryID,'''') + ' AND DatabaseName LIKE ' + quotename(@DatabaseName,'''') + ' AND CpnyID LIKE ' + quotename(@CpnyID,'''') + ' 
				) 
				SELECT CpnyID [Company ID], CpnyName [Company Name]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_SalesOrderCompanyList] TO [MSDSL]
    AS [dbo];


CREATE PROCEDURE WSL_CompanyList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- Database Name
 ,@parm2 varchar (10) -- Company ID
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
			'SELECT CpnyID [Company], CpnyName [Company Name]
			 FROM vs_company (nolock)
			 where DatabaseName = ' + quotename(@parm1,'''') + '
			  and  CpnyID like ' + quotename(@parm2,'''') + '
			  and  Active =  1
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') CpnyID, CpnyName  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM vs_company (nolock)
					where DatabaseName = ' + quotename(@parm1,'''') + '
					and  CpnyID like ' + quotename(@parm2,'''') + '
					and  Active =  1
				) 
				SELECT CpnyID [Company], CpnyName [Company Name]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

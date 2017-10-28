CREATE PROCEDURE WSL_CurrencyList
@page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (6) -- CuryId, with % before and after
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CuryId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT CuryId [Currency ID], Descr [Currency Description], CurySym [Symbol], DecPl [Decimal Places]
			 FROM Currncy (nolock)
			 WHERE CuryId LIKE ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') CuryId, Descr, CurySym, DecPl,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Currncy
				WHERE CuryId LIKE ' + quotename(@parm1,'''') + '
				) 
				SELECT CuryId [Currency ID], Descr [Currency Description], CurySym [Symbol], DecPl [Decimal Places]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

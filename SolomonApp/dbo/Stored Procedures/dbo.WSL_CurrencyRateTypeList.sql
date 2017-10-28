CREATE PROCEDURE WSL_CurrencyRateTypeList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (6) -- RateTypeId
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'RateTypeId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT RateTypeId [Rate Type ID], Descr [Rate Type Description]
			 FROM CuryRtTp (nolock)
			 WHERE RateTypeId LIKE ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') RateTypeId, Descr, 
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM CuryRtTp
				WHERE RateTypeId LIKE ' + quotename(@parm1,'''') + '
				) 
				SELECT RateTypeId [Rate Type ID], Descr [Rate Type Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

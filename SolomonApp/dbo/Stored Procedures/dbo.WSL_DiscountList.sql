
CREATE PROCEDURE WSL_DiscountList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- CpnyID
 ,@parm2 varchar (1) -- DiscountID
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'DiscountID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  SODiscCode.DiscountID [Discount ID], SODiscCode.Descr [Description]
			 FROM SODiscCode(nolock)
			 where CpnyID = ' + quotename(@parm1,'''') + ' 
			 and DiscountID LIKE ' + QUOTENAME(@parm2,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SODiscCode.DiscountID, SODiscCode.Descr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SODiscCode(nolock)
					where CpnyID = ' + quotename(@parm1,'''') + ' 
					and DiscountID LIKE ' + QUOTENAME(@parm2,'''') + '
				) 
				SELECT DiscountID [Discount ID], Descr [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

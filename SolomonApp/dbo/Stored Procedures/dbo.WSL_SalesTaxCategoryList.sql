
CREATE PROCEDURE WSL_SalesTaxCategoryList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar(10) -- CatId
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CatID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT SlsTaxCat.CatId [Category ID], SlsTaxCat.Descr [Description]
			 FROM SlsTaxCat(nolock)
			 where CatId like ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SlsTaxCat.CatId, SlsTaxCat.Descr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SlsTaxCat(nolock)
					where CatId like ' + quotename(@parm1,'''') + ' 
				) 
				SELECT CatId [Category ID], Descr [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_SalesTaxCategoryList] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE [dbo].[WSL_ProjectMaintSalesTaxList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (12) -- TaxId
 ,@parm2 varchar (32) -- Description
 ,@parm3 varchar (22) -- Tax Rate
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int,
    @TaxIdAlias varchar (15) = 'Tax ID',
	@DescrAlias varchar (15) = 'Description',
	@TaxRateAlias varchar (15) = 'Tax Rate',
    @whereExpression nvarchar(150)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND SalesTax.Descr LIKE ' + QUOTENAME(@parm2, '''');
	   IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND SalesTax.TaxRate LIKE ' + QUOTENAME(@parm3, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'SalesTax.TaxId'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'SalesTax.Descr'
			  Else IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'SalesTax.TaxRate'
              ELSE SET @sort = 'SalesTax.TaxId'
       END
	   ELSE
	   BEGIN
			  IF @sort = @TaxIdAlias SET @sort = 'SalesTax.TaxId'
			  ELSE IF @sort = @DescrAlias SET @sort = 'SalesTax.Descr'
			  ELSE IF @sort = @TaxRateAlias SET @sort = 'SalesTax.TaxRate'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT TaxId [' + @TaxIdAlias + '], Descr [' + @DescrAlias + '], TaxRate [' + @TaxRateAlias + ']
			 FROM SalesTax (nolock)
			 WHERE TaxId LIKE ' + quotename(@parm1,'''') + @whereExpression + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') TaxId, Descr, TaxRate,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SalesTax (nolock)
				WHERE TaxId LIKE ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT TaxId [' + @TaxIdAlias + '], Descr [' + @DescrAlias + '], TaxRate [' + @TaxRateAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintSalesTaxList] TO [MSDSL]
    AS [dbo];


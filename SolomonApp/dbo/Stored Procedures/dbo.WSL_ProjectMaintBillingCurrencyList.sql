
CREATE PROCEDURE [dbo].[WSL_ProjectMaintBillingCurrencyList]
@page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (6) -- CuryId, with % before and after
 ,@parm2 varchar (32) -- Currency Description
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int,
	@CuryIdAlias varchar (15) = 'Currency ID',
	@DescrAlias varchar (25) = 'Currency Description',
	@CurySymAlias varchar (10) = 'Symbol',
	@DecPlAlias varchar (20) = 'Decimal Places',
    @whereExpression nvarchar(60)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND Currncy.Descr LIKE ' + QUOTENAME(@parm2, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'Currncy.CuryId'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'Currncy.Descr'
              ELSE SET @sort = 'Currncy.CuryId'
       END
	   ELSE
	   BEGIN
			  IF @sort = @CuryIdAlias SET @sort = 'Currncy.CuryId'
			  ELSE IF @sort = @DescrAlias SET @sort = 'Currncy.Descr'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT CuryId [' + @CuryIdAlias + '], Descr [' + @DescrAlias + '], CurySym [' + @CurySymAlias + '], DecPl [' + @DecPlAlias + ']
			 FROM Currncy (nolock)
			 WHERE CuryId LIKE ' + quotename(@parm1,'''') + @whereExpression + ' 
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
				WHERE CuryId LIKE ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT CuryId [' + @CuryIdAlias + '], Descr [' + @DescrAlias + '], CurySym [' + @CurySymAlias + '], DecPl [' + @DecPlAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintBillingCurrencyList] TO [MSDSL]
    AS [dbo];


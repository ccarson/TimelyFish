
CREATE PROCEDURE [dbo].[WSL_ProjectMaintCurrencyRateTypeList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (8) -- Rate Type Id
 ,@parm2 varchar (32) -- Rate Type Description
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int,
	@RateTypeIdAlias varchar (15) = 'Rate Type ID',
	@DescrAlias varchar (25) = 'Rate Type Description',
    @whereExpression nvarchar(80)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND CuryRtTp.Descr LIKE ' + QUOTENAME(@parm2, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'CuryRtTp.RateTypeId'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'CuryRtTp.Descr'
              ELSE SET @sort = 'CuryRtTp.RateTypeId'
       END
	   ELSE
	   BEGIN
			  IF @sort = @RateTypeIdAlias SET @sort = 'CuryRtTp.RateTypeId'
			  ELSE IF @sort = @DescrAlias SET @sort = 'CuryRtTp.Descr'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT RateTypeId [' + @RateTypeIdAlias + '], Descr [' + @DescrAlias + ']
			 FROM CuryRtTp (nolock)
			 WHERE RateTypeId LIKE ' + quotename(@parm1,'''') + @whereExpression + ' 
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
				WHERE RateTypeId LIKE ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT RateTypeId [' + @RateTypeIdAlias + '], Descr [' + @DescrAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintCurrencyRateTypeList] TO [MSDSL]
    AS [dbo];




CREATE PROCEDURE [dbo].[WSL_ProjectMaintCountryRegionList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (5) -- CountryId
 ,@parm2 varchar (32) -- Country Description

AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int,
	@CountryIDAlias varchar (4) = 'ID',
	@DescrAlias varchar(15) = 'Description',
	@whereExpression nvarchar(100)
    
	SET @whereExpression = ''
	
	IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
		SET @whereExpression = @whereExpression + ' AND Country.Descr LIKE ' + QUOTENAME(@parm2, '''');

    IF @sort = ''
		BEGIN
			IF @parm1 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'Country.CountryID'
			ELSE IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'Country.descr'
			ELSE SET @sort = 'Country.CountryID'
		END
	ELSE
		BEGIN
			IF @sort = @CountryIDAlias SET @sort = 'Country.CountryID'
			ELSE IF @sort = @DescrAlias SET @sort = 'Country.descr'
		END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT CountryId [' + @CountryIDAlias + '], Descr [' + @DescrAlias + ']
			 FROM Country (nolock)
			 WHERE CountryId LIKE ' + quotename(@parm1,'''') + @whereExpression + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') CountryId, Descr, 
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Country
				WHERE CountryID LIKE ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT CountryId [' + @CountryIDAlias + '], Descr [' + @DescrAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintCountryRegionList] TO [MSDSL]
    AS [dbo];


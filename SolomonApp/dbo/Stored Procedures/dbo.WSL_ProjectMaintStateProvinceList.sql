
CREATE PROCEDURE [dbo].[WSL_ProjectMaintStateProvinceList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (5)  -- StateProvId
 ,@parm2 varchar (27) --State Description
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int,
	@StateProvIDAlias varchar (20) = 'State/Province',
	@DescrAlias varchar(15) = 'Description',
	@whereExpression nvarchar(100)
    
	SET @whereExpression = ''

	IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
		SET @whereExpression = @whereExpression + ' AND state.descr LIKE ' + QUOTENAME(@parm2, '''');

	IF @sort = ''
		BEGIN
			IF @parm1 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'state.StateProvId'
			ELSE IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'state.descr'
			ELSE SET @sort = 'state.StateProvID'
		END
	ELSE
		BEGIN
			IF @sort = @StateProvIDAlias SET @sort = 'state.StateProvId'
			ELSE IF @sort = @DescrAlias SET @sort = 'state.descr'
		END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT StateProvID [' + @StateProvIDAlias + '], Descr [' + @DescrAlias + ']
			 FROM State (nolock)
			 WHERE StateProvID LIKE ' + quotename(@parm1,'''') + @whereExpression + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') StateProvID, Descr, 
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM State
				WHERE StateProvID LIKE ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT StateProvID [' + @StateProvIDAlias + '], Descr [' + @DescrAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintStateProvinceList] TO [MSDSL]
    AS [dbo];


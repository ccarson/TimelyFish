
CREATE PROCEDURE [dbo].[WSL_ProjectMaintAccountCategoryBudgetList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (18) -- Acct
 ,@parm2 varchar (32) -- Description 
 ,@parm3 varchar (4) -- Type
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int,
	@AcctAlias varchar (20) = 'Account Category',
	@TypeAlias varchar (10) = 'Type',
	@DescrAlias varchar (20) = 'Description',
	@whereExpression nvarchar(100)

	SET @whereExpression = ''
	
	IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
		SET @whereExpression = @whereExpression + ' AND PJACCT.acct_desc LIKE ' + QUOTENAME(@parm2, '''');
	IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
		SET @whereExpression = @whereExpression + ' AND PJACCT.acct_type LIKE ' + QUOTENAME(@parm3, '''');

    IF @sort = ''
		BEGIN
			IF @parm1 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'PJACCT.acct'
			ELSE IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'PJACCT.acct_desc'
			ELSE IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'PJACCT.acct_type'
			ELSE SET @sort = 'PJACCT.acct'
		END
	ELSE
		BEGIN
			IF @sort = @AcctAlias SET @sort = 'PJACCT.acct'
			ELSE IF @sort = @DescrAlias SET @sort = 'PJACCT.acct_desc'
			ELSE IF @sort = @TypeAlias SET @sort = 'PJACCT.acct_type'
		END

  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT acct [' + @AcctAlias + '], acct_type [' + @TypeAlias + '], acct_desc [' + @DescrAlias + ']
			 FROM PJACCT (nolock)
			 WHERE acct LIKE ' + quotename(@parm1,'''') + @whereExpression + '
			   AND acct_status = ''A'' AND id1_sw=''Y''
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') acct, acct_type, acct_desc
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJACCT (nolock)
				WHERE acct LIKE ' + quotename(@parm1,'''') + @whereExpression + '
			      AND acct_status = ''A'' AND id1_sw=''Y''
				) 
				SELECT acct [' + @AcctAlias + '], acct_type [' + @TypeAlias + '], acct_desc [' + @DescrAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


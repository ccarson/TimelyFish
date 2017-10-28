CREATE PROCEDURE WSL_BudgetAccountCategoryList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Acct 
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int

    IF @sort = '' SET @sort = 'acct'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT acct [Account Category], acct_type [Type], acct_desc [Description]
			 FROM PJACCT (nolock)
			 WHERE acct LIKE ' + quotename(@parm1,'''') + '
			   AND id1_sw = ''Y''
			   AND  (PJAcct.acct_status = ''A'' or PJAcct.acct_status = ''I'')
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
				WHERE acct LIKE ' + quotename(@parm1,'''') + '
				  AND id1_sw = ''Y''
			      AND (PJAcct.acct_status = ''A'' or PJAcct.acct_status = ''I'')
				) 
				SELECT acct [Account Category], acct_type [Type], acct_desc [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

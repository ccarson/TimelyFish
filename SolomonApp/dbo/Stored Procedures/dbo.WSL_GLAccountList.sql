CREATE PROCEDURE WSL_GLAccountList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Acct 
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
			'SELECT acct [Account], descr [Description], accttype [Type], acct_cat [Account Category], curyid [Currency ID]
			 FROM Account (nolock)
			 WHERE acct LIKE ' + quotename(@parm1,'''') + '
			   AND Active <> 0  
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') acct, descr, accttype, acct_cat, curyid
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Account (nolock)
				WHERE acct LIKE ' + quotename(@parm1,'''') + '
				  AND Active <> 0  
				) 
			    SELECT acct [Account], descr [Description], accttype [Type], acct_cat [Account Category], curyid [Currency ID]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

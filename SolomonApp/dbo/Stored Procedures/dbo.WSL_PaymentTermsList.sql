
CREATE PROCEDURE WSL_PaymentTermsList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (1) -- ApplyTo 
 ,@parm2 varchar (4) -- SOBehavior
 ,@parm3 varchar (4) -- SOBehavior2
 ,@parm4 varchar (2) -- TermsID
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'TermsId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Terms.TermsID [Terms ID], Terms.Descr [Description]
			 FROM Terms(nolock)
			 Where ApplyTo IN (' + quotename(@parm1,'''') + ',''B'') 
			 AND ((TermsType = ''S'' 
			 and ' + quotename(@parm2,'''') + ' in (''CM'', ''DM'', ''RMA'')) 
			 or (TermsType = TermsType 
			 and ' + quotename(@parm3,'''') + ' NOT in (''CM'', ''DM'', ''RMA''))) 
			 and TermsID LIKE ' + quotename(@parm4,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Terms.TermsID, Terms.Descr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Terms(nolock)
					Where ApplyTo IN (' + quotename(@parm1,'''') + ',''B'') 
					AND ((TermsType = ''S'' 
					and ' + quotename(@parm2,'''') + ' in (''CM'', ''DM'', ''RMA'')) 
					or (TermsType = TermsType 
					and ' + quotename(@parm3,'''') + ' NOT in (''CM'', ''DM'', ''RMA''))) 
					and TermsID LIKE ' + quotename(@parm4,'''') + ' 
				) 
				SELECT TermsID [Terms ID], Descr [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_PaymentTermsList] TO [MSDSL]
    AS [dbo];


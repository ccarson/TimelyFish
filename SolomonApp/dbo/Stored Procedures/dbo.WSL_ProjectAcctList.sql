
CREATE PROCEDURE WSL_ProjectAcctList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- account
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'account.Acct'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Account.Acct [Account], Account.Descr [Description], PJ_Account.Acct [Acct Category]
			 FROM Account(nolock), PJ_Account(nolock)
			 where Account.Acct = Pj_Account.gl_Acct
			  and  Account.Acct LIKE ' + quotename(@parm1,'''') + '
			  and  Account.Active = 1 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Account.Acct, Account.Descr, PJ_Account.Acct [Category]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Account(nolock), PJ_Account(nolock)
					where Account.Acct = Pj_Account.gl_Acct
			  		and  Account.Acct LIKE ' + quotename(@parm1,'''') + '
			  		and  Account.Active = 1 
				) 
				SELECT Acct [Account], Descr [Description], Category [Acct Category]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectAcctList] TO [MSDSL]
    AS [dbo];


CREATE PROCEDURE WSL_LaborGLAccountList
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Account
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
  IF @sort = '' SET @sort = 'Account.Acct'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  Account.Acct [Account], Descr [Description], PJ_Account.Acct [Acct Category]
			 FROM Account (nolock)
			 Inner Join PJ_Account
			   ON Account.Acct = Pj_Account.gl_Acct
			 Inner Join PJAcct
			   ON Pj_Account.Acct = PJAcct.acct			  
			 where Account.acct like ' + quotename(@parm1,'''') + '
			  and  Account.Active = 1
			  and  (PJAcct.id5_sw = ''L'' or PJAcct.id5_sw = '' '')
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Account.Acct, Descr, PJ_Account.acct as [AcctCat]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				 FROM Account (nolock)
				 Inner Join PJ_Account
				   ON Account.Acct = Pj_Account.gl_Acct
				 Inner Join PJAcct
				   ON Pj_Account.Acct = PJAcct.acct			  
				 where Account.acct like ' + quotename(@parm1,'''') + '
				  and  Account.Active = 1
				  and  (PJAcct.id5_sw = ''L'' or PJAcct.id5_sw = '' '')
				) 
				SELECT  Acct [Account], Descr [Description], AcctCat [Acct Category]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_LaborGLAccountList] TO [MSDSL]
    AS [dbo];


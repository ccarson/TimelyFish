
CREATE PROCEDURE [dbo].[WSL_ProjectMaintLaborGLAccountList]
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (12) -- Account
 ,@parm2 varchar (32) -- Description
 ,@parm3 varchar (18) -- Account Category
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@Account_AcctAlias varchar (10) = 'Account',
	@DescrAlias varchar (15) = 'Description',
	@PJ_Account_AcctAlias varchar (15) = 'Acct Category',
    @whereExpression nvarchar(80)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND Account.Descr LIKE ' + QUOTENAME(@parm2, '''');
	   IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND PJ_Account.Acct LIKE ' + QUOTENAME(@parm3, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'Account.Acct'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'Account.Descr'
			  Else IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'PJ_Account.Acct'
              ELSE SET @sort = 'Account.Acct'
       END
	   ELSE
	   BEGIN
			  IF @sort = @Account_AcctAlias SET @sort = 'Account.Acct'
			  ELSE IF @sort = @DescrAlias SET @sort = 'Account.Descr'
			  ELSE IF @sort = @PJ_Account_AcctAlias SET @sort = 'PJ_Account.Acct'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  Account.Acct [' + @Account_AcctAlias + '], Descr [' + @DescrAlias + '], PJ_Account.Acct [' + @PJ_Account_AcctAlias + ']
			 FROM Account (nolock)
			 Inner Join PJ_Account
			   ON Account.Acct = Pj_Account.gl_Acct
			 Inner Join PJAcct
			   ON Pj_Account.Acct = PJAcct.acct			  
			 where Account.acct like ' + quotename(@parm1,'''') + @whereExpression + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Account.Acct As [AcctId], Descr, PJ_Account.acct as [AcctCat]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				 FROM Account (nolock)
				 Inner Join PJ_Account
				   ON Account.Acct = Pj_Account.gl_Acct
				 Inner Join PJAcct
				   ON Pj_Account.Acct = PJAcct.acct			  
				 where Account.acct like ' + quotename(@parm1,'''') + @whereExpression + '
				  and  Account.Active = 1
				  and  (PJAcct.id5_sw = ''L'' or PJAcct.id5_sw = '' '')
				) 
				SELECT  AcctId [' + @Account_AcctAlias + '], Descr [' + @DescrAlias + '], AcctCat [' + @PJ_Account_AcctAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintLaborGLAccountList] TO [MSDSL]
    AS [dbo];


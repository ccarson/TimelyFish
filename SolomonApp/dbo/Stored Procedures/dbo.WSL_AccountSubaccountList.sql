CREATE PROCEDURE WSL_AccountSubaccountList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Acct
 ,@parm2 varchar (24) -- Sub 
 ,@parm3 varchar (10) -- CpnyID
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CpnyID,Acct,Sub'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Acct [Account], Sub [Subaccount], CpnyID [Company Id], Descr [Description]
			 FROM vs_AcctSub (nolock)
			 WHERE Acct LIKE ' + quotename(@parm1,'''') + ' 
			 AND Sub LIKE ' + quotename(@parm2,'''') + ' 
			 AND CpnyID IN (SELECT CpnyId FROM vs_Company WHERE Databasename = (SELECT Databasename FROM vs_Company WHERE CpnyID = ' + quotename(@parm3,'''') + '))
			 AND Active = 1
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Acct, Sub, CpnyId, Descr,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM vs_AcctSub (nolock)
			    WHERE Acct LIKE ' + quotename(@parm1,'''') + ' 
			    AND Sub LIKE ' + quotename(@parm2,'''') + ' 
			    AND CpnyID IN (SELECT CpnyId FROM vs_Company WHERE Databasename = (SELECT Databasename FROM vs_Company WHERE CpnyID = ' + quotename(@parm3,'''') + '))
  			    AND Active = 1
				) 
				SELECT Acct [Account], Sub [Subaccount], CpnyID [Company Id], Descr [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_AccountSubaccountList] TO [MSDSL]
    AS [dbo];


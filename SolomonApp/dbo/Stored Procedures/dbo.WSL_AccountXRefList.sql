CREATE PROCEDURE WSL_AccountXRefList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- CpnyID
 ,@parm2 varchar (10) -- Acct 
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CpnyID,Acct'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Acct [Account], Descr [Description]
			 FROM vs_AcctXRef (nolock)
			 WHERE CpnyID = (SELECT CpnyCOA from vs_company WHERE CpnyID = ' + quotename(@parm1,'''') + ') 
			 AND Acct LIKE ' + quotename(@parm2,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Acct, Descr,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM vs_AcctXRef (nolock)
				WHERE CpnyID = (SELECT CpnyCOA from vs_company WHERE CpnyID = ' + quotename(@parm1,'''') + ') 
				AND Acct LIKE ' + quotename(@parm2,'''') + ' 
				AND Active = 1
				) 
				SELECT Acct [Account], Descr [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_AccountXRefList] TO [MSDSL]
    AS [dbo];


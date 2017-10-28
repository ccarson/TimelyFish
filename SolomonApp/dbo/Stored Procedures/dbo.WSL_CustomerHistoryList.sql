CREATE PROCEDURE WSL_CustomerHistoryList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- CpnyID
 ,@parm2 varchar (15) -- CustomerId
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CustId,CpnyID,FiscYr'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT FiscYr [Year], CustId [Customer ID], CpnyID [Company ID]
			 FROM ARHist (nolock)
			 WHERE CpnyID LIKE ' + quotename(@parm1,'''') + ' 
			 AND CustId LIKE ' + quotename(@parm2,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') FiscYr, CustId, CpnyID,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
			    FROM ARHist (nolock)
			    WHERE CpnyID LIKE ' + quotename(@parm1,'''') + ' 
			    AND CustId LIKE ' + quotename(@parm2,'''') + ' 
				) 
				SELECT FiscYr [Year], CustId [Customer ID], CpnyID [Company ID]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_CustomerHistoryList] TO [MSDSL]
    AS [dbo];


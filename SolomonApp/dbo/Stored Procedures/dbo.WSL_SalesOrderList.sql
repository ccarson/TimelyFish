
CREATE PROCEDURE WSL_SalesOrderList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- CpnyID
 ,@parm2 varchar (15) -- OrderNbr
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CpnyID, OrdNbr DESC'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT SOHeader.OrdNbr [Order Number], SOHeader.Status [Status], SOHeader.SOTypeID [Order Type], 
				SOHeader.OrdDate [Order Date], SOHeader.CustID [Customer ID], SOHeader.CustOrdNbr [Customer PO], 
				SOHeader.TotMerch [Total Merchandise], SOHeader.Cancelled [Cancelled]
			 FROM SOHeader(nolock)
			 where CpnyID = ' + quotename(@parm1,'''') + ' 
			  and  OrdNbr LIKE ' + quotename(@parm2,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SOHeader.OrdNbr, SOHeader.Status, SOHeader.SOTypeID, 
					SOHeader.OrdDate, SOHeader.CustID, SOHeader.CustOrdNbr, SOHeader.TotMerch, SOHeader.Cancelled
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SOHeader(nolock)
					where CpnyID = ' + quotename(@parm1,'''') + ' 
					 and  OrdNbr LIKE ' + quotename(@parm2,'''') + ' 
				) 
				SELECT OrdNbr [Order Number], Status [Status], SOTypeID [Order Type], OrdDate [Order Date], CustID [Customer ID], CustOrdNbr [Customer PO], 
					TotMerch [Total Merchandise], Cancelled [Cancelled]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_SalesOrderList] TO [MSDSL]
    AS [dbo];


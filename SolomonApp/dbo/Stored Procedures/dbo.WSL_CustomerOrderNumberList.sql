
CREATE PROCEDURE WSL_CustomerOrderNumberList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- CpnyID 
 ,@parm2 varchar (25) -- CustOrdNbr
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CustOrdNbr, CustID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT SOHeader.CustOrdNbr [Customer Order], SOHeader.CustID [Customer ID], SOHeader.OrdNbr [Order Nbr], SOHeader.OrdDate [Order Date], SOHeader.SOTypeID [Order Type], SOHeader.Status [Status], SOHeader.SlsperID [Salesperson]
			 FROM SOHeader(nolock)
			 WHERE CpnyID LIKE ' + quotename(@parm1,'''') + ' 
			 AND CustOrdNbr LIKE ' + quotename(@parm2,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SOHeader.CustOrdNbr, SOHeader.CustID, SOHeader.OrdNbr, SOHeader.OrdDate, SOHeader.SOTypeID, SOHeader.Status, SOHeader.SlsperID
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SOHeader(nolock)
					WHERE CpnyID LIKE ' + quotename(@parm1,'''') + ' 
					AND CustOrdNbr LIKE ' + quotename(@parm2,'''') + ' 
				) 
				SELECT CustOrdNbr [Customer Order], CustID [Customer ID], OrdNbr [Order Nbr], OrdDate [Order Date], SOTypeID [Order Type], Status [Status], SlsperID [Salesperson]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

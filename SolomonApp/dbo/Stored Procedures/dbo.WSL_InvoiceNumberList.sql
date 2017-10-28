
CREATE PROCEDURE WSL_InvoiceNumberList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- CpnyID 
 ,@parm2 varchar (15) -- InvcNbr
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'InvcNbr, CustID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT SOShipHeader.InvcNbr [Invoice Nbr], SOShipHeader.CustID [Customer ID], SOShipHeader.OrdNbr [Order Nbr], SOShipHeader.OrdDate [Order Date], SOShipHeader.SOTypeID [Order Type], SOShipHeader.Status [Status], SOShipHeader.SlsperID [Salesperson]
			 FROM SOShipHeader(nolock)
			 WHERE CpnyID LIKE ' + quotename(@parm1,'''') + ' 
			 AND InvcNbr LIKE ' + quotename(@parm2,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SOShipHeader.InvcNbr, SOShipHeader.CustID, SOShipHeader.OrdNbr, SOShipHeader.OrdDate, SOShipHeader.SOTypeID, SOShipHeader.Status, SOShipHeader.SlsperID
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SOShipHeader(nolock)
					WHERE CpnyID LIKE ' + quotename(@parm1,'''') + ' 
					AND InvcNbr LIKE ' + quotename(@parm2,'''') + ' 
				) 
				SELECT InvcNbr [Invoice Nbr], CustID [Customer ID], OrdNbr [Order Nbr], OrdDate [Order Date], SOTypeID [Order Type], Status [Status], SlsperID [Salesperson]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

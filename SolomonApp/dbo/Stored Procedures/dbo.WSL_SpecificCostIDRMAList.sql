
CREATE PROCEDURE WSL_SpecificCostIDRMAList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@CpnyID varchar(10) -- 
 ,@ShipperID varchar(15) -- 
 ,@LineRef varchar(5) -- 
 ,@LotSerNbr varchar(25) -- 
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'LotSerNbr'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT SOShipLot.LotSerNbr [Lot Ser Nbr], SOShipLot.WhseLoc [Whse Bin Loc], SOShipLot.QtyShip [Qty Shipped]
			 FROM SOShipLot(nolock)
			 WHERE CpnyID = ' + quotename(@CpnyID,'''') + ' AND ShipperID = ' + quotename(@ShipperID,'''') + ' AND LineRef = ' + quotename(@LineRef,'''') + ' AND LotSerNbr LIKE ' + quotename(@LotSerNbr,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') SOShipLot.LotSerNbr, SOShipLot.WhseLoc, SOShipLot.QtyShip
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SOShipLot(nolock)
					WHERE CpnyID = ' + quotename(@CpnyID,'''') + ' AND ShipperID = ' + quotename(@ShipperID,'''') + ' AND LineRef = ' + quotename(@LineRef,'''') + ' AND LotSerNbr LIKE ' + quotename(@LotSerNbr,'''') + ' 
				) 
				SELECT LotSerNbr [Lot Ser Nbr], WhseLoc [Whse Bin Loc], QtyShip [Qty Shipped]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_SpecificCostIDRMAList] TO [MSDSL]
    AS [dbo];


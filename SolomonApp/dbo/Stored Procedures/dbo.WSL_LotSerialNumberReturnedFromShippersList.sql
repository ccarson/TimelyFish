
CREATE PROCEDURE WSL_LotSerialNumberReturnedFromShippersList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- CpnyID 
 ,@parm2 varchar (15) -- ShipperID
 ,@parm3 varchar (5) -- LineRef
 ,@parm4 varchar (25) -- LotSerNbr
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
			 WHERE CpnyID = ' + quotename(@parm1,'''') + '
			 AND ShipperID = ' + quotename(@parm2,'''') + '
			 AND LineRef = ' + quotename(@parm3,'''') + ' 
			 AND LotSerNbr LIKE ' + quotename(@parm4,'''') + ' 
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
					WHERE CpnyID = ' + quotename(@parm1,'''') + '
					AND ShipperID = ' + quotename(@parm2,'''') + '
					AND LineRef = ' + quotename(@parm3,'''') + ' 
					AND LotSerNbr LIKE ' + quotename(@parm4,'''') + ' 
				) 
				SELECT LotSerNbr [Lot Ser Nbr], WhseLoc [Whse Bin Loc], QtyShip [Qty Shipped]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

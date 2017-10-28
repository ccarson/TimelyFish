
CREATE PROCEDURE WSL_WarehouseBinLocationList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- InvtID  -- Location.InvtID
 ,@parm2 varchar (30) -- InvtID2 -- LocTable.InvtID
 ,@parm3 varchar (10) -- SiteID
 ,@parm4 varchar (10) -- WhseLoc
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'Location.QtyOnHand DESC, LocTable.WhseLoc'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT LocTable.WhseLoc [Whse Bin Loc], Location.QtyOnHand [Qty On Hand], Location.QtyShipNotInv [Qty Shipped Not Invoiced], Location.QtyAvail [Qty Available], Location.QtyAllocSO [Sales Order L/S Alloc], Location.QtyAlloc [On Open Shippers], Location.QtyShipNotInv [Qty Shipped Not Invoiced]
			 FROM LocTable(nolock)
			 LEFT OUTER JOIN Location ON LocTable.SiteID = Location.SiteID AND LocTable.WhseLoc = Location.WhseLoc AND Location.InvtID LIKE ' + quotename(@parm1,'''') + '
			 WHERE (LocTable.InvtIDValid = ''Y'' 
			 AND LocTable.InvtID LIKE ' + quotename(@parm2,'''') + ' 
			 OR LocTable.InvtIDValid <> ''Y'') 
			 AND LocTable.SalesValid <> ''N'' 
			 AND LocTable.SiteID LIKE ' + quotename(@parm3,'''') + ' 
			 AND LocTable.WhseLoc LIKE ' + quotename(@parm4,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') LocTable.WhseLoc, Location.QtyOnHand, Location.QtyShipNotInv, Location.QtyAvail, Location.QtyAllocSO, Location.QtyAlloc
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM LocTable(nolock)
				LEFT OUTER JOIN Location ON LocTable.SiteID = Location.SiteID AND LocTable.WhseLoc = Location.WhseLoc AND Location.InvtID LIKE ' + quotename(@parm1,'''') + '
					WHERE (LocTable.InvtIDValid = ''Y'' 
					AND LocTable.InvtID LIKE ' + quotename(@parm2,'''') + ' 
					OR LocTable.InvtIDValid <> ''Y'') 
					AND LocTable.SalesValid <> ''N'' 
					AND LocTable.SiteID LIKE ' + quotename(@parm3,'''') + ' 
					AND LocTable.WhseLoc LIKE ' + quotename(@parm4,'''') + ' 
				) 
				SELECT WhseLoc [Whse Bin Loc], QtyOnHand [Qty On Hand], QtyShipNotInv [Qty Shipped Not Invoiced], QtyAvail [Qty Available], QtyAllocSO [Sales Order L/S Alloc], QtyAlloc [On Open Shippers]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_WarehouseBinLocationList] TO [MSDSL]
    AS [dbo];


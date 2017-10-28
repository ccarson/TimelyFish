
CREATE PROCEDURE WSL_WarehouseBinLocationWhenReceivedReturnsList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- InvtID  -- LotSerMst.InvtID
 ,@parm2 varchar (30) -- InvtID2 -- LotSerMst.InvtID
 ,@parm3 varchar (10) -- SiteID
 ,@parm4 varchar (10) -- WhseLoc
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'LotSerMst.QtyOnHand desc, LocTable.WhseLoc'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT LocTable.WhseLoc [Whse Bin Loc], LotSerMst.LotSerNbr [Lot Serial Nbr], LotSerMst.QtyOnHand [Qty On Hand]
			 FROM LotSerMst(nolock)
			 left outer join LocTable on LocTable.SiteID = LotSerMst.SiteID AND LocTable.WhseLoc = LotSerMst.WhseLoc
			 WHERE (LotSerMst.InvtID = ' + quotename(@parm1,'''') + ' 
			 AND LotSerMst.InvtID = ' + quotename(@parm2,'''') + ') 
			 AND LocTable.SiteID LIKE ' + quotename(@parm3,'''') + ' 
			 AND LocTable.WhseLoc LIKE ' + quotename(@parm4,'''') + ' 
			 AND LotSerMst.LotSerNbr = '''' 
			 AND LocTable.ReceiptsValid <> ''N'' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') LocTable.WhseLoc, LotSerMst.LotSerNbr, LotSerMst.QtyOnHand
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM LotSerMst(nolock)
				left outer join LocTable on LocTable.SiteID = LotSerMst.SiteID AND LocTable.WhseLoc = LotSerMst.WhseLoc
					WHERE (LotSerMst.InvtID = ' + quotename(@parm1,'''') + ' 
					AND LotSerMst.InvtID = ' + quotename(@parm2,'''') + ') 
					AND LocTable.SiteID LIKE ' + quotename(@parm3,'''') + ' 
					AND LocTable.WhseLoc LIKE ' + quotename(@parm4,'''') + ' 
					AND LotSerMst.LotSerNbr = '''' 
					AND LocTable.ReceiptsValid <> ''N'' 
				) 
				SELECT WhseLoc [Whse Bin Loc], LotSerNbr [Lot Serial Nbr], QtyOnHand [Qty On Hand]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_WarehouseBinLocationWhenReceivedReturnsList] TO [MSDSL]
    AS [dbo];


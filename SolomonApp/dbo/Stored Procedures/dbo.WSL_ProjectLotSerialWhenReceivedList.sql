
CREATE PROCEDURE WSL_ProjectLotSerialWhenReceivedList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- InvtID 
 ,@parm2 varchar (10) -- SiteID
 ,@parm3 varchar (25) -- LotSerNbr
 ,@parm4 varchar (16) -- Projectid
 ,@parm5 varchar (32) -- TaskID
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'LotSerMst.LotSerNbr'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT LotSerMst.LotSerNbr [Lot Ser Nbr], LotSerMst.WhseLoc [Whse Bin Loc], LotSerMst.QtyAvail [Qty Available], v_plot.qty [Project Qty Allocated], LotSerMst.QtyOnHand [Qty On Hand], LotSerMst.QtyAllocSO [Sales Order L/S Alloc], LotSerMst.QtyAlloc [On Open Shippers], LotSerMst.QtyShipNotInv [Qty Shipped Not Invoiced], LotSerMst.ExpDate [Exp Date]
			 FROM LotSerMst(nolock)
			 INNER JOIN LocTable l on l.SiteID=LotSerMst.SiteID and l.WhseLoc=LotSerMst.WhseLoc Left Join v_plot ON LotSerMst.InvtiD=v_plot.InvtId AND LotSerMst.SiteId=v_plot.SiteID AND LotSerMst.WhseLoc=v_plot.WhseLoc AND LotSerMst.LotSerNbr=v_plot.LotSerNbr AND v_plot.Projectid=' + quotename(@parm4,'''') + ' AND v_plot.TaskID=' + quotename(@parm5,'''') + '
			 WHERE LotSerMst.InvtID LIKE ' + quotename(@parm1,'''') + ' 
			 AND LotSerMst.SiteID LIKE ' + quotename(@parm2,'''') + ' 
			 AND l.SalesValid <> ''N'' 
			 AND LotSerMst.LotSerNbr LIKE ' + quotename(@parm3,'''') + ' 
			 AND LotSerMst.LotSerNbr <> ''*'' 
			 AND LotSerMst.Status=''A'' 
			 AND (LotSerMst.QtyAvail + IsNull(v_plot.qty,0)) > 0 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') LotSerMst.LotSerNbr, LotSerMst.WhseLoc, LotSerMst.QtyAvail, v_plot.qty, LotSerMst.QtyOnHand, LotSerMst.QtyAllocSO, LotSerMst.QtyAlloc, LotSerMst.QtyShipNotInv, LotSerMst.ExpDate
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM LotSerMst(nolock)
				INNER JOIN LocTable l on l.SiteID=LotSerMst.SiteID and l.WhseLoc=LotSerMst.WhseLoc Left Join v_plot ON LotSerMst.InvtiD=v_plot.InvtId AND LotSerMst.SiteId=v_plot.SiteID AND LotSerMst.WhseLoc=v_plot.WhseLoc AND LotSerMst.LotSerNbr=v_plot.LotSerNbr AND v_plot.Projectid=' + quotename(@parm4,'''') + ' AND v_plot.TaskID=' + quotename(@parm5,'''') + '
					WHERE LotSerMst.InvtID LIKE ' + quotename(@parm1,'''') + ' 
					AND LotSerMst.SiteID LIKE ' + quotename(@parm2,'''') + ' 
					AND l.SalesValid <> ''N'' 
					AND LotSerMst.LotSerNbr LIKE ' + quotename(@parm3,'''') + ' 
					AND LotSerMst.LotSerNbr <> ''*'' 
					AND LotSerMst.Status=''A'' 
					AND (LotSerMst.QtyAvail + IsNull(v_plot.qty,0)) > 0 
				) 
				SELECT LotSerNbr [Lot Ser Nbr], WhseLoc [Whse Bin Loc], QtyAvail [Qty Available], qty [Project Qty Allocated], QtyOnHand [Qty On Hand], QtyAllocSO [Sales Order L/S Alloc], QtyAlloc [On Open Shippers], QtyShipNotInv [Qty Shipped Not Invoiced], ExpDate [Exp Date]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectLotSerialWhenReceivedList] TO [MSDSL]
    AS [dbo];


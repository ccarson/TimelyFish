
CREATE PROCEDURE WSL_WarehouseBinLocationReturnsList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- InvtID -- Location.InvtID
 ,@parm2 varchar (30) -- InvtID2 -- LocTable.InvtID
 ,@parm3 varchar (10) -- SiteID
 ,@parm4 varchar (10) -- WhseLoc
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'Location.QtyOnHand desc, LocTable.WhseLoc'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT LocTable.WhseLoc [Whse Bin Loc], Location.QtyOnHand [Qty On Hand]
			 FROM LocTable(nolock) 
			 Left outer join Location on LocTable.SiteID = Location.SiteID and LocTable.WhseLoc = Location.WhseLoc
			 WHERE Location.InvtID = ' + quotename(@parm1,'''') + ' 
			 AND (LocTable.InvtIDValid = ''Y'' 
			 AND LocTable.InvtID = ' + quotename(@parm2,'''') + ' 
			 OR LocTable.InvtIDValid <> ''Y'') 
			 AND LocTable.SiteID LIKE ' + quotename(@parm3,'''') + ' 
			 AND LocTable.WhseLoc LIKE ' + quotename(@parm4,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') LocTable.WhseLoc, Location.QtyOnHand
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM LocTable(nolock) 
				Left outer join Location on LocTable.SiteID = Location.SiteID and LocTable.WhseLoc = Location.WhseLoc
					WHERE Location.InvtID = ' + quotename(@parm1,'''') + ' 
					AND (LocTable.InvtIDValid = ''Y'' 
					AND LocTable.InvtID = ' + quotename(@parm2,'''') + ' 
					OR LocTable.InvtIDValid <> ''Y'') 
					AND LocTable.SiteID LIKE ' + quotename(@parm3,'''') + ' 
					AND LocTable.WhseLoc LIKE ' + quotename(@parm4,'''') + ' 
					AND LocTable.ReceiptsValid <> ''N'' 
				) 
				SELECT WhseLoc [Whse Bin Loc], QtyOnHand [Qty On Hand]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_WarehouseBinLocationReturnsList] TO [MSDSL]
    AS [dbo];


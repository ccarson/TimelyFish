
CREATE PROCEDURE WSL_InventoryList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- InvtId
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'InvtId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Inventory.InvtId [Item ID], Inventory.Descr [Description], Inventory.TranstatusCode [Status], Inventory.CustomFtr [Custom Item]
			 FROM Inventory(nolock)
			 where InvtId LIKE ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Inventory.InvtId, Inventory.Descr, Inventory.TranstatusCode, Inventory.CustomFtr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Inventory(nolock)
					where InvtId LIKE ' + quotename(@parm1,'''') + ' 
				) 
				SELECT InvtId [Item ID], Descr [Description], TranstatusCode [Status], CustomFtr [Custom Item]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

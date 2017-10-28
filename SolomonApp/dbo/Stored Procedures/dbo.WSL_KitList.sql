
CREATE PROCEDURE WSL_KitList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- KitID 
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'KitID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Kit.KitID [Kit ID], Kit.Descr [Description]
			 FROM Kit(nolock),Inventory(nolock)
			 where Kit.KitID = Inventory.InvtID 
			 AND Kit.KitID LIKE ' + quotename(@parm1,'''') + ' 
			 AND Kit.Status = ''A'' 
			 AND Kit.KitType <> ''B'' 
			 AND Inventory.TranStatusCode in (''AC'',''NP'',''OH'',''NU'') 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Kit.KitID, Kit.Descr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Kit(nolock),Inventory(nolock)
					where Kit.KitID = Inventory.InvtID 
					AND Kit.KitID LIKE ' + quotename(@parm1,'''') + ' 
					AND Kit.Status = ''A'' 
					AND Kit.KitType <> ''B'' 
					AND Inventory.TranStatusCode in (''AC'',''NP'',''OH'',''NU'') 
				) 
				SELECT KitID [Kit ID], Descr [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


CREATE PROCEDURE WSL_SalesOrderInventoryList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@InvtID varchar (30) -- InvtID 
 ,@SOTypeID varchar(4)
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @INInstalled int,
    @Behavior varchar(4)
    
    IF @sort = '' SET @sort = 'InvtID'
    
    SET @INInstalled = (SELECT count(*) FROM INSetup WITH(NOLOCK) WHERE Init = 1)
	SET @Behavior = (SELECT sotype.Behavior from SOType WITH(NOLOCK) WHERE sotype.SOTypeID = QUOTENAME(@SOTypeID,''''))
  IF @page = 0  -- Don't do paging
	  BEGIN
		 	SET @STMT = 
			'SELECT Inventory.InvtID [Item ID], Inventory.Descr [Description], Inventory.TranstatusCode [Status]'
			IF @INInstalled > 0
			BEGIN
				SET @STMT = @STMT + ', Inventory.CustomFtr [Custom Item]'
			END
			SET @STMT = @STMT + 
			'FROM Inventory(nolock)
			 Where InvtID LIKE ' + quotename(@InvtID,'''') + ' AND TranStatusCode in (''AC'',''NP'''
			 IF @INInstalled > 0
			 BEGIN
				SET @STMT = @STMT + ',''OH'''
			 END
			 IF @Behavior = 'TR'
			 BEGIN
				SET @STMT = @STMT + ',''NU'''
			 END
			 SET @STMT = @STMT + ') 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Inventory.InvtID, Inventory.Descr, Inventory.TranstatusCode, Inventory.CustomFtr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Inventory(nolock)
					Where InvtID LIKE ' + quotename(@InvtID,'''') + ' AND TranStatusCode in (''AC'',''NP'''
					IF @INInstalled > 0
					BEGIN
						SET @STMT = @STMT + ',''OH'''
					END
					IF @Behavior = 'TR'
					BEGIN
						SET @STMT = @STMT + ',''NU'''
					END
					SET @STMT = @STMT + ')  
				) 
				SELECT InvtID [Item ID], Descr [Description], TranstatusCode [Status]'
				IF @INInstalled > 0
				BEGIN
					SET @STMT = @STMT + ', CustomFtr [Custom Item]'
				END
				SET @STMT = @STMT +
				'FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row' 

	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_SalesOrderInventoryList] TO [MSDSL]
    AS [dbo];


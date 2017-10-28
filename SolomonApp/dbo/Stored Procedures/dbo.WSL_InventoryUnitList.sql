
CREATE PROCEDURE WSL_InventoryUnitList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar(6) -- ClassId
 ,@parm2 varchar(6) -- ToUnit
 ,@parm3 varchar(30) -- InvtID
 ,@parm4 varchar(6) -- FromUnit
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'UnitType, ClassId, InvtID, FromUnit, ToUnit'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT INUnit.FromUnit [Unit], INUnit.ClassId [Class Id], INUnit.InvtID [Inventory Id]
			 FROM INUnit(nolock)
			 where ( ClassId = ''*'' OR ClassId = ' + quotename(@parm1,'''') + ' ) AND ToUnit = ' + quotename(@parm2,'''') + ' AND ( InvtID = ''*'' OR InvtID = ' + quotename(@parm3,'''') + ' ) AND FromUnit LIKE ' + quotename(@parm4,'''') + '         
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') INUnit.FromUnit, INUnit.ClassId, INUnit.InvtID
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM INUnit(nolock)
					where ( ClassId = ''*'' OR ClassId = ' + quotename(@parm1,'''') + ' ) AND ToUnit = ' + quotename(@parm2,'''') + ' AND ( InvtID = ''*'' OR InvtID = ' + quotename(@parm3,'''') + ' ) AND FromUnit LIKE ' + quotename(@parm4,'''') + '         
				) 
				SELECT FromUnit [Unit], ClassId [Class Id], InvtID [Inventory Id]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

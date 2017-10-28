
CREATE PROCEDURE WSL_EntityItemCrossReferenceList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (15) -- EntityID
 ,@parm2 varchar (1) -- AltIDType
 ,@parm3 varchar (30) -- AlternateID
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'InvtID, AltIDType, AlternateID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT ItemXRef.AlternateID [Alternate Item ID], ItemXRef.InvtID [Inventory ID], ItemXRef.EntityID [Entity ID], ItemXRef.AltIDType [Type], ItemXRef.Descr [Alternate Description]
			 FROM ItemXRef(nolock)
			 where ((EntityID = ' + quotename(@parm1,'''') + ' 
			 and AltIDType = ' + quotename(@parm2,'''') + ')
			 or AltIDType Not In (''C'', ''V''))
			 and AlternateID LIKE ' + QUOTENAME(@parm3,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') ItemXRef.AlternateID, ItemXRef.InvtID, ItemXRef.EntityID, ItemXRef.AltIDType, ItemXRef.Descr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM ItemXRef(nolock)
					where ((EntityID = ' + quotename(@parm1,'''') + ' 
					and AltIDType = ' + quotename(@parm2,'''') + ')
					or AltIDType Not In (''C'', ''V''))
					and AlternateID LIKE ' + QUOTENAME(@parm3,'''') + '
				) 
				SELECT AlternateID [Alternate Item ID], InvtID [Inventory ID], EntityID [Entity ID], AltIDType [Type], Descr [Alternate Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

CREATE PROCEDURE WSL_ShipViaList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (15) -- ShipViaId
 ,@parm2 varchar (10) -- CpnyID
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CpnyID, ShipViaID'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT ShipViaID [Ship Via], Descr [Description]
			 FROM ShipVia (nolock)
			 WHERE CpnyID LIKE ' + quotename(@parm2,'''') + ' 
			 AND ShipViaID LIKE ' + quotename(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') ShipViaID, Descr,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM ShipVia (nolock)
				WHERE CpnyID LIKE ' + quotename(@parm2,'''') + '
				AND ShipViaID LIKE ' + quotename(@parm1,'''') + '
				) 
				SELECT ShipViaID [Ship Via], Descr [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

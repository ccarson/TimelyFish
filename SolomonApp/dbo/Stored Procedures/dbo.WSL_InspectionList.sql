
CREATE PROCEDURE WSL_InspectionList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- InvtID 
 ,@parm2 varchar (2) -- InspID
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'InvtID, InspID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Inspection.InspID [Inspection ID],  Inspection.Descr [Description]
			 FROM Inspection(nolock)
			 WHERE InvtID LIKE ' + quotename(@parm1,'''') + ' 
			 AND InspID LIKE ' + quotename(@parm2,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Inspection.InspID, Inspection.Descr

				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Inspection(nolock)
					WHERE InvtID LIKE ' + quotename(@parm1,'''') + ' 
					 AND InspID LIKE ' + quotename(@parm2,'''') + '
				) 
				SELECT InspID [Inspection ID], Descr [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

CREATE PROCEDURE WSL_BudgetRevisionList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
 ,@parm2 varchar (4) -- Revision ID
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'project, revid desc'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT project [ProjectId], revid [Revision], status [Status], Revision_Desc [Revision Description], Change_Order_Num [Change Order Number]
			 FROM PJREVHDR (nolock)
			 where project = ' + quotename(@parm1,'''') + '
			  and  revid like ' + quotename(@parm2,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') project, revid, status, Revision_Desc, Change_Order_Num  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJREVHDR (nolock)
				 where project = ' + quotename(@parm1,'''') + '
				  and  revid like ' + quotename(@parm2,'''') + '
				) 
				SELECT project [ProjectId], revid [Revision], status [Status], Revision_Desc [Revision Description], Change_Order_Num [Change Order Number]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

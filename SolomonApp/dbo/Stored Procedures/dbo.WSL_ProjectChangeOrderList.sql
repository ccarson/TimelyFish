CREATE PROCEDURE WSL_ProjectChangeOrderList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
 ,@parm2 varchar (16) -- Change Order Number
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
  IF @sort = '' SET @sort = 'project, change_order_num'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT change_order_num [Change Order Number], status1 [Status], co_desc [Description]
			 FROM PJCOPROJ (nolock)
			 where project = ' + quotename(@parm1,'''') + '
			  and  change_order_num like ' + quotename(@parm2,'''') + '
			  and (status1 = ''I'' or status1 = ''P'')
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') change_order_num, status1, co_desc  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				 FROM PJCOPROJ (nolock)
				 where project = ' + quotename(@parm1,'''') + '
				  and  change_order_num like ' + quotename(@parm2,'''') + '
				  and (status1 = ''I'' or status1 = ''P'')
				) 
				SELECT change_order_num [Change Order Number], status1 [Status], co_desc [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


CREATE PROCEDURE WSL_ProjectSubtaskList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- project
 ,@parm2 varchar (32) -- pjt_entity
 ,@parm3 varchar (10) -- employee
 ,@parm4 varchar (50) -- subtask_name
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'PJPENTEM.SubTask_Name'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT subtask_name [SubTask]
			 FROM PJPENTEM(nolock)
			 where Project LIKE ' + quotename(@parm1,'''') + ' 
			  and  Pjt_entity LIKE ' + quotename(@parm2,'''') + '
			  and  Employee LIKE ' + quotename(@parm3,'''') + ' 
			  and  SubTask_Name LIKE ' + quotename(@parm4,'''') + '  
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') subtask_name
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJPENTEM(nolock)
					where Project LIKE ' + quotename(@parm1,'''') + ' 
					 and  Pjt_entity LIKE ' + quotename(@parm2,'''') + '
					 and  Employee LIKE ' + quotename(@parm3,'''') + ' 
					 and  SubTask_Name LIKE ' + quotename(@parm4,'''') + ' 
				) 
				SELECT subtask_name [SubTask]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectSubtaskList] TO [MSDSL]
    AS [dbo];


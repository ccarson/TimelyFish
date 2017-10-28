CREATE PROCEDURE WSL_TaskList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project 
 ,@parm2 varchar (32) -- Task
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int

    IF @sort = '' SET @sort = 'project, pjt_entity'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT pjt_entity [Task], pjt_entity_desc [Description]
			 FROM PJPENT (nolock)
			 WHERE project LIKE ' + quotename(@parm1,'''') + '
			   AND pjt_entity LIKE ' + quotename(@parm2,'''') + '  
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') pjt_entity, pjt_entity_desc
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJPENT (nolock)
				WHERE project LIKE ' + quotename(@parm1,'''') + '
			      AND pjt_entity LIKE ' + quotename(@parm2,'''') + '  
				) 
				SELECT pjt_entity [Task], pjt_entity_desc [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

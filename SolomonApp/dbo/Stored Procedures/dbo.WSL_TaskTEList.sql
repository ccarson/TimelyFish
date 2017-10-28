
CREATE PROCEDURE WSL_TaskTEList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
 ,@parm2 varchar (10) -- Employee 
 ,@parm3 varchar (34) -- Task, with % before and after
 ,@parm4 varchar (60) -- Task Description
 -- @parm2 only used if project is set to only
 -- let assigned employees charge to the project
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int,
	@AllTasks int,
    @whereExpression nvarchar(180)

	-- If the length is 0, we want to do the equivalent of pjpent_spk7
	-- If it is more than 0, we want to do the equivalent of PJvETASK_sMSPTskT
	set @AllTasks = (select len(status_18) from PJPROJ where project = @parm1)
	
	SET @whereExpression = ''

	IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
		SET @whereExpression = @whereExpression + ' AND pjt_entity LIKE ' + QUOTENAME(@parm3, '''');
    IF @parm4 IS NOT NULL AND LEN(@parm4) > 0
		SET @whereExpression = @whereExpression + ' AND pjt_entity_desc LIKE ' + QUOTENAME(@parm4, '''');

    IF @sort = ''
	BEGIN
		IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'project, pjt_entity'
		ELSE IF @parm4 IS NOT NULL AND LEN(@parm4) > 1 SET @sort = 'project, pjt_entity_desc'
		ELSE SET @sort = 'project, pjt_entity'	
	END

	IF @sort = 'Task' SET @sort = 'pjt_entity'
	ELSE IF @sort = 'Description' SET @sort = 'pjt_entity_desc'	
	 
	
  IF @page = 0  -- Don't do paging
	  BEGIN
	    IF @AllTasks = 0
		  BEGIN
			SET @STMT = 
				'SELECT pjt_entity [Task], pjt_entity_desc [Description]
				FROM PJPENT (nolock)
				WHERE project LIKE ' + quotename(@parm1,'''') +
				@whereExpression + '
				AND status_pa = ''A'' AND status_lb = ''A''
				ORDER BY ' + @sort
		  END
		ELSE
		  BEGIN
			SET @STMT = 
				'SELECT pjt_entity [Task], pjt_entity_desc [Description]
				FROM PJvETASK (nolock)
				WHERE project LIKE ' + quotename(@parm1, '''') + '
				AND status_pa = ''A'' AND status_lb = ''A''
				AND employee LIKE ' + quotename(@parm2, '''') + 
				@whereExpression + '
				ORDER BY ' + @sort
		  END
	  END		 
  ELSE
	  BEGIN
			IF @page < 1 SET @page = 1
			IF @size < 1 SET @size = 1
			SET @lbound = (@page-1) * @size
			SET @ubound = @page * @size + 1
			IF @AllTasks = 0
			  BEGIN
				SET @STMT = 
					'WITH PagingCTE AS
					(
					SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') pjt_entity, pjt_entity_desc
					,ROW_NUMBER() OVER(
					ORDER BY ' + @sort + ') AS row
					FROM PJPENT (nolock)
					WHERE project LIKE ' + quotename(@parm1,'''') + 
					@whereExpression + '  
					  AND status_pa = ''A'' AND status_lb = ''A''
					) 
					SELECT pjt_entity [Task], pjt_entity_desc [Description]
					FROM PagingCTE                     
					WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
						row <  ' + CONVERT(varchar(9), @ubound) + '
					ORDER BY row'
			  END
			ELSE
			  BEGIN
				SET @STMT = 
					'WITH PagingCTE AS
					(
					SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') pjt_entity, pjt_entity_desc
					,ROW_NUMBER() OVER(
					ORDER BY ' + @sort + ') AS row
					FROM PJvETASK (nolock)
					WHERE project LIKE ' + quotename(@parm1, '''') + '
					AND status_pa = ''A'' AND status_lb = ''A''
					AND employee LIKE ' + quotename(@parm2, '''') + 
					@whereExpression + '
					)
					SELECT pjt_entity [Task], pjt_entity_desc [Description]
					FROM PagingCTE
					WHERE row > ' + CONVERT(varchar(9), @lbound) + ' AND
						row < ' + CONVERT(varchar(9), @ubound) + '
					ORDER BY row'
			  END
		END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TaskTEList] TO [MSDSL]
    AS [dbo];


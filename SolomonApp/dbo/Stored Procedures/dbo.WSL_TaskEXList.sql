
CREATE PROCEDURE WSL_TaskEXList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
 ,@parm2 varchar (10) -- Employee
 ,@parm3 varchar (34) -- Task, with % before and after
 ,@parm4 varchar (60) -- Task Description

AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int,
	@AllTasks int,
	@APSet nvarchar(1),
    @whereExpression nvarchar(180)


	set @AllTasks = (select len(status_18) from PJPROJ where project = @parm1)
	set @APSet = (SELECT SUBSTRING(PJCONTRL.control_data,103,1) FROM PJCONTRL where PJCONTRL.control_code = 'SETUP' and PJCONTRL.control_type = 'TE')

	SET @whereExpression = ''

	IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
		SET @whereExpression = @whereExpression + ' AND pjt_entity LIKE ' + QUOTENAME(@parm3, '''');
    IF @parm4 IS NOT NULL AND LEN(@parm4) > 0
		SET @whereExpression = @whereExpression + ' AND pjt_entity_desc LIKE ' + QUOTENAME(@parm4, '''');
	IF @APSet = 'Y' 
		SET @whereExpression = @whereExpression + ' AND status_ap = ''A'' '

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
				'SELECT project [Project], pjt_entity [Task], pjt_entity_desc [Description]
				FROM pjpent (nolock)
				WHERE project LIKE ' + quotename(@parm1,'''') + '
				AND status_pa = ''A'' ' +
				@whereExpression +
				'ORDER BY ' + @sort
		  END
		ELSE
		  BEGIN
			SET @STMT = 
				'SELECT project [Project], pjt_entity [Task], pjt_entity_desc [Description]
				FROM PJvETASK (nolock)
				WHERE project LIKE ' + quotename(@parm1, '''') + '
				AND status_pa = ''A'' AND employee LIKE ' + quotename(@parm2, '''') +
				@whereExpression +
				'ORDER BY ' + @sort
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
					SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') project, pjt_entity, pjt_entity_desc
					,ROW_NUMBER() OVER(
					ORDER BY ' + @sort + ') AS row
					FROM pjpent (nolock)
					WHERE project LIKE ' + quotename(@parm1,'''') + '
				      AND status_pa = ''A'' ' +
					  @whereExpression +
					') 
					SELECT project [Project], pjt_entity [Task], pjt_entity_desc [Description]
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
					SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') project, pjt_entity, pjt_entity_desc
					,ROW_NUMBER() OVER(
					ORDER BY ' + @sort + ') AS row
					FROM PJvETASK (nolock)
					WHERE project LIKE ' + quotename(@parm1, '''') + '
					AND status_pa = ''A'' AND employee LIKE ' + quotename(@parm2, '''') +
					@whereExpression +
					')
					SELECT project [Project], pjt_entity [Task], pjt_entity_desc [Description]
					FROM PagingCTE
					WHERE row > ' + CONVERT(varchar(9), @lbound) + ' AND
						row < ' + CONVERT(varchar(9), @ubound) + '
					ORDER BY row'
			  END
		END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_TaskEXList] TO [MSDSL]
    AS [dbo];


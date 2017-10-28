
CREATE PROCEDURE [dbo].[WSL_ProjectMaintTaskList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (18) -- Project 
 ,@parm2 varchar (34) -- Task (pjt_entity)
 ,@parm3 varchar (62) -- Description
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int,
	@pjt_entityAlias varchar (10) = 'Task',
	@pjt_entity_descAlias varchar (15) = 'Description',
    @whereExpression nvarchar(120)
    
    SET @whereExpression = ''

       IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND PJPENT.pjt_entity_desc LIKE ' + QUOTENAME(@parm3, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'PJPENT.project'
			  ELSE IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'PJPENT.pjt_entity'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'PJPENT.pjt_entity_desc'
              ELSE SET @sort = 'PJPENT.project, PJPENT.pjt_entity'
       END
	   ELSE
	   BEGIN
			  IF @sort = @pjt_entityAlias SET @sort = 'PJPENT.pjt_entity'
			  ELSE IF @sort = @pjt_entity_descAlias SET @sort = 'PJPENT.pjt_entity_desc'
	   END
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT pjt_entity [' + @pjt_entityAlias + '], pjt_entity_desc [' + @pjt_entity_descAlias + ']
			 FROM PJPENT (nolock)
			 WHERE project LIKE ' + quotename(@parm1,'''') + '
			   AND pjt_entity LIKE ' + quotename(@parm2,'''') + @whereExpression + '  
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
			      AND pjt_entity LIKE ' + quotename(@parm2,'''') + @whereExpression + '  
				) 
				SELECT pjt_entity [' + @pjt_entityAlias + '], pjt_entity_desc [' + @pjt_entity_descAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintTaskList] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE WSL_LaborProjectTaskList
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
    
    IF @sort = '' SET @sort = 'PJPENT.project, PJPENT.pjt_entity'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
          'SELECT PJPENT.pjt_entity [Task], PJPENT.pjt_entity_desc [Description]				     
			 FROM PJPENT (nolock)
            WHERE PJPENT.project = ' + quotename(@parm1,'''') + '
              AND PJPENT.pjt_entity like ' + quotename(@parm2,'''') + ' 
              AND PJPENT.status_pa = ''A'' 
              AND PJPENT.status_lb = ''A'' 
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
                 SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') 
                           PJPENT.pjt_entity, PJPENT.pjt_entity_desc               
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
			       FROM PJPENT (nolock)
                  WHERE PJPENT.project = ' + quotename(@parm1,'''') + '
                    AND PJPENT.pjt_entity like ' + quotename(@parm2,'''') + ' 
                    AND PJPENT.status_pa = ''A'' 
                    AND PJPENT.status_lb = ''A''  
				) 
				SELECT pjt_entity [Task], pjt_entity_desc [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_LaborProjectTaskList] TO [MSDSL]
    AS [dbo];


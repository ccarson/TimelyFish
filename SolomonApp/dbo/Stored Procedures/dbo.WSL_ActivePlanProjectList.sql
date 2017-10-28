
CREATE PROCEDURE WSL_ActivePlanProjectList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- project 
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int

    IF @sort = '' SET @sort = 'project'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT project [Project], project_desc [Description], customer [Customer], cpnyid [Company]
			 FROM PJPROJ (nolock)
			 WHERE project LIKE ' + quotename(@parm1,'''') + '
			   and (status_pa = ''A'' or status_pa = ''M'')  
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') project, project_desc, customer, cpnyid
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				 FROM PJPROJ (nolock)
				 WHERE project LIKE ' + quotename(@parm1,'''') + '
				   and (status_pa = ''A'' or status_pa = ''M'')  
				) 
				SELECT project [Project], project_desc [Description], customer [Customer], cpnyid [Company]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

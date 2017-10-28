
CREATE PROCEDURE WSL_EmployeeProjectList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- employee
 ,@parm2 varchar (16) -- project
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'pjproj.project'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT pjproj.project [Project], project_desc [Description], customer [Customer], cpnyid [Company]
			 FROM PJPROJ (nolock), PJPROJEM (nolock)
			 where pjproj.project = pjprojem.project
			  and  (pjprojem.employee = ' + quotename(@parm1,'''') + ' or pjprojem.employee = ''*'')
			  and  pjproj.project like ' +quotename(@parm2,'''') + '
			  and  pjproj.status_pa = ''A''
			  and  pjproj.status_ap = ''A''
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') pjproj.project, project_desc, customer, cpnyid 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJPROJ (nolock),PJPROJEM (nolock)
					where pjproj.project = pjprojem.project
			  		and  (pjprojem.employee = ' + quotename(@parm1,'''') + ' or pjprojem.employee = ''*'')
			  		and  pjproj.project like ' +quotename(@parm2,'''') + '
			  		and  pjproj.status_pa = ''A''
			  		and  pjproj.status_ap = ''A''
				) 
				SELECT project [Project], project_desc [Description], customer [Customer], cpnyid [Company]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_EmployeeProjectList] TO [MSDSL]
    AS [dbo];


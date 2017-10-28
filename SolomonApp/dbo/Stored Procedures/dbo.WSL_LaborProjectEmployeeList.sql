
CREATE PROCEDURE WSL_LaborProjectEmployeeList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Employee
 ,@parm2 varchar (16) -- Project

AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'PJPROJ.project'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
          'SELECT PJPROJ.project [Project #], PJPROJ.project_desc [Description], 
                  PJPROJ.customer [Customer #], PJPROJ.cpnyid [Company]				     
			 FROM PJPROJ (nolock), PJPROJEM (nolock)
            WHERE PJPROJ.project = PJPROJEM.project 
              AND (PJPROJEM.employee = ' + quotename(@parm1,'''') + ' or PJPROJEM.employee = ''*'') 
              AND PJPROJ.project like ' + quotename(@parm2,'''') + ' 
              AND PJPROJ.status_pa = ''A'' 
              AND PJPROJ.status_LB = ''A'' 
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
                 SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') PJPROJ.project, 
                 PJPROJ.project_desc, PJPROJ.customer, PJPROJ.cpnyid                   
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
			     FROM PJPROJ (nolock), PJPROJEM (nolock)
                WHERE PJPROJ.project = PJPROJEM.project 
                  AND (PJPROJEM.employee = ' + quotename(@parm1,'''') + ' or PJPROJEM.employee = ''*'') 
                  AND PJPROJ.project like ' + quotename(@parm2,'''') + ' 
                  AND PJPROJ.status_pa = ''A'' 
                  AND PJPROJ.status_LB = ''A'' 
				) 
				SELECT project [Project #], project_desc [Description], 
                       customer [Customer #], cpnyid [Company]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_LaborProjectEmployeeList] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE WSL_ActiveProjectEmployeeList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- project
 ,@parm2 varchar (10) -- employee

AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'PJEMPLOY.employee'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
          'SELECT PJEMPLOY.employee [Employee Num],
                  CASE WHEN CHARINDEX(''~'', emp_name) > 0 THEN LTRIM(RIGHT(RTRIM(PJEMPLOY.emp_name), LEN(PJEMPLOY.emp_name) - CHARINDEX(''~'', PJEMPLOY.emp_name))) + '' '' + SUBSTRING(PJEMPLOY.emp_name, 1, (CHARINDEX(''~'', PJEMPLOY.emp_name) - 1))
                       ELSE PJEMPLOY.emp_name
				  END [Name],
                  PJEMPLOY.cpnyid [Company], PJEMPLOY.gl_subacct [GL Subaccount]				     
			 FROM PJEMPLOY (nolock), PJPROJEM (nolock)
            WHERE PJPROJEM.project = ' + quotename(@parm1,'''') + '
              AND (PJEMPLOY.employee = PJPROJEM.employee or PJPROJEM.employee = ''*'') 
              AND PJEMPLOY.employee like ' + quotename(@parm2,'''') + ' 
              AND PJEMPLOY.emp_status = ''A'' 
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
                 SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') PJEMPLOY.employee, 
                 emp_name = CASE WHEN CHARINDEX(''~'', emp_name) > 0 THEN LTRIM(RIGHT(RTRIM(PJEMPLOY.emp_name), LEN(PJEMPLOY.emp_name) - CHARINDEX(''~'', PJEMPLOY.emp_name))) + '' '' + SUBSTRING(PJEMPLOY.emp_name, 1, (CHARINDEX(''~'', PJEMPLOY.emp_name) - 1))
                                 ELSE PJEMPLOY.emp_name
				                  END,
				 PJEMPLOY.cpnyid, PJEMPLOY.gl_subacct                 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
			       FROM PJEMPLOY (nolock), PJPROJEM (nolock)
                  WHERE PJPROJEM.project = ' + quotename(@parm1,'''') + '
                    AND (PJEMPLOY.employee = PJPROJEM.employee or PJPROJEM.employee = ''*'') 
                    AND PJEMPLOY.employee like ' + quotename(@parm2,'''') + ' 
                    AND PJEMPLOY.emp_status = ''A'' 
				) 
				SELECT employee [Employee Num], emp_name [Name], cpnyid [Company], gl_subacct [GL Subaccount]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ActiveProjectEmployeeList] TO [MSDSL]
    AS [dbo];


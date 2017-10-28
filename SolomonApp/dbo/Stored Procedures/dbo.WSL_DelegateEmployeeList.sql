CREATE PROCEDURE WSL_DelegateEmployeeList
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Employee, with % before and after
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'employee'
		  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  Employee,  
				 CASE
					  WHEN CHARINDEX(''~'', emp_name) > 0 THEN LTRIM(RIGHT(RTRIM(emp_name), LEN(emp_name) - CHARINDEX(''~'', emp_name))) + '' '' + SUBSTRING(emp_name, 1, (CHARINDEX(''~'', emp_name) - 1))
					  ELSE emp_name
				 END [Name],
			 cpnyid [Company], projExec [Executive Flag], Manager1 [Supervisor], Manager2 [Manager]
			 FROM PJEmploy (nolock)
			 where employee like ' + quotename(@parm1,'''') + '
			   and emp_status = ''A'' 
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
				Employee, 
				emp_name = 
					 CASE 
						  WHEN CHARINDEX(''~'', emp_name) > 0 THEN LTRIM(RIGHT(RTRIM(emp_name), LEN(emp_name) - CHARINDEX(''~'', emp_name))) + '' '' + SUBSTRING(emp_name, 1, (CHARINDEX(''~'', emp_name) - 1))
						  ELSE emp_name
					 END, 
				cpnyid, 
				projExec,
				manager1,
				manager2,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJEmploy (nolock)
				WHERE employee like ' + quotename(@parm1,'''') + '
	              and emp_status = ''A'' 
				) 
				SELECT  Employee, emp_name [Name], cpnyid [Company], projExec [Executive Flag], Manager1 [Supervisor], Manager2 [Manager]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_DelegateEmployeeList] TO [MSDSL]
    AS [dbo];


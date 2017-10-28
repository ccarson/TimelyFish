CREATE PROCEDURE WSL_AllProjectEmployeesList
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Employee
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
			'SELECT  employee [Employee Num],  
			 CASE WHEN CHARINDEX(''~'', emp_name) > 0 
			      THEN LTRIM(RIGHT(RTRIM(emp_name), LEN(emp_name) - CHARINDEX(''~'', emp_name))) + '' '' + SUBSTRING(emp_name, 1, (CHARINDEX(''~'', emp_name) - 1))
				  ELSE emp_name
			 END [Name],
			 manager1 [Manager1], cpnyid [Company], Subcontractor [Subcontractor], MSPType [Resource Type], placeholder [Generic], 
			 emp_status [Status], em_id21 [Location], em_id22 [Skill1], em_id23 [Skill2], em_id24 [Level], em_id25 [License/Cert]
			 FROM PJEmploy (nolock)
			 where employee like ' + quotename(@parm1,'''') + '
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
				employee, 
				emp_name = 
					 CASE WHEN CHARINDEX(''~'', emp_name) > 0 
					      THEN LTRIM(RIGHT(RTRIM(emp_name), LEN(emp_name) - CHARINDEX(''~'', emp_name))) + '' '' + SUBSTRING(emp_name, 1, (CHARINDEX(''~'', emp_name) - 1))
						  ELSE emp_name
					 END, 
				manager1, cpnyid, Subcontractor, MSPType, placeholder, 
				emp_status, em_id21, em_id22, em_id23, em_id24, em_id25,  
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJEmploy (nolock)
				WHERE employee like ' + quotename(@parm1,'''') + '
				) 
				SELECT employee [Employee Num], emp_name [Name], manager1 [Manager1], cpnyid [Company], Subcontractor [Subcontractor], MSPType [Resource Type], placeholder [Generic], 
			           emp_status [Status], em_id21 [Location], em_id22 [Skill1], em_id23 [Skill2], em_id24 [Level], em_id25 [License/Cert]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

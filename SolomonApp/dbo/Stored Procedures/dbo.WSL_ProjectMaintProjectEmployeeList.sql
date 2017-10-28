
CREATE PROCEDURE [dbo].[WSL_ProjectMaintProjectEmployeeList]
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (12) -- Employee, with % before and after
 ,@parm2 varchar (62) -- Employee Name
 ,@parm3 varchar (12) -- Company ID
 ,@parm4 varchar (26) -- GL Subaccount
 ,@parm5 varchar (32) -- Vendor
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@emp_nameAlias varchar (5) = 'Name',
	@cpnyidAlias varchar (10) = 'Company',
	@gl_subacctAlias varchar (15) = 'GL Subaccount',
	@em_id01Alias varchar (10) = 'Vendor',
    @whereExpression nvarchar(280)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND PJEmploy.emp_name LIKE ' + QUOTENAME(@parm2, '''');
       IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND PJEmploy.cpnyid LIKE ' + QUOTENAME(@parm3, '''');
	   IF @parm4 IS NOT NULL AND LEN(@parm4) > 0
              SET @whereExpression = @whereExpression + ' AND PJEmploy.gl_subacct LIKE ' + QUOTENAME(@parm4, '''');
	   IF @parm5 IS NOT NULL AND LEN(@parm5) > 0
              SET @whereExpression = @whereExpression + ' AND PJEmploy.em_id01 LIKE ' + QUOTENAME(@parm5, '''');

       IF @sort = ''
       BEGIN
              IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'PJEmploy.employee'
              ELSE IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'PJEmploy.emp_name'
              ELSE IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'PJEmploy.cpnyid'
			  ELSE IF @parm4 IS NOT NULL AND LEN(@parm4) > 1 SET @sort = 'PJEmploy.gl_subacct'
			  ELSE IF @parm5 IS NOT NULL AND LEN(@parm5) > 1 SET @sort = 'PJEmploy.em_id01'
              ELSE SET @sort = 'PJEmploy.employee'
       END
	   ELSE
	   BEGIN
			  IF @sort = @emp_nameAlias SET @sort = 'PJEmploy.emp_name'	
			  ELSE IF @sort = @cpnyidAlias SET @sort = 'PJEmploy.cpnyid'
			  ELSE IF @sort = @gl_subacctAlias SET @sort = 'PJEmploy.gl_subacct'
			  ELSE IF @sort = @em_id01Alias SET @sort = 'PJEmploy.em_id01'
	   END
		  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  Employee,  
				 CASE
					  WHEN CHARINDEX(''~'', emp_name) > 0 THEN LTRIM(RIGHT(RTRIM(emp_name), LEN(emp_name) - CHARINDEX(''~'', emp_name))) + '' '' + SUBSTRING(emp_name, 1, (CHARINDEX(''~'', emp_name) - 1))
					  ELSE emp_name
				 END [' + @emp_nameAlias + '],
			 cpnyid [' + @cpnyidAlias + '], gl_subacct [' + @gl_subacctAlias + '], em_id01 [' + @em_id01Alias + ']
			 FROM PJEmploy (nolock)
			 where employee like ' + quotename(@parm1,'''') + @whereExpression + '
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
				gl_subacct,  
				em_id01,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJEmploy (nolock)
				WHERE employee like ' + quotename(@parm1,'''') + @whereExpression + '
	              and emp_status = ''A'' 
				) 
				SELECT  Employee, emp_name [' + @emp_nameAlias + '], cpnyid [' + @cpnyidAlias + '], gl_subacct [' + @gl_subacctAlias + '], em_id01 [' + @em_id01Alias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintProjectEmployeeList] TO [MSDSL]
    AS [dbo];


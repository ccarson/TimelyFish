
CREATE PROCEDURE WSL_ExpenseApproverList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- Employee
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
			'SELECT employee [Emp #], emp_name [Name], cpnyid [Company], gl_subacct [GL Subaccount]
			 FROM PJEMPLOY (nolock)
			 where emp_status = ''A''
			  and  employee like ' + quotename(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') employee, emp_name, cpnyid, gl_subacct  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJEMPLOY (nolock)
				where emp_status = ''A''
					and  employee like ' + quotename(@parm1,'''') + '
				) 
				SELECT employee [Emp #], emp_name [Name], cpnyid [Company], gl_subacct [GL Subaccount]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ExpenseApproverList] TO [MSDSL]
    AS [dbo];


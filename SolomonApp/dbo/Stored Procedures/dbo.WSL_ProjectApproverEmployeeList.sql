
CREATE PROCEDURE [dbo].[WSL_ProjectApproverEmployeeList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Employee (Approver)
 ,@parm2 varchar (10) -- CompanyID
 ,@parm3 varchar (10) -- Employee (Document author)
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 'EmpID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT distinct EmpID [Employee],EmpName [Name] from QQ_TEApproval (nolock) 
			where Approver = ' + quotename(@parm1,'''') + ' and CompanyID = ' + quotename(@parm2,'''') + ' and EmpId like ' + quotename(@parm3,'''') + ' 
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
				SELECT  TOP(' + CONVERT(varchar(9), @ubound-1) + ')  EmpID [Employee], min(EmpName) [Name]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM QQ_TEApproval (nolock)
					where Approver = ' + quotename(@parm1,'''') + ' and CompanyID = ' + quotename(@parm2,'''') + ' and EmpId like ' + quotename(@parm3,'''') + ' 
					Group By EmpID
				) 
				SELECT *
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectApproverEmployeeList] TO [MSDSL]
    AS [dbo];


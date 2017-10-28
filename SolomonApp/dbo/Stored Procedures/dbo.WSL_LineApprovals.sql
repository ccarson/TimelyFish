
CREATE PROCEDURE [dbo].[WSL_LineApprovals]
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

	set @mgrRev = (SELECT SUBSTRING(PJCONTRL.control_data,1,1) as [ManagerReview]
	    FROM PJCONTRL where 
		PJCONTRL.control_code = 'MANAGER-REVIEW' and PJCONTRL.control_type = 'PA') 

    IF @sort = '' SET @sort = 'Date'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT QQ_LineApprovals.* from QQ_LineApprovals (nolock) 
			where Approver like ' + quotename(@parm1,'''') + ' and CompanyID like ' + quotename(@parm2,'''') + ' and EmpId like ' + quotename(@parm3,'''') + ' 
			left outer JOIN PJPROJEM (nolock) ON QQ_LineApprovals.project = PJPROJEM.project and (QQ_LineApprovals.Approver = PJPROJEM.employee  or PJPROJEM.employee = ''*'')
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') QQ_LineApprovals.*
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM QQ_LineApprovals (nolock)
					left outer JOIN PJPROJEM (nolock) ON QQ_LineApprovals.project = PJPROJEM.project and (QQ_LineApprovals.Approver = PJPROJEM.employee  or PJPROJEM.employee = ''*'')
					where Approver like ' + quotename(@parm1,'''') + ' and CompanyID like ' + quotename(@parm2,'''') + ' and EmpId like ' + quotename(@parm3,'''') + ' 
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
    ON OBJECT::[dbo].[WSL_LineApprovals] TO [MSDSL]
    AS [dbo];


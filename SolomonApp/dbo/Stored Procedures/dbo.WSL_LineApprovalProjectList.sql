
CREATE PROCEDURE [dbo].[WSL_LineApprovalProjectList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 'QQ_LineApprovals.Project'
    IF LOWER(@sort) = 'project' SET @sort = 'QQ_LineApprovals.Project'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT distinct QQ_LineApprovals.Project, pjproj.project_desc [Description] from pjproj,QQ_LineApprovals (nolock) where pjproj.project = QQ_LineApprovals.Project
			and QQ_LineApprovals.Project like ' + quotename(@parm1,'''') + '
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
				SELECT  TOP(' + CONVERT(varchar(9), @ubound-1) + ')   QQ_LineApprovals.Project, min(pjproj.project_desc) [Description]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM pjproj,QQ_LineApprovals (nolock)
					where pjproj.project = QQ_LineApprovals.Project
					and QQ_LineApprovals.Project like ' + quotename(@parm1,'''') + '
					Group By QQ_LineApprovals.Project
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
    ON OBJECT::[dbo].[WSL_LineApprovalProjectList] TO [MSDSL]
    AS [dbo];


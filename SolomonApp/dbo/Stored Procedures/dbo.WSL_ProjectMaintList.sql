
CREATE PROCEDURE [dbo].[WSL_ProjectMaintList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'Project'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT project, [project description], isnull([customer name],'''') as [customer name], [project mgr name], isnull([business mgr name],'''') as [business mgr name], [company], [start date], [end date], [project status], QQ_pjprojNamed.noteid, Comment
			 FROM QQ_pjprojNamed (nolock)
			 where project like ' + quotename(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') project, [project description], [customer name], [project mgr name], [business mgr name], [company], [start date], [end date], [project status], QQ_pjprojNamed.noteid, Comment  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM QQ_pjprojNamed (nolock)
					where project like ' + quotename(@parm1,'''') + '
				) 
				SELECT project, [project description], isnull([customer name],'''') as [customer name], [project mgr name], isnull([business mgr name],'''') as [business mgr name], [company], [start date], [end date], [project status], QQ_pjprojNamed.noteid, Comment  
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintList] TO [MSDSL]
    AS [dbo];


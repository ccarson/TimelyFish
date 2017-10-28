
CREATE PROCEDURE [dbo].[WSL_ProjectMaxList]
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
    
    IF @sort = '' SET @sort = 'project, [Task], [Account Category]'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT QQ_pjprojmx.Project, QQ_pjprojmx.[Task], QQ_pjprojmx.noteid, QQ_pjprojmx.[Account Category], QQ_pjprojmx.[Additonal Acct], QQ_pjprojmx.[Max Amount], COALESCE (QQ_pjprojmx.[Total],0) [Total] 
			 FROM QQ_pjprojmx (nolock)
			 where QQ_pjprojmx.project = ' + quotename(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') QQ_pjprojmx.Project, QQ_pjprojmx.[Task], QQ_pjprojmx.noteid, QQ_pjprojmx.[Account Category], QQ_pjprojmx.[Additonal Acct], QQ_pjprojmx.[Max Amount], COALESCE (QQ_pjprojmx.[Total],0) [Total] 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				 FROM QQ_pjprojmx (nolock)
				 where QQ_pjprojmx.project = ' + quotename(@parm1,'''') + '
				) 
				SELECT Project, [Task], noteid, [Account Category], [Additonal Acct], [Max Amount], [Total] 
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaxList] TO [MSDSL]
    AS [dbo];


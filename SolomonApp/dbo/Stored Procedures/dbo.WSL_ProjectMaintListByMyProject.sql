
CREATE PROCEDURE [dbo].[WSL_ProjectMaintListByMyProject]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Employee ID
 ,@parm2 varchar (12) -- Company ID
 ,@parm3 varchar(3) -- Status
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
	IF @sort = '' SET @sort = 'QQ_pjprojNamed.Project'
  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT distinct QQ_pjprojNamed.project, [project description], isnull([customer name],'''') as [customer name], [project mgr name], isnull([business mgr name],'''') as [business mgr name], [company], [start date], [end date], [project status], QQ_pjprojNamed.noteid, Comment
			 FROM QQ_pjprojNamed (nolock)  
			 WHERE QQ_pjprojNamed.[project manager] like ' + quotename(@parm1,'''') + ' AND
			 QQ_pjprojNamed.company LIKE ' + quotename(@parm2,'''') + ' AND
			 [project status] LIKE ' + quotename(@parm3,'''') + ' 
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
				SELECT distinct TOP(' + CONVERT(varchar(9), @ubound-1) + ') QQ_pjprojNamed.project, [project description], [customer name], [project mgr name], [business mgr name], [company], [start date], [end date], [project status], QQ_pjprojNamed.noteid, Comment  
				,DENSE_RANK() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM QQ_pjprojNamed (nolock)  				
			    WHERE QQ_pjprojNamed.[project manager] like ' + quotename(@parm1,'''') + ' AND
				QQ_pjprojNamed.company LIKE ' + quotename(@parm2,'''') + ' AND
			   [project status] LIKE ' + quotename(@parm3,'''') + ' 
				) 
				SELECT project, [project description], isnull([customer name],'''') as [customer name], [project mgr name], isnull([business mgr name],'''') as [business mgr name], [company], [start date], [end date], [project status], noteid, Comment  
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintListByMyProject] TO [MSDSL]
    AS [dbo];


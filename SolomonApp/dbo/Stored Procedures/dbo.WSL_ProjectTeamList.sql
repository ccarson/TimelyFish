
CREATE PROCEDURE [dbo].[WSL_ProjectTeamList]
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
    
    IF @sort = '' SET @sort = '[resource id (*=avail to all)]'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT project, noteid, [resource id (*=avail to all)] [ResourceID], [resource name] [ResourceName] 
			 FROM QQ_pjprojem (nolock)
			 where [resource id (*=avail to all)] <> ''*'' And project like ' + quotename(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') project, noteid, [resource id (*=avail to all)] [ResourceID], [resource name] [ResourceName]   
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM QQ_pjprojem (nolock)
					where [resource id (*=avail to all)] <> ''*'' And project like ' + quotename(@parm1,'''') + '
				) 
				SELECT  project, noteid, [ResourceID],  [ResourceName]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END	
	  
print 	@STMT		
  EXEC (@STMT) 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectTeamList] TO [MSDSL]
    AS [dbo];


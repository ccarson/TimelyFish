
CREATE PROCEDURE WSL_PJPROJEDDDocTypeList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
 ,@parm2 varchar (2) -- DocType
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),
    @lbound int,
    @ubound int

    IF @sort = '' SET @sort = 'project'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT doctype [DocType]
			 FROM PJPROJEDD (nolock)
			 WHERE project = ' + quotename(@parm1,'''') + 
			 ' AND doctype LIKE ' + quotename(@parm2,'''') +
			 ' ORDER BY ' + @sort
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') period
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				 FROM PJPROJEDD (nolock)
				WHERE project = ' + quotename(@parm1,'''') + 
				' AND doctype LIKE ' + quotename(@parm2,'''') + '
				) 
				SELECT doctype [DocType]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_PJPROJEDDDocTypeList] TO [MSDSL]
    AS [dbo];


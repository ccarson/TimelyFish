
CREATE PROCEDURE [dbo].[WSL_CodeFile]
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 char (4) -- code_type
 ,@parm2 char (30) -- code_value
AS
  SET NOCOUNT ON

  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int

  IF @sort = '' SET @sort = 'Value'
  IF @page < 1 SET @page = 1
  IF @size < 1 SET @size = 1
  SET @lbound = (@page-1) * @size
  SET @ubound = @page * @size + 1
  SET @STMT = 
 	 	'WITH PagingCTE AS
 	 	(
 	 	SELECT  TOP(' + CONVERT(varchar(9), @ubound-1) + ') code_value [Value], code_value_desc [Description]
 	 	,ROW_NUMBER() OVER(
 	 	ORDER BY code_value) AS row
 	 	FROM PJCODE where code_type like ' + quotename(RTRIM(@parm1),'''') + ' AND code_value LIKE ' + quotename(RTRIM(@parm2),'''') + '
 	 	) 
 	 	SELECT *
 	 	FROM PagingCTE                     
 	 	WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
 	 	 	 	row <  ' + CONVERT(varchar(9), @ubound) + '
 	 	ORDER BY ' + @sort 	 	 	 	
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_CodeFile] TO [MSDSL]
    AS [dbo];


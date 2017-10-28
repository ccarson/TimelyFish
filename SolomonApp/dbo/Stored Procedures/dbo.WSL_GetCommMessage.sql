
CREATE PROCEDURE [dbo].[WSL_GetCommMessage]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (48) -- Message Key
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 'msg_key'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'select msg_text from pjcommun where msg_key like ' + quotename(@parm1,'''') + '
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
				SELECT  TOP(' + CONVERT(varchar(9), @ubound-1) + ')   msg_text
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM pjcommun where msg_key like ' + quotename(@parm1,'''') + '
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
    ON OBJECT::[dbo].[WSL_GetCommMessage] TO [MSDSL]
    AS [dbo];


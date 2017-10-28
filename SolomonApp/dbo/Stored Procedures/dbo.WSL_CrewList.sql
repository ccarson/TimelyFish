CREATE PROCEDURE WSL_CrewList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- Code Value
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'PJCODE.code_value'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT PJCODE.Code_Value [Code Value], PJCODE.code_value_desc [Description]
			 FROM PJCODE (nolock)
			 where PJCODE.code_type = ''CREW''
			  and  PJCODE.code_value like ' + quotename(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') PJCODE.code_value, PJCODE.code_value_desc  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJCODE (nolock)
					where PJCODE.code_type = ''CREW''
					and  PJCODE.code_value like ' + quotename(@parm1,'''') + '
				) 
				SELECT code_value [Code Value], code_value_desc [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_CrewList] TO [MSDSL]
    AS [dbo];


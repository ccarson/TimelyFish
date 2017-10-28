
CREATE PROCEDURE WSL_ProjectShiftList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (30) -- code value
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'pjcode.code_type'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT code_value [Code Value], code_value_desc [Description], code_type [Code Type]
			 FROM PJCODE(nolock)
			 where code_type = ''SHFT''
			  and  code_value LIKE ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') code_value, code_value_desc, code_type
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJCODE(nolock)
					where code_type = ''SHFT''
			  		and  code_value LIKE ' + quotename(@parm1,'''') + '
				) 
				SELECT code_value [Code Value], code_value_desc [Description], code_type [Code Type]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectShiftList] TO [MSDSL]
    AS [dbo];


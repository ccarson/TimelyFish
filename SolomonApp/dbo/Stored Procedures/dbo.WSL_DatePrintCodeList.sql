﻿CREATE PROCEDURE WSL_DatePrintCodeList
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
    
    IF @sort = '' SET @sort = 'code_value'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Code_Value [Code Value], code_value_desc [Description]
			 FROM PJCODE (nolock)
			 where code_type = ''DATP''
			  and  code_value like ' + quotename(@parm1,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Code_Value, code_value_desc  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJCODE (nolock)
					where code_type = ''DATP''
					and  code_value like ' + quotename(@parm1,'''') + '
				) 
				SELECT Code_Value [Code Value], code_value_desc [Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

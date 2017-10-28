
CREATE PROCEDURE WSL_PaymentMethodList
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
			 'WITH PagingCTE AS
			 (
			 SELECT ''****'' code_value, ''Employee Paid'' code_value_desc UNION
			 SELECT code_value, code_value_desc 
			 FROM PJCODE (nolock)
			 WHERE code_type = ''TEPM''
			  and  code_value like ' + quotename(@parm1,'''') + '
			 )
			 SELECT code_value [Code Value], code_value_desc [Description]
				FROM PagingCTE 
				WHERE code_value like ' + quotename(@parm1,'''') + '
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
				SELECT ''****'' code_value, ''Employee Paid'' code_value_desc, 1 row UNION
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Code_Value, code_value_desc  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') + 1 AS row
				FROM PJCODE (nolock)
					where code_type = ''TEPM''
					and  code_value like ' + quotename(@parm1,'''') + '
				) 
				SELECT Code_Value [Code Value], code_value_desc [Description]
				FROM PagingCTE                     
				WHERE  code_value like ' + quotename(@parm1,'''') + ' AND
				row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY ' + @sort
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_PaymentMethodList] TO [MSDSL]
    AS [dbo];


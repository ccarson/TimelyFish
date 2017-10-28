
CREATE PROCEDURE [dbo].[WSL_ProjectMaintPaymentMethodList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (32) -- Code Value
 ,@parm2 varchar (32) -- Code Value Description
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@code_valueAlias varchar (15) = 'Code Value',
	@code_value_descAlias varchar (15) = 'Description',
    @whereExpression nvarchar(80)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND code_value_desc LIKE ' + QUOTENAME(@parm2, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'code_value'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'code_value_desc'
              ELSE SET @sort = 'code_value'
       END
	   ELSE
	   BEGIN
			  IF @sort = @code_valueAlias SET @sort = 'code_value'
			  ELSE IF @sort = @code_value_descAlias SET @sort = 'code_value_desc'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			 'WITH PagingCTE AS
			 (
			 SELECT ''****'' code_value, ''Employee Paid'' code_value_desc UNION
			 SELECT code_value, code_value_desc 
			 FROM PJCODE (nolock)
			 WHERE code_type = ''TEPM''
			  and  code_value like ' + quotename(@parm1,'''') + @whereExpression + '
			 )
			 SELECT code_value [' + @code_valueAlias + '], code_value_desc [' + @code_value_descAlias + ']
				FROM PagingCTE 
				WHERE code_value like ' + quotename(@parm1,'''') + @whereExpression + '
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
					and  code_value like ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT code_value [' + @code_valueAlias + '], code_value_desc [' + @code_value_descAlias + ']
				FROM PagingCTE                     
				WHERE  code_value like ' + quotename(@parm1,'''') + @whereExpression + ' AND
				row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY ' + @sort
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintPaymentMethodList] TO [MSDSL]
    AS [dbo];


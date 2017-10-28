
CREATE PROCEDURE [dbo].[WSL_ProjectMaintContractTypeList]
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
	@Code_ValueAlias varchar (15) = 'Code Value',
	@code_value_descAlias varchar (15) = 'Description',
    @whereExpression nvarchar(80)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND pjcode.code_value_desc LIKE ' + QUOTENAME(@parm2, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'pjcode.Code_Value'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'pjcode.code_value_desc'
              ELSE SET @sort = 'pjcode.Code_Value'
       END
	   ELSE 
	   BEGIN
			  IF @sort = @Code_ValueAlias SET @sort = 'pjcode.Code_Value'
			  ELSE IF @sort = @code_value_descAlias SET @sort = 'pjcode.code_value_desc'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Code_Value [' + @Code_ValueAlias + '], code_value_desc [' + @code_value_descAlias + ']
			 FROM PJCODE (nolock)
			 where code_type = ''CONT''
			  and  code_value like ' + quotename(@parm1,'''') + @whereExpression + '
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
					where code_type = ''CONT ''
					and  code_value like ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT Code_Value [' + @Code_ValueAlias + '], code_value_desc [' + @code_value_descAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintContractTypeList] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE [dbo].[WSL_ProjectMaintAllocationMethodList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (32) -- Code Value
 ,@parm2 varchar (32) -- Code Value Description
 ,@parm3 varchar (32) -- Allocation Type
 ,@parm4 varchar (6) -- Code Type
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@Code_ValueAlias varchar (15) = 'Code Value',
	@code_value_descAlias varchar (15) = 'Description',
	@Data1Alias varchar (20) = 'Allocation Type',
	@code_typeAlias varchar (15) = 'Code Type',
    @whereExpression nvarchar(120)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND code_value_desc LIKE ' + QUOTENAME(@parm2, '''');
	   IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
              SET @whereExpression = @whereExpression + ' AND Data1 LIKE ' + QUOTENAME(@parm3, '''');
	   IF @parm4 IS NOT NULL AND LEN(@parm4) > 0
              SET @whereExpression = @whereExpression + ' AND code_type LIKE ' + QUOTENAME(@parm4, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'code_value'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'code_value_desc'
			  Else IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'Data1'
			  ELSE IF @parm4 IS NOT NULL AND LEN(@parm4) > 1 SET @sort = 'code_type'
              ELSE SET @sort = 'code_value'
       END
	   ELSE
	   BEGIN
			IF @sort = @Code_ValueAlias SET @sort = 'code_value'
			ELSE IF @sort = @code_value_descAlias SET @sort = 'code_value_desc'
			ELSE IF @sort = @Data1Alias SET @sort = 'Data1'
			ELSE IF @sort = @code_typeAlias SET @sort = 'code_type'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Code_Value [' + @Code_ValueAlias + '], code_value_desc [' + @code_value_descAlias + '], Data1 [' + @Data1Alias + '], code_type [' + @code_typeAlias + ']
			 FROM PJCODE (nolock)
			 where code_type = ''ALLM''
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Code_Value, code_value_desc, Data1, code_type  
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJCODE (nolock)
				where code_type = ''ALLM''
					and  code_value like ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT Code_Value [' + @Code_ValueAlias + '], code_value_desc [' + @code_value_descAlias + '], Data1 [' + @Data1Alias + '], code_type [' + @code_typeAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintAllocationMethodList] TO [MSDSL]
    AS [dbo];


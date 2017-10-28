
CREATE PROCEDURE [dbo].[WSL_ProjectMaintCurrencyCodeList]
@page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (6) -- Currency Code Value
 ,@parm2 varchar (32) -- Currency Code Description
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int,
	@Code_ValueAlias varchar (15) = 'Code Value',
	@code_value_descAlias varchar (15) = 'Description',
    @whereExpression nvarchar(60)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND PJCODE.Code_value_desc LIKE ' + QUOTENAME(@parm2, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'PJCODE.Code_Value'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'PJCODE.Code_value_descr'
              ELSE SET @sort = 'PJCODE.Code_Value'
       END
	   ELSE
	   BEGIN
			  IF @sort = @Code_ValueAlias SET @sort = 'PJCODE.Code_Value'
			  ELSE IF @sort = @code_value_descAlias SET @sort = 'PJCODE.Code_value_descr'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Code_Value [' + @Code_ValueAlias + '], Code_value_desc [' + @code_value_descAlias + ']
			 FROM PJCODE (nolock)
			 WHERE Code_Type = ''CURR''
			 AND Code_Value LIKE ' + quotename(@parm1,'''') + @whereExpression + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Code_value, Code_value_desc,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJCODE
				WHERE Code_Type = ''Curr''
				AND Code_Value LIKE ' + quotename(@parm1,'''') + @whereExpression + '
				) 
				SELECT Code_value [' + @Code_ValueAlias + '], Code_value_desc [' + @code_value_descAlias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintCurrencyCodeList] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE [dbo].[WSL_ProjectMaintContractList]
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (18) -- Contract
 ,@parm2 varchar (62) -- Contract Description
 ,@parm3 varchar (62) -- Name
 ,@parm4 char (3) -- Status
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
	@contract_descAlias varchar (15) = 'Description',
	@nameAlias varchar (10) = 'Customer',
	@status1Alias varchar (10) = 'Status',
    @whereExpression nvarchar(230)
    
    SET @whereExpression = ''

       IF @parm2 IS NOT NULL AND LEN(@parm2) > 0
              SET @whereExpression = @whereExpression + ' AND pjcont.contract_desc LIKE ' + QUOTENAME(@parm2, '''');
	   IF @parm3 IS NOT NULL AND LEN(@parm3) > 0
			  SET @whereExpression = @whereExpression + ' AND Customer.Name LIKE ' + QUOTENAME(@parm3, '''');
	   IF @parm4 IS NOT NULL AND LEN(@parm4) > 0
			  SET @whereExpression = @whereExpression + ' AND pjcont.status1 LIKE ' + QUOTENAME(@parm4, '''');

       IF @sort = ''
       BEGIN
			  IF @parm1 IS NOT NULL AND LEN(@parm1) > 1 SET @sort = 'pjcont.contract'
              Else IF @parm2 IS NOT NULL AND LEN(@parm2) > 1 SET @sort = 'pjcont.contract_desc'
              ELSE IF @parm3 IS NOT NULL AND LEN(@parm3) > 1 SET @sort = 'Customer.Name'
			  ELSE IF @parm4 IS NOT NULL AND LEN(@parm4) > 1 SET @sort = 'pjcont.status1'
              ELSE SET @sort = 'pjcont.contract'
       END
	   ELSE
	   BEGIN
	          IF @sort = @contract_descAlias SET @sort = 'pjcont.contract_desc'
			  ELSE IF @sort = @nameAlias SET @sort = 'Customer.Name'
			  ELSE IF @sort = @status1Alias SET @sort = 'pjcont.status1'
	   END
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  contract [Contract], contract_desc [' + @contract_descAlias + '], name [' + @nameAlias + '], status1 [' + @status1Alias + ']
			 FROM PJCONT (nolock)
			 LEFT Outer Join CUSTOMER
			   ON PJCONT.customer = CUSTOMER.custid 
			 where contract like ' + quotename(@parm1,'''') + @whereExpression + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') contract, contract_desc, name, status1,  
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM PJCONT (nolock)
				LEFT Outer Join CUSTOMER
			    ON PJCONT.customer = CUSTOMER.custid 
				WHERE contract like ' + quotename(@parm1,'''') + @whereExpression + '
				) 
    			SELECT  contract [Contract], contract_desc [' + @contract_descAlias + '], name [' + @nameAlias + '], status1 [' + @status1Alias + ']
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ProjectMaintContractList] TO [MSDSL]
    AS [dbo];


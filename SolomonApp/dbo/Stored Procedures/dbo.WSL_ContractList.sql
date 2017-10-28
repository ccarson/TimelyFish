CREATE PROCEDURE WSL_ContractList
  @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Contract
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'contract'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT  contract [Contract], contract_desc [Description], name [Customer], status1 [Status]
			 FROM PJCONT (nolock)
			 LEFT Outer Join CUSTOMER
			   ON PJCONT.customer = CUSTOMER.custid 
			 where contract like ' + quotename(@parm1,'''') + '
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
				WHERE contract like ' + quotename(@parm1,'''') + '
				) 
    			SELECT  contract [Contract], contract_desc [Description], name [Customer], status1 [Status]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_ContractList] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE WSL_AddressList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- AddrId
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'AddrId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Address.AddrId [Address ID], Address.Name [Name], Address.Phone [Phone], Address.Zip [Zip]
			 FROM Address(nolock)
			 where AddrId like ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Address.AddrId, Address.Name, Address.Phone, Address.Zip

				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Address(nolock)
					where AddrId like ' + quotename(@parm1,'''') + ' 
				) 
				SELECT AddrId [Address ID], Name [Name], Phone [Phone], Zip [Zip]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

CREATE PROCEDURE WSL_ShipToAddressList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (15) -- CustId
 ,@parm2 varchar (10) -- ShipToId
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),  
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CustId, ShipToId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT ShipToId [Address ID], Name, Phone, Zip [Postal Code]
			 FROM SOAddress (nolock)
			 WHERE CustId LIKE ' + quotename(@parm1,'''') + ' 
			 AND ShipToId LIKE ' + quotename(@parm2,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') ShipToId, Name, Phone, Zip, 
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM SOAddress
				WHERE CustId LIKE ' + quotename(@parm1,'''') + '
				AND ShipToId LIKE ' + quotename(@parm2,'''') + '
				) 
				SELECT ShipToId [Address ID], Name, Phone, Zip [Postal Code] 
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 


CREATE PROCEDURE WSL_PurchaseOrderAddressList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (15) -- VendId
 ,@parm2 varchar (10) --OrdFromId
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'VendId, OrdFromId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT POAddress.OrdFromId [PO Address ID], POAddress.Descr [PO Address Description]
			 FROM POAddress(nolock)
			 where VendId = ' + quotename(@parm1,'''') + ' 
			  and OrdFromId like ' + quotename(@parm2,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') POAddress.OrdFromId, POAddress.Descr
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM POAddress(nolock)
					where VendId = ' + quotename(@parm1,'''') + ' 
					and OrdFromId like ' + quotename(@parm2,'''') + '
				) 
				SELECT OrdFromId [PO Address ID], Descr [PO Address Description]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_PurchaseOrderAddressList] TO [MSDSL]
    AS [dbo];


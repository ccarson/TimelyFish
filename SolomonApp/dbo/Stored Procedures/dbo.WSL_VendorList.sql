
CREATE PROCEDURE WSL_VendorList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (15) -- VendID
 AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'VendId'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT Vendor.VendId [Vendor ID], Vendor.Name [Name], Vendor.Phone [Phone], Vendor.Zip [Zip]
			 FROM Vendor(nolock)
			 where VendId LIKE ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') Vendor.VendId, Vendor.Name, Vendor.Phone, Vendor.Zip
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM Vendor(nolock)
					where VendId LIKE ' + quotename(@parm1,'''') + ' 
				) 
				SELECT VendId [Vendor ID], Name [Name], Phone [Phone], Zip [Zip]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_VendorList] TO [MSDSL]
    AS [dbo];


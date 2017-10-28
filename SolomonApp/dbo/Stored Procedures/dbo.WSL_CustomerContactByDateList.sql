CREATE PROCEDURE WSL_CustomerContactByDateList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (15) -- CustID
 ,@parm2 varchar (2) -- Type
 ,@parm3 varchar (10) -- ContactID
 ,@parm4 smalldatetime -- Lupd_DateTime
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'CustID, ContactID'
	
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT ContactID [Contact ID], Name [Name], CustID [Customer ID]
			 FROM CustContact (nolock)
			 WHERE CustID LIKE ' + quotename(@parm1,'''') + ' 
			 AND Type LIKE ' + quotename(@parm2,'''') + ' 
			 AND ContactID LIKE ' + quotename(@parm3,'''') + ' 
			 AND Lupd_DateTime >= ' + quotename(@parm4,'''') + '
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') ContactID, Name, CustID,
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM CustContact (nolock)
				WHERE CustID LIKE ' + quotename(@parm1,'''') + '
				AND Type LIKE ' + quotename(@parm2,'''') + ' 
				AND ContactID LIKE ' + quotename(@parm3,'''') + '
				AND Lupd_DateTime >= ' + quotename(@parm4,'''') + ' 
				) 
				SELECT ContactID [Contact ID], Name [Name]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

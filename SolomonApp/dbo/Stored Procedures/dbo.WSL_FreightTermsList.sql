CREATE PROCEDURE WSL_FreightTermsList
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- FrtTermsID
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max),   
    @lbound int,
    @ubound int
    
    IF @sort = '' SET @sort = 'FrtTermsID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT FrtTermsID [Freight Terms], Descr [Description], Collect [Freight Collect]
			 FROM FrtTerms (nolock)
			 WHERE FrtTermsID LIKE ' + quotename(@parm1,'''') + ' 
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
				SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ') FrtTermsID, Descr, Collect, 
				ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM FrtTerms (nolock)
				WHERE FrtTermsID LIKE ' + quotename(@parm1,'''') + '
				) 
				SELECT FrtTermsID [Freight Terms], Descr [Description], Collect [Freight Collect]
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

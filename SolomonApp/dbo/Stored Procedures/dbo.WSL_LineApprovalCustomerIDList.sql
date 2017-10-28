
CREATE PROCEDURE [dbo].[WSL_LineApprovalCustomerIDList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (15) -- CustomerID
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 'CustomerID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT distinct QQ_LineApprovals.CustomerID, QQ_Customer.[Customer Name] [Name] from QQ_Customer,QQ_LineApprovals (nolock) where QQ_Customer.[Customer ID] = QQ_LineApprovals.CustomerID
			and QQ_LineApprovals.CustomerID like ' + quotename(@parm1,'''') + '
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
				SELECT  TOP(' + CONVERT(varchar(9), @ubound-1) + ')   QQ_LineApprovals.CustomerID, min(QQ_Customer.[Customer Name]) [Name]
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM QQ_Customer,QQ_LineApprovals (nolock)
					where QQ_Customer.[Customer ID] = QQ_LineApprovals.CustomerID
					and QQ_LineApprovals.CustomerID like ' + quotename(@parm1,'''') + '
					Group By QQ_LineApprovals.CustomerID
				) 
				SELECT *
				FROM PagingCTE                     
				WHERE  row > ' + CONVERT(varchar(9), @lbound) + ' AND
					   row <  ' + CONVERT(varchar(9), @ubound) + '
				ORDER BY row'
	  END				
  EXEC (@STMT) 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_LineApprovalCustomerIDList] TO [MSDSL]
    AS [dbo];


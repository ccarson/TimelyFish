
CREATE PROCEDURE [dbo].[WSL_LineApprovalCompanyIDList]
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (10) -- Company
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 'QQ_LineApprovals.CompanyID'
    IF LOWER(@sort) = 'companyid' SET @sort = 'QQ_LineApprovals.CompanyID'
	  
  IF @page = 0  -- Don't do paging
	  BEGIN
		SET @STMT = 
			'SELECT distinct QQ_LineApprovals.CompanyID, vs_company.CpnyName [Name] from vs_company,QQ_LineApprovals (nolock) where vs_company.CpnyID = QQ_LineApprovals.CompanyID
			and QQ_LineApprovals.CompanyID like ' + quotename(@parm1,'''') + '
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
				SELECT  TOP(' + CONVERT(varchar(9), @ubound-1) + ')   QQ_LineApprovals.CompanyID, min(vs_company.CpnyName) [Name] 
				,ROW_NUMBER() OVER(
				ORDER BY ' + @sort + ') AS row
				FROM vs_company,QQ_LineApprovals (nolock)
					where vs_company.CpnyID = QQ_LineApprovals.CompanyID
					and QQ_LineApprovals.CompanyID like ' + quotename(@parm1,'''') + '
					Group By QQ_LineApprovals.CompanyID
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
    ON OBJECT::[dbo].[WSL_LineApprovalCompanyIDList] TO [MSDSL]
    AS [dbo];


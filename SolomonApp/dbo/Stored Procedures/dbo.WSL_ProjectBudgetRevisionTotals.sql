
CREATE PROCEDURE WSL_ProjectBudgetRevisionTotals
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
 ,@parm2 varchar (4) -- Revision
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 'a.acct'

  SET @STMT = N'' --prevents truncation

  IF @page = 0  -- Don't do paging
 	  BEGIN
 	 	SET @STMT = @STMT +
 	 	 	'SELECT
 	 	 	 	SUM(CASE WHEN a.acct_type = ''EX'' THEN d.act_amount + d.com_amount ELSE 0 END) AS [CostActualCommit],
 	 	 	 	SUM(CASE WHEN a.acct_type = ''RV'' THEN d.act_amount + d.com_amount ELSE 0 END) AS [RevActualCommit],
 	 	 	 	SUM(CASE WHEN a.acct_type = ''RV'' THEN d.act_amount + d.com_amount ELSE -(d.act_amount + d.com_amount) END) AS [NetActualCommit],
 	 	 	 	SUM(
 	 	 	 	 	CASE WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_units
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_units
 	 	 	 	 	 	 	ELSE d.eac_units
 	 	 	 	 	 	END
 	 	 	 	 	ELSE 0 END) AS [CostBudgetUnits],
 	 	 	 	SUM(
 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_units
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_units
 	 	 	 	 	 	 	ELSE d.eac_units
 	 	 	 	 	 	END
 	 	 	 	 	ELSE 0 END) AS [RevBudgetUnits],
 	 	 	 	SUM(
 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_units
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_units
 	 	 	 	 	 	 	ELSE d.eac_units
 	 	 	 	 	 	END
 	 	 	 	 	WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN -d.fac_units
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN -d.total_budget_units
 	 	 	 	 	 	 	ELSE d.eac_units
 	 	 	 	 	 	END
 	 	 	 	 	END) AS [NetBudgetUnits],
 	 	 	 	SUM(
 	 	 	 	 	CASE WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	ELSE 0 END
 	 	 	 	) AS [CostBudgetAmount],
 	 	 	 	SUM(
 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	ELSE 0 END
 	 	 	 	) AS [RevBudgetAmount],
 	 	 	 	SUM(
 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN -d.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN -d.total_budget_amount
 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	END
 	 	 	 	) AS [NetBudgetAmount],
 	 	 	 	SUM(
 	 	 	 	 	CASE WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	ELSE 0 END
 	 	 	 	) - SUM(d.act_amount + d.com_amount) AS [CostEstimateToComplete],
 	 	 	 	SUM(
 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	ELSE 0 END
 	 	 	 	) - SUM(d.act_amount + d.com_amount)  AS [RevEstimateToComplete],
 	 	 	 	SUM(
 	 	 	 	 	CASE WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN -d.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN -d.total_budget_amount
 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	END
 	 	 	 	) - SUM(d.act_amount + d.com_amount) AS [NetEstimateToComplete]
 	 	 	FROM PJPTDROL d
 	 	 	 	INNER JOIN PJACCT a
 	 	 	 	ON d.Acct = a.Acct
 	 	 	 	INNER JOIN PJREVHDR h
 	 	 	 	ON h.Project = d.project
 	 	 	WHERE
 	 	 	 	d.project = ' + quotename(@parm1,'''') + '
 	 	 	 	AND h.RevId = ' + quotename(@parm2,'''') + '
 	 	 	 	AND a.acct_type IN (''EX'',''RV'')' + '
 	 	 	GROUP BY a.Acct
 	 	 	ORDER BY ' + @sort
 	  END
  ELSE
 	  BEGIN
 	 	 	IF @page < 1 SET @page = 1
 	 	 	IF @size < 1 SET @size = 1
 	 	 	SET @lbound = (@page-1) * @size
 	 	 	SET @ubound = @page * @size + 1
 	 	 	SET @STMT = @STMT +
 	 	 	 	'WITH PagingCTE AS
 	 	 	 	(
 	 	 	 	SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ')
 	 	 	 	 	SUM(CASE WHEN a.acct_type = ''EX'' THEN d.act_amount + d.com_amount ELSE 0 END) AS [CostActualCommit],
 	 	 	 	 	SUM(CASE WHEN a.acct_type = ''RV'' THEN d.act_amount + d.com_amount ELSE 0 END) AS [RevActualCommit],
 	 	 	 	 	SUM(CASE WHEN a.acct_type = ''RV'' THEN d.act_amount + d.com_amount ELSE -(d.act_amount + d.com_amount) END) AS [NetActualCommit],
 	 	 	 	 	SUM(
 	 	 	 	 	 	CASE WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_units
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_units
 	 	 	 	 	 	 	 	ELSE d.eac_units
 	 	 	 	 	 	 	END
 	 	 	 	 	 	ELSE 0 END) AS [CostBudgetUnits],
 	 	 	 	 	SUM(
 	 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_units
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_units
 	 	 	 	 	 	 	 	ELSE d.eac_units
 	 	 	 	 	 	 	END
 	 	 	 	 	 	ELSE 0 END) AS [RevBudgetUnits],
 	 	 	 	 	SUM(
 	 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_units
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_units
 	 	 	 	 	 	 	 	ELSE d.eac_units
 	 	 	 	 	 	 	END
 	 	 	 	 	 	WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN -d.fac_units
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN -d.total_budget_units
 	 	 	 	 	 	 	 	ELSE d.eac_units
 	 	 	 	 	 	 	END
 	 	 	 	 	 	END) AS [NetBudgetUnits],
 	 	 	 	 	SUM(
 	 	 	 	 	 	CASE WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	 	END
 	 	 	 	 	 	ELSE 0 END
 	 	 	 	 	) AS [CostBudgetAmount],
 	 	 	 	 	SUM(
 	 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	 	END
 	 	 	 	 	 	ELSE 0 END
 	 	 	 	 	) AS [RevBudgetAmount],
 	 	 	 	 	SUM(
 	 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	 	END
 	 	 	 	 	 	WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN -d.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN -d.total_budget_amount
 	 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	 	END
 	 	 	 	 	 	END
 	 	 	 	 	) AS [NetBudgetAmount],
 	 	 	 	 	SUM(
 	 	 	 	 	 	CASE WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	 	END
 	 	 	 	 	 	ELSE 0 END
 	 	 	 	 	) - SUM(d.act_amount + d.com_amount) AS [CostEstimateToComplete],
 	 	 	 	 	SUM(
 	 	 	 	 	 	CASE WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	 	END
 	 	 	 	 	 	ELSE 0 END
 	 	 	 	 	) - SUM(d.act_amount + d.com_amount)  AS [RevEstimateToComplete],
 	 	 	 	 	SUM(
 	 	 	 	 	 	CASE WHEN a.acct_type = ''EX'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN -d.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN -d.total_budget_amount
 	 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	 	END
 	 	 	 	 	 	WHEN a.acct_type = ''RV'' THEN
 	 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN d.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN d.total_budget_amount
 	 	 	 	 	 	 	 	ELSE d.eac_amount
 	 	 	 	 	 	 	END
 	 	 	 	 	 	END
 	 	 	 	 	) - SUM(d.act_amount + d.com_amount) AS [NetEstimateToComplete]
 	 	 	 	,ROW_NUMBER() OVER(
 	 	 	 	ORDER BY ' + @sort + ') AS row
 	 	 	 	FROM PJPTDROL d
 	 	 	 	 	INNER JOIN PJACCT a
 	 	 	 	 	ON d.Acct = a.Acct
 	 	 	 	 	INNER JOIN PJREVHDR h
 	 	 	 	 	ON h.Project = d.project
 	 	 	 	WHERE
 	 	 	 	 	d.project = ' + quotename(@parm1,'''') + '
 	 	 	 	 	AND h.RevId = ' + quotename(@parm2,'''') + '
 	 	 	 	 	AND a.acct_type IN (''EX'',''RV'')
 	 	 	 	GROUP BY a.Acct
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
    ON OBJECT::[dbo].[WSL_ProjectBudgetRevisionTotals] TO [MSDSL]
    AS [dbo];


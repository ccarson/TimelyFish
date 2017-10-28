
CREATE PROCEDURE WSL_ProjectBudgetRevisionCalculations
 @page  int
 ,@size  int
 ,@sort   nvarchar(200)
 ,@parm1 varchar (16) -- Project
 ,@parm2 varchar (4) -- Revision
 ,@parm3 varchar (32) -- Task
 ,@parm4 varchar (16) -- Account
AS
  SET NOCOUNT ON
  DECLARE
    @STMT nvarchar(max), 
    @lbound int,
    @ubound int,
    @mgrRev char

    IF @sort = '' SET @sort = 's.Acct'

  IF @page = 0  -- Don't do paging
 	  BEGIN
 	 	SET @STMT = 
 	 	 	'SELECT
 	 	 	 	s.act_amount + s.com_amount AS [ActualCommit],
 	 	 	 	CASE WHEN h.update_type = ''F'' THEN s.fac_units
 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN s.total_budget_units
 	 	 	 	 	 	ELSE s.eac_units
 	 	 	 	END AS [BudgetUnits],
 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN
 	 	 	 	 	CASE WHEN h.update_type = ''R'' THEN 
 	 	 	 	 	 	 	CASE WHEN s.eac_units <> 0 THEN s.eac_amount + c.Amount / s.eac_units ELSE 0 END
 	 	 	 	 	 	WHEN h.update_type = ''F'' THEN 
 	 	 	 	 	 	 	CASE WHEN s.fac_units <> 0 THEN s.fac_amount + c.Amount / s.fac_units ELSE 0 END
 	 	 	 	 	 	ELSE 
 	 	 	 	 	 	 	CASE WHEN s.total_budget_units <> 0
 	 	 	 	 	 	 	THEN s.total_budget_amount + c.Amount / s.total_budget_units ELSE 0 END
 	 	 	 	 	END
 	 	 	 	ELSE
 	 	 	 	 	CASE WHEN h.update_type = ''R'' THEN 
 	 	 	 	 	 	 	CASE WHEN s.eac_units <> 0 THEN c.Amount / s.eac_units ELSE 0 END
 	 	 	 	 	 	WHEN h.update_type = ''F'' THEN 
 	 	 	 	 	 	 	CASE WHEN s.fac_units <> 0 THEN c.Amount / s.fac_units ELSE 0 END
 	 	 	 	 	 	ELSE 
 	 	 	 	 	 	 	CASE WHEN s.total_budget_units <> 0
 	 	 	 	 	 	 	THEN c.Amount / s.total_budget_units ELSE 0 END
 	 	 	 	 	END
 	 	 	 	END AS [Rate], -- BudgetAmount / BudgetUnits
 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN
 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN s.fac_amount + c.Amount
 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN s.total_budget_amount + c.Amount
 	 	 	 	 	 	ELSE s.eac_amount + c.Amount
 	 	 	 	 	END
 	 	 	 	 	ELSE c.Amount
 	 	 	 	END AS [BudgetAmount],
 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN
 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN c.Amount + s.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN c.Amount + s.total_budget_amount
 	 	 	 	 	 	 	ELSE c.Amount + s.eac_amount
 	 	 	 	 	END
 	 	 	 	ELSE
 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN s.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN s.total_budget_amount
 	 	 	 	 	 	 	ELSE s.eac_amount
 	 	 	 	 	END
 	 	 	 	END - (s.act_amount + s.com_amount) AS [EstimateToComplete],
 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN c.Amount
 	 	 	 	 	ELSE CASE WHEN h.update_type = ''F'' THEN c.Amount - s.fac_amount
 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN c.Amount - s.total_budget_amount
 	 	 	 	 	 	ELSE c.Amount - s.eac_amount
 	 	 	 	 	END
 	 	 	 	END AS NetChangeAmount,
 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN c.Units
 	 	 	 	 	ELSE CASE WHEN h.update_type = ''F'' THEN c.Units - s.fac_units
 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN c.Units - s.total_budget_units
 	 	 	 	 	 	ELSE c.Units - s.eac_units
 	 	 	 	 	END
 	 	 	 	END AS NetChangeUnits
 	 	 	FROM PJREVHDR h
 	 	 	 	INNER JOIN PJREVTSK t
 	 	 	 	 	INNER JOIN PJREVCAT c
 	 	 	 	 	 	INNER JOIN PJPTDSUM s
 	 	 	 	 	 	ON s.project = c.project AND s.pjt_entity = c.pjt_entity AND s.acct = c.Acct
 	 	 	 	 	ON c.pjt_entity = t.pjt_entity AND c.project = t.project AND c.RevId = t.revid
 	 	 	 	ON t.project = h.Project AND t.revid = h.RevId
 	 	 	WHERE s.project = ' + quotename(@parm1,'''') + '
 	 	 	 	AND s.pjt_entity = ' + quotename(@parm3,'''') + '
 	 	 	 	AND s.acct = ' + quotename(@parm4,'''') + '
 	 	 	 	AND h.RevId = ' + quotename(@parm2,'''') + '
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
 	 	 	 	SELECT TOP(' + CONVERT(varchar(9), @ubound-1) + ')
 	 	 	 	 	s.act_amount + s.com_amount AS [ActualCommit],
 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN s.fac_units
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN s.total_budget_units
 	 	 	 	 	 	 	ELSE s.eac_units
 	 	 	 	 	END AS [BudgetUnits],
 	 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''R'' THEN 
 	 	 	 	 	 	 	 	CASE WHEN s.eac_units <> 0 THEN s.eac_amount + c.Amount / s.eac_units ELSE 0 END
 	 	 	 	 	 	 	WHEN h.update_type = ''F'' THEN 
 	 	 	 	 	 	 	 	CASE WHEN s.fac_units <> 0 THEN s.fac_amount + c.Amount / s.fac_units ELSE 0 END
 	 	 	 	 	 	 	ELSE 
 	 	 	 	 	 	 	 	CASE WHEN s.total_budget_units <> 0
 	 	 	 	 	 	 	 	THEN s.total_budget_amount + c.Amount / s.total_budget_units ELSE 0 END
 	 	 	 	 	 	END
 	 	 	 	 	ELSE
 	 	 	 	 	 	CASE WHEN h.update_type = ''R'' THEN 
 	 	 	 	 	 	 	 	CASE WHEN s.eac_units <> 0 THEN c.Amount / s.eac_units ELSE 0 END
 	 	 	 	 	 	 	WHEN h.update_type = ''F'' THEN 
 	 	 	 	 	 	 	 	CASE WHEN s.fac_units <> 0 THEN c.Amount / s.fac_units ELSE 0 END
 	 	 	 	 	 	 	ELSE 
 	 	 	 	 	 	 	 	CASE WHEN s.total_budget_units <> 0
 	 	 	 	 	 	 	 	THEN c.Amount / s.total_budget_units ELSE 0 END
 	 	 	 	 	 	END
 	 	 	 	 	END AS [Rate], -- BudgetAmount / BudgetUnits
 	 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN s.fac_amount + c.Amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN s.total_budget_amount + c.Amount
 	 	 	 	 	 	 	ELSE s.eac_amount + c.Amount
 	 	 	 	 	 	END
 	 	 	 	 	 	ELSE c.Amount
 	 	 	 	 	END AS [BudgetAmount],
 	 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN c.Amount + s.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN c.Amount + s.total_budget_amount
 	 	 	 	 	 	 	 	ELSE c.Amount + s.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	ELSE
 	 	 	 	 	 	CASE WHEN h.update_type = ''F'' THEN s.fac_amount
 	 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN s.total_budget_amount
 	 	 	 	 	 	 	 	ELSE s.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	END - (s.act_amount + s.com_amount) AS [EstimateToComplete],
 	 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN c.Amount
 	 	 	 	 	 	ELSE CASE WHEN h.update_type = ''F'' THEN c.Amount - s.fac_amount
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN c.Amount - s.total_budget_amount
 	 	 	 	 	 	 	ELSE c.Amount - s.eac_amount
 	 	 	 	 	 	END
 	 	 	 	 	END AS NetChangeAmount,
 	 	 	 	 	CASE WHEN h.revisiontype = ''NT'' THEN c.Units
 	 	 	 	 	 	ELSE CASE WHEN h.update_type = ''F'' THEN c.Units - s.fac_units
 	 	 	 	 	 	 	WHEN h.update_type = ''O'' THEN c.Units - s.total_budget_units
 	 	 	 	 	 	 	ELSE c.Units - s.eac_units
 	 	 	 	 	 	END
 	 	 	 	 	END AS NetChangeUnits
 	 	 	 	 	,ROW_NUMBER() OVER(ORDER BY ' + @sort + ') AS row
 	 	 	 	FROM PJREVHDR h
 	 	 	 	 	INNER JOIN PJREVTSK t
 	 	 	 	 	 	INNER JOIN PJREVCAT c
 	 	 	 	 	 	 	INNER JOIN PJPTDSUM s
 	 	 	 	 	 	 	ON s.project = c.project AND s.pjt_entity = c.pjt_entity AND s.acct = c.Acct
 	 	 	 	 	 	ON c.pjt_entity = t.pjt_entity AND c.project = t.project AND c.RevId = t.revid
 	 	 	 	 	ON t.project = h.Project AND t.revid = h.RevId
 	 	 	 	WHERE s.project = ' + quotename(@parm1,'''') + '
 	 	 	 	 	AND s.pjt_entity = ' + quotename(@parm3,'''') + '
 	 	 	 	 	AND s.acct = ' + quotename(@parm4,'''') + '
 	 	 	 	 	AND h.RevId = ' + quotename(@parm2,'''') + '
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
    ON OBJECT::[dbo].[WSL_ProjectBudgetRevisionCalculations] TO [MSDSL]
    AS [dbo];


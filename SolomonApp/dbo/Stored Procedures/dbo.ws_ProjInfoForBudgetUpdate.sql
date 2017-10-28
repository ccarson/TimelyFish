
Create PROC ws_ProjInfoForBudgetUpdate @ProjectId VarChar(16)
AS
    SELECT Project, MSPInterface, status_pa, budget_type, labor_gl_acct,
           budget_version, rate_table_id, status_14
      FROM PJProj
     WHERE Project = @ProjectId


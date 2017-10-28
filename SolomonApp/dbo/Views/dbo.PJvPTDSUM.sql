

CREATE VIEW [dbo].[PJvPTDSUM]
AS
SELECT     dbo.PJPTDSUM.acct AS AccountCategory, dbo.PJACCT.acct_desc AS AccountDescription, dbo.PJACCT.acct_status AS AccountStatus, 
                      dbo.PJACCT.acct_type AS AccountType, dbo.PJACCT.id1_sw AS AccountBudgeted, dbo.PJACCT.sort_num AS AccountSortNumber, 
                      dbo.PJPTDSUM.act_amount AS ActualAmount, dbo.PJPTDSUM.act_units AS ActualUnits, dbo.PJPTDSUM.com_amount AS CommitmentAmount, 
                      dbo.PJPTDSUM.com_units AS CommitmentUnits, dbo.PJPTDSUM.crtd_datetime AS CreatedDateTime, dbo.PJPTDSUM.crtd_prog AS CreatedProgram, 
                      dbo.PJPTDSUM.crtd_user AS CreatedUser, dbo.PJPTDSUM.eac_amount AS EstimateAtCompletionAmount, dbo.PJPTDSUM.eac_units AS EstimateAtCompletionUnits, 
                      dbo.PJPTDSUM.fac_amount AS ForecastAtCompletionAmount, dbo.PJPTDSUM.fac_units AS ForecastAtCompletionUnits, 
                      dbo.PJPTDSUM.lupd_datetime AS LastUpdatedDateTime, dbo.PJPTDSUM.lupd_prog AS LastUpdatedProgram, dbo.PJPTDSUM.lupd_user AS LastUpdatedUser, 
                      dbo.PJPTDSUM.ProjCury_act_amount AS ProjectCurrency_ActualAmount, dbo.PJPTDSUM.ProjCury_com_amount AS ProjectCurrency_CommitmentAmount,
                      dbo.PJPTDSUM.ProjCury_eac_amount AS ProjectCurrency_EstimateAtCompletionAmount, dbo.PJPTDSUM.ProjCury_fac_amount AS ProjectCurrency_ForecastAtCompletionAmount,
                      dbo.PJPTDSUM.ProjCury_tot_bud_amt AS ProjectCurrency_OriginalBudgetAmount, dbo.PJPTDSUM.ProjCury_rate AS ProjectCurrency_Rate,
                      dbo.PJPTDSUM.project, dbo.PJPTDSUM.pjt_entity AS task, dbo.PJPTDSUM.total_budget_amount AS OriginalBudgetAmount, 
                      dbo.PJPTDSUM.total_budget_units AS OriginalBudgetUnits, dbo.PJPTDSUM.user1 AS User1, dbo.PJPTDSUM.user2 AS User2, dbo.PJPTDSUM.user3 AS User3, 
                      dbo.PJPTDSUM.user4 AS User4
FROM         dbo.PJPTDSUM INNER JOIN
                      dbo.PJACCT ON dbo.PJPTDSUM.acct = dbo.PJACCT.acct

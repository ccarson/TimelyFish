

CREATE VIEW [dbo].[PJvPTDROL]
AS
SELECT     dbo.PJPTDROL.acct AS AccountCategory, dbo.PJACCT.acct_desc AS AccountDescription, dbo.PJACCT.acct_status AS AccountStatus, 
                      dbo.PJACCT.acct_type AS AccountType, dbo.PJACCT.id1_sw AS AccountBudgeted, dbo.PJACCT.sort_num AS AccountSortNumber, 
                      dbo.PJPTDROL.act_amount AS ActualAmount, dbo.PJPTDROL.act_units AS ActualUnits, dbo.PJPTDROL.com_amount AS CommitmentAmount, 
                      dbo.PJPTDROL.com_units AS CommitmentUnits, dbo.PJPTDROL.crtd_datetime AS CreatedDateTime, dbo.PJPTDROL.crtd_prog AS CreatedProgram, 
                      dbo.PJPTDROL.crtd_user AS CreatedUser, dbo.PJPTDROL.eac_amount AS EstimateAtCompletionAmount, dbo.PJPTDROL.eac_units AS EstimateAtCompletionUnits, 
                      dbo.PJPTDROL.fac_amount AS ForecastAtCompletionAmount, dbo.PJPTDROL.fac_units AS ForecastAtCompletionUnits, 
                      dbo.PJPTDROL.lupd_datetime AS LastUpdatedDateTime, dbo.PJPTDROL.lupd_prog AS LastUpdatedProgram, dbo.PJPTDROL.lupd_user AS LastUpdatedUser,
                      dbo.PJPTDROL.ProjCury_act_amount AS ProjectCurrency_ActualAmount, dbo.PJPTDROL.ProjCury_com_amount AS ProjectCurrency_CommitmentAmount, 
                      dbo.PJPTDROL.ProjCury_eac_amount AS ProjectCurrency_EstimateAtCompletionAmount, dbo.PJPTDROL.ProjCury_fac_amount AS ProjectCurrency_ForecastAtCompletionAmount, 
                      dbo.PJPTDROL.ProjCury_tot_bud_amt AS ProjectCurrency_OriginalBudgetAmount, dbo.PJPTDROL.ProjCury_rate AS ProjectCurrency_Rate, 
                      dbo.PJPTDROL.project, dbo.PJPTDROL.total_budget_amount AS OriginalBudgetAmount, dbo.PJPTDROL.total_budget_units AS OriginalBudgetUnits, 
                      dbo.PJPTDROL.user1 AS User1, dbo.PJPTDROL.user2 AS User2, dbo.PJPTDROL.user3 AS User3, dbo.PJPTDROL.user4 AS User4
FROM         dbo.PJPTDROL INNER JOIN
                      dbo.PJACCT ON dbo.PJPTDROL.acct = dbo.PJACCT.acct


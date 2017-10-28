

CREATE VIEW [dbo].[PJvACTROL]
AS
SELECT     dbo.PJACTROL.acct AS AccountCategory, dbo.PJACCT.acct_desc AS AccountDescription, dbo.PJACCT.acct_status AS AccountStatus, 
                      dbo.PJACCT.acct_type AS AccountType, dbo.PJACCT.id1_sw AS AccountBudgeted, dbo.PJACCT.sort_num AS AccountSortNumber, 
                      dbo.PJACTROL.amount_01 AS Amount_Period_01, dbo.PJACTROL.amount_02 AS Amount_Period_02, dbo.PJACTROL.amount_03 AS Amount_Period_03, 
                      dbo.PJACTROL.amount_04 AS Amount_Period_04, dbo.PJACTROL.amount_05 AS Amount_Period_05, dbo.PJACTROL.amount_06 AS Amount_Period_06, 
                      dbo.PJACTROL.amount_07 AS Amount_Period_07, dbo.PJACTROL.amount_08 AS Amount_Period_08, dbo.PJACTROL.amount_09 AS Amount_Period_09, 
                      dbo.PJACTROL.amount_10 AS Amount_Period_10, dbo.PJACTROL.amount_11 AS Amount_Period_11, dbo.PJACTROL.amount_12 AS Amount_Period_12, 
                      dbo.PJACTROL.amount_13 AS Amount_Period_13, dbo.PJACTROL.amount_14 AS Amount_Period_14, dbo.PJACTROL.amount_15 AS Amount_Period_15, 
                      dbo.PJACTROL.amount_bf AS BalanceForwardAmount, dbo.PJACTROL.crtd_datetime AS CreatedDateTime, dbo.PJACTROL.crtd_prog AS CreatedProgram, 
                      dbo.PJACTROL.crtd_user AS CreatedUser, dbo.PJACTROL.fsyear_num AS FiscalYear, dbo.PJACTROL.lupd_datetime AS LastUpdatedDateTime, 
                      dbo.PJACTROL.lupd_prog AS LastUpdatedProgram, dbo.PJACTROL.lupd_user AS LastUpdatedUser, 
                      dbo.PJACTROL.projcury_amount_01 AS ProjectCurrency_Amount_Period_01, dbo.PJACTROL.projcury_amount_02 AS ProjectCurrency_Amount_Period_02, dbo.PJACTROL.projcury_amount_03 AS ProjectCurrency_Amount_Period_03, 
                      dbo.PJACTROL.projcury_amount_04 AS ProjectCurrency_Amount_Period_04, dbo.PJACTROL.projcury_amount_05 AS ProjectCurrency_Amount_Period_05, dbo.PJACTROL.projcury_amount_06 AS ProjectCurrency_Amount_Period_06, 
                      dbo.PJACTROL.projcury_amount_07 AS ProjectCurrency_Amount_Period_07, dbo.PJACTROL.projcury_amount_08 AS ProjectCurrency_Amount_Period_08, dbo.PJACTROL.projcury_amount_09 AS ProjectCurrency_Amount_Period_09, 
                      dbo.PJACTROL.projcury_amount_10 AS ProjectCurrency_Amount_Period_10, dbo.PJACTROL.projcury_amount_11 AS ProjectCurrency_Amount_Period_11, dbo.PJACTROL.projcury_amount_12 AS ProjectCurrency_Amount_Period_12, 
                      dbo.PJACTROL.projcury_amount_13 AS ProjectCurrency_Amount_Period_13, dbo.PJACTROL.projcury_amount_14 AS ProjectCurrency_Amount_Period_14, dbo.PJACTROL.projcury_amount_15 AS ProjectCurrency_Amount_Period_15, 
                      dbo.PJACTROL.projcury_amount_bf AS ProjectCurrency_BalanceForwardAmount,
                      dbo.PJACTROL.project, 
                      dbo.PJACTROL.units_01 AS Units_Period_01, dbo.PJACTROL.units_02 AS Units_Period_02, dbo.PJACTROL.units_03 AS Units_Period_03, 
                      dbo.PJACTROL.units_04 AS Units_Period_04, dbo.PJACTROL.units_05 AS Units_Period_05, dbo.PJACTROL.units_06 AS Units_Period_06, 
                      dbo.PJACTROL.units_07 AS Units_Period_07, dbo.PJACTROL.units_08 AS Units_Period_08, dbo.PJACTROL.units_09 AS Units_Period_09, 
                      dbo.PJACTROL.units_10 AS Units_Period_10, dbo.PJACTROL.units_11 AS Units_Period_11, dbo.PJACTROL.units_12 AS Units_Period_12, 
                      dbo.PJACTROL.units_13 AS Units_Period_13, dbo.PJACTROL.units_14 AS Units_Period_14, dbo.PJACTROL.units_15 AS Units_Period_15, 
                      dbo.PJACTROL.units_bf AS BalanceForwardUnits
FROM         dbo.PJACTROL INNER JOIN
                      dbo.PJACCT ON dbo.PJACTROL.acct = dbo.PJACCT.acct


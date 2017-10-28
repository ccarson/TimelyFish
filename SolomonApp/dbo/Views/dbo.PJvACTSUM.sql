

CREATE VIEW [dbo].[PJvACTSUM]
AS
SELECT     dbo.PJACTSUM.acct AS AccountCategory, dbo.PJACCT.acct_desc AS AccountDescription, dbo.PJACCT.acct_status AS AccountStatus, 
                      dbo.PJACCT.acct_type AS AccountType, dbo.PJACCT.id1_sw AS AccountBudgeted, dbo.PJACCT.sort_num AS AccountSortNumber, 
                      dbo.PJACTSUM.amount_01 AS Amount_Period_01, dbo.PJACTSUM.amount_02 AS Amount_Period_02, dbo.PJACTSUM.amount_03 AS Amount_Period_03, 
                      dbo.PJACTSUM.amount_04 AS Amount_Period_04, dbo.PJACTSUM.amount_05 AS Amount_Period_05, dbo.PJACTSUM.amount_06 AS Amount_Period_06, 
                      dbo.PJACTSUM.amount_07 AS Amount_Period_07, dbo.PJACTSUM.amount_08 AS Amount_Period_08, dbo.PJACTSUM.amount_09 AS Amount_Period_09, 
                      dbo.PJACTSUM.amount_10 AS Amount_Period_10, dbo.PJACTSUM.amount_11 AS Amount_Period_11, dbo.PJACTSUM.amount_12 AS Amount_Period_12, 
                      dbo.PJACTSUM.amount_13 AS Amount_Period_13, dbo.PJACTSUM.amount_14 AS Amount_Period_14, dbo.PJACTSUM.amount_15 AS Amount_Period_15, 
                      dbo.PJACTSUM.amount_bf AS BalanceForwardAmount, dbo.PJACTSUM.crtd_datetime AS CreatedDateTime, dbo.PJACTSUM.crtd_prog AS CreatedProgram, 
                      dbo.PJACTSUM.crtd_user AS CreatedUser, dbo.PJACTSUM.fsyear_num AS FiscalYear, dbo.PJACTSUM.lupd_datetime AS LastUpdatedDateTime, 
                      dbo.PJACTSUM.lupd_prog AS LastUpdatedProgram, dbo.PJACTSUM.lupd_user AS LastUpdatedUser, 
                      dbo.PJACTSUM.ProjCury_amount_01 AS ProjectCurrency_Amount_Period_01, dbo.PJACTSUM.ProjCury_amount_02 AS ProjectCurrency_Amount_Period_02, dbo.PJACTSUM.ProjCury_amount_03 AS ProjectCurrency_Amount_Period_03, 
                      dbo.PJACTSUM.ProjCury_amount_04 AS ProjectCurrency_Amount_Period_04, dbo.PJACTSUM.ProjCury_amount_05 AS ProjectCurrency_Amount_Period_05, dbo.PJACTSUM.ProjCury_amount_06 AS ProjectCurrency_Amount_Period_06, 
                      dbo.PJACTSUM.ProjCury_amount_07 AS ProjectCurrency_Amount_Period_07, dbo.PJACTSUM.ProjCury_amount_08 AS ProjectCurrency_Amount_Period_08, dbo.PJACTSUM.ProjCury_amount_09 AS ProjectCurrency_Amount_Period_09, 
                      dbo.PJACTSUM.ProjCury_amount_10 AS ProjectCurrency_Amount_Period_10, dbo.PJACTSUM.ProjCury_amount_11 AS ProjectCurrency_Amount_Period_11, dbo.PJACTSUM.ProjCury_amount_12 AS ProjectCurrency_Amount_Period_12, 
                      dbo.PJACTSUM.ProjCury_amount_13 AS ProjectCurrency_Amount_Period_13, dbo.PJACTSUM.ProjCury_amount_14 AS ProjectCurrency_Amount_Period_14, dbo.PJACTSUM.ProjCury_amount_15 AS ProjectCurrency_Amount_Period_15, 
                      dbo.PJACTSUM.ProjCury_amount_bf AS ProjectCurrency_BalanceForwardAmount,
                      dbo.PJACTSUM.project, dbo.PJACTSUM.pjt_entity AS task, 
                      dbo.PJACTSUM.units_01 AS Units_Period_01, dbo.PJACTSUM.units_02 AS Units_Period_02, dbo.PJACTSUM.units_03 AS Units_Period_03, 
                      dbo.PJACTSUM.units_04 AS Units_Period_04, dbo.PJACTSUM.units_05 AS Units_Period_05, dbo.PJACTSUM.units_06 AS Units_Period_06, 
                      dbo.PJACTSUM.units_07 AS Units_Period_07, dbo.PJACTSUM.units_08 AS Units_Period_08, dbo.PJACTSUM.units_09 AS Units_Period_09, 
                      dbo.PJACTSUM.units_10 AS Units_Period_10, dbo.PJACTSUM.units_11 AS Units_Period_11, dbo.PJACTSUM.units_12 AS Units_Period_12, 
                      dbo.PJACTSUM.units_13 AS Units_Period_13, dbo.PJACTSUM.units_14 AS Units_Period_14, dbo.PJACTSUM.units_15 AS Units_Period_15, 
                      dbo.PJACTSUM.units_bf AS BalanceForwardUnits
FROM         dbo.PJACTSUM INNER JOIN
                      dbo.PJACCT ON dbo.PJACTSUM.acct = dbo.PJACCT.acct


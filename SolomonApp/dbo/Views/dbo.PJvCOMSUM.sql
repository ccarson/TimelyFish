

CREATE VIEW [dbo].[PJvCOMSUM]
AS
SELECT     dbo.PJCOMSUM.acct AS AccountCategory, dbo.PJACCT.acct_desc AS AccountDescription, dbo.PJACCT.acct_status AS AccountStatus, 
                      dbo.PJACCT.acct_type AS AccountType, dbo.PJACCT.id1_sw AS AccountBudgeted, dbo.PJACCT.sort_num AS AccountSortNumber, 
                      dbo.PJCOMSUM.amount_01 AS Amount_Period_01, dbo.PJCOMSUM.amount_02 AS Amount_Period_02, dbo.PJCOMSUM.amount_03 AS Amount_Period_03, 
                      dbo.PJCOMSUM.amount_04 AS Amount_Period_04, dbo.PJCOMSUM.amount_05 AS Amount_Period_05, dbo.PJCOMSUM.amount_06 AS Amount_Period_06, 
                      dbo.PJCOMSUM.amount_07 AS Amount_Period_07, dbo.PJCOMSUM.amount_08 AS Amount_Period_08, dbo.PJCOMSUM.amount_09 AS Amount_Period_09, 
                      dbo.PJCOMSUM.amount_10 AS Amount_Period_10, dbo.PJCOMSUM.amount_11 AS Amount_Period_11, dbo.PJCOMSUM.amount_12 AS Amount_Period_12, 
                      dbo.PJCOMSUM.amount_13 AS Amount_Period_13, dbo.PJCOMSUM.amount_14 AS Amount_Period_14, dbo.PJCOMSUM.amount_15 AS Amount_Period_15, 
                      dbo.PJCOMSUM.amount_bf AS BalanceForwardAmount, dbo.PJCOMSUM.crtd_datetime AS CreatedDateTime, dbo.PJCOMSUM.crtd_prog AS CreatedProgram, 
                      dbo.PJCOMSUM.crtd_user AS CreatedUser, dbo.PJCOMSUM.fsyear_num AS FiscalYear, dbo.PJCOMSUM.project, dbo.PJCOMSUM.pjt_entity AS task, 
                      dbo.PJCOMSUM.lupd_datetime AS LastUpdatedDateTime, dbo.PJCOMSUM.lupd_prog AS LastUpdatedProgram, dbo.PJCOMSUM.lupd_user AS LastUpdatedUser, 
                      dbo.PJCOMSUM.ProjCury_amount_01 AS ProjectCurrency_Amount_Period_01, dbo.PJCOMSUM.ProjCury_amount_02 AS ProjectCurrency_Amount_Period_02,
                      dbo.PJCOMSUM.ProjCury_amount_03 AS ProjectCurrency_Amount_Period_03, dbo.PJCOMSUM.ProjCury_amount_04 AS ProjectCurrency_Amount_Period_04,
                      dbo.PJCOMSUM.ProjCury_amount_05 AS ProjectCurrency_Amount_Period_05, dbo.PJCOMSUM.ProjCury_amount_06 AS ProjectCurrency_Amount_Period_06, 
                      dbo.PJCOMSUM.ProjCury_amount_07 AS ProjectCurrency_Amount_Period_07, dbo.PJCOMSUM.ProjCury_amount_08 AS ProjectCurrency_Amount_Period_08,
                      dbo.PJCOMSUM.ProjCury_amount_09 AS ProjectCurrency_Amount_Period_09, dbo.PJCOMSUM.ProjCury_amount_10 AS ProjectCurrency_Amount_Period_10,
                      dbo.PJCOMSUM.ProjCury_amount_11 AS ProjectCurrency_Amount_Period_11, dbo.PJCOMSUM.ProjCury_amount_12 AS ProjectCurrency_Amount_Period_12, 
                      dbo.PJCOMSUM.ProjCury_amount_13 AS ProjectCurrency_Amount_Period_13, dbo.PJCOMSUM.ProjCury_amount_14 AS ProjectCurrency_Amount_Period_14,
                      dbo.PJCOMSUM.ProjCury_amount_15 AS ProjectCurrency_Amount_Period_15, dbo.PJCOMSUM.ProjCury_amount_bf AS ProjectCurrency_BalanceForwardAmount, 
                      dbo.PJCOMSUM.units_01 AS Units_Period_01, dbo.PJCOMSUM.units_02 AS Units_Period_02, dbo.PJCOMSUM.units_03 AS Units_Period_03, 
                      dbo.PJCOMSUM.units_04 AS Units_Period_04, dbo.PJCOMSUM.units_05 AS Units_Period_05, dbo.PJCOMSUM.units_06 AS Units_Period_06, 
                      dbo.PJCOMSUM.units_07 AS Units_Period_07, dbo.PJCOMSUM.units_08 AS Units_Period_08, dbo.PJCOMSUM.units_09 AS Units_Period_09, 
                      dbo.PJCOMSUM.units_10 AS Units_Period_10, dbo.PJCOMSUM.units_11 AS Units_Period_11, dbo.PJCOMSUM.units_12 AS Units_Period_12, 
                      dbo.PJCOMSUM.units_13 AS Units_Period_13, dbo.PJCOMSUM.units_14 AS Units_Period_14, dbo.PJCOMSUM.units_15 AS Units_Period_15, 
                      dbo.PJCOMSUM.units_bf AS BalanceForwardUnits
FROM         dbo.PJCOMSUM INNER JOIN
                      dbo.PJACCT ON dbo.PJCOMSUM.acct = dbo.PJACCT.acct

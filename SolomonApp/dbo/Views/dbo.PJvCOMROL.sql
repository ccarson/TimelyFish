

CREATE VIEW [dbo].[PJvCOMROL]
AS
SELECT     dbo.PJCOMROL.acct AS AccountCategory, dbo.PJACCT.acct_desc AS AccountDescription, dbo.PJACCT.acct_status AS AccountStatus, 
                      dbo.PJACCT.acct_type AS AccountType, dbo.PJACCT.id1_sw AS AccountBudgeted, dbo.PJACCT.sort_num AS AccountSortNumber, 
                      dbo.PJCOMROL.amount_01 AS Amount_Period_01, dbo.PJCOMROL.amount_02 AS Amount_Period_02, dbo.PJCOMROL.amount_03 AS Amount_Period_03, 
                      dbo.PJCOMROL.amount_04 AS Amount_Period_04, dbo.PJCOMROL.amount_05 AS Amount_Period_05, dbo.PJCOMROL.amount_06 AS Amount_Period_06, 
                      dbo.PJCOMROL.amount_07 AS Amount_Period_07, dbo.PJCOMROL.amount_08 AS Amount_Period_08, dbo.PJCOMROL.amount_09 AS Amount_Period_09, 
                      dbo.PJCOMROL.amount_10 AS Amount_Period_10, dbo.PJCOMROL.amount_11 AS Amount_Period_11, dbo.PJCOMROL.amount_12 AS Amount_Period_12, 
                      dbo.PJCOMROL.amount_13 AS Amount_Period_13, dbo.PJCOMROL.amount_14 AS Amount_Period_14, dbo.PJCOMROL.amount_15 AS Amount_Period_15, 
                      dbo.PJCOMROL.amount_bf AS BalanceForwardAmount, dbo.PJCOMROL.crtd_datetime AS CreatedDateTime, dbo.PJCOMROL.crtd_prog AS CreatedProgram, 
                      dbo.PJCOMROL.crtd_user AS CreatedUser, dbo.PJCOMROL.fsyear_num AS FiscalYear, dbo.PJCOMROL.lupd_datetime AS LastUpdatedDateTime, 
                      dbo.PJCOMROL.lupd_prog AS LastUpdatedProgram, dbo.PJCOMROL.lupd_user AS LastUpdatedUser, dbo.PJCOMROL.project, 
                      dbo.PJCOMROL.ProjCury_amount_01 AS ProjectCurrency_Amount_Period_01, dbo.PJCOMROL.ProjCury_amount_02 AS ProjectCurrency_Amount_Period_02,
                      dbo.PJCOMROL.ProjCury_amount_03 AS ProjectCurrency_Amount_Period_03, dbo.PJCOMROL.ProjCury_amount_04 AS ProjectCurrency_Amount_Period_04,
                      dbo.PJCOMROL.ProjCury_amount_05 AS ProjectCurrency_Amount_Period_05, dbo.PJCOMROL.ProjCury_amount_06 AS ProjectCurrency_Amount_Period_06, 
                      dbo.PJCOMROL.ProjCury_amount_07 AS ProjectCurrency_Amount_Period_07, dbo.PJCOMROL.ProjCury_amount_08 AS ProjectCurrency_Amount_Period_08,
                      dbo.PJCOMROL.ProjCury_amount_09 AS ProjectCurrency_Amount_Period_09, dbo.PJCOMROL.ProjCury_amount_10 AS ProjectCurrency_Amount_Period_10,
                      dbo.PJCOMROL.ProjCury_amount_11 AS ProjectCurrency_Amount_Period_11, dbo.PJCOMROL.ProjCury_amount_12 AS ProjectCurrency_Amount_Period_12, 
                      dbo.PJCOMROL.ProjCury_amount_13 AS ProjectCurrency_Amount_Period_13, dbo.PJCOMROL.ProjCury_amount_14 AS ProjectCurrency_Amount_Period_14,
                      dbo.PJCOMROL.ProjCury_amount_15 AS ProjectCurrency_Amount_Period_15, dbo.PJCOMROL.ProjCury_amount_bf AS ProjectCurrency_BalanceForwardAmount, 
                      dbo.PJCOMROL.units_01 AS Units_Period_01, dbo.PJCOMROL.units_02 AS Units_Period_02, dbo.PJCOMROL.units_03 AS Units_Period_03, 
                      dbo.PJCOMROL.units_04 AS Units_Period_04, dbo.PJCOMROL.units_05 AS Units_Period_05, dbo.PJCOMROL.units_06 AS Units_Period_06, 
                      dbo.PJCOMROL.units_07 AS Units_Period_07, dbo.PJCOMROL.units_08 AS Units_Period_08, dbo.PJCOMROL.units_09 AS Units_Period_09, 
                      dbo.PJCOMROL.units_10 AS Units_Period_10, dbo.PJCOMROL.units_11 AS Units_Period_11, dbo.PJCOMROL.units_12 AS Units_Period_12, 
                      dbo.PJCOMROL.units_13 AS Units_Period_13, dbo.PJCOMROL.units_14 AS Units_Period_14, dbo.PJCOMROL.units_15 AS Units_Period_15, 
                      dbo.PJCOMROL.units_bf AS BalanceForwardUnits
FROM         dbo.PJCOMROL INNER JOIN
                      dbo.PJACCT ON dbo.PJCOMROL.acct = dbo.PJACCT.acct


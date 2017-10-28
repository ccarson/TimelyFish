CREATE VIEW [dbo].[QQFinancialSummaryDetails]
AS
SELECT        Rev.project AS Project, Rev.RevenueActuals, Rev.ComRev AS RevenueCommitments, Rev.RevenueActuals + Rev.ComRev AS [RevenueAct+Com], 
                         Rev.EACRev AS RevenueEAC, Rev.EACRev - (Rev.RevenueActuals + Rev.ComRev) AS RevenueETC, Ex.ExpenseActuals, 
                         Ex.ComExp AS ExpenseCommitments, Ex.ExpenseActuals + Ex.ComExp AS [ExpenseAct+Com], Ex.EACExp AS ExpenceEAC, 
                         Ex.EACExp - (Ex.ExpenseActuals + Ex.ComExp) AS ExpenseETC, Rev.RevenueActuals - Ex.ExpenseActuals AS MarginActuals, 
                         Rev.ComRev - Ex.ComExp AS MarginCommitments, (Rev.RevenueActuals + Rev.ComRev) - (Ex.ExpenseActuals + Ex.ComExp) AS [MarginAct+Com], 
                         Rev.EACRev - Ex.EACExp AS MarginEAC, (Rev.EACRev - (Rev.RevenueActuals + Rev.ComRev)) - (Ex.EACExp - (Ex.ExpenseActuals + Ex.ComExp)) 
                         AS MarginETC
FROM            (SELECT        R.project, SUM(R.act_amount) AS RevenueActuals, SUM(R.com_amount) AS ComRev, SUM(R.eac_amount) AS EACRev
                          FROM            dbo.PJPTDROL AS R INNER JOIN
                                                    dbo.PJACCT AS A ON R.acct = A.acct
                          WHERE        (A.acct_type = 'RV')
                          GROUP BY R.project) AS Rev INNER JOIN
                             (SELECT        R.project, SUM(R.act_amount) AS ExpenseActuals, SUM(R.com_amount) AS ComExp, SUM(R.eac_amount) AS EACExp
                               FROM            dbo.PJPTDROL AS R INNER JOIN
                                                         dbo.PJACCT AS A ON R.acct = A.acct
                               WHERE        (A.acct_type = 'EX')
                               GROUP BY R.project) AS Ex ON Rev.project = Ex.project


CREATE VIEW [dbo].[QQ_pjbudgettotals]
AS
SELECT T0.[project],
  sum(T0.[act_amount]) + sum(T0.[com_amount]) [Actual + Commit],
  sum(T0.[total_budget_units]) [Original Budget Units],
  sum(T0.[total_budget_amount]) [Original Budget Amount],
  sum(T0.[eac_units]) [EAC Units],
  sum(T0.[eac_amount]) [EAC Amount],
  sum(T0.[fac_units]) [FAC Units],
  sum(T0.[fac_amount]) [FAC Amount],
  sum(T0.[total_budget_amount]) -  sum(T0.[act_amount])  -  sum(T0.[com_amount]) [Estimate To Complete],
        T1.[acct_type] 
FROM [PJPTDSUM] T0 WITH (NOLOCK) INNER JOIN [PJACCT] T1 WITH (NOLOCK) ON (T0.[acct] = T1.[acct]) 
WHERE T1.[acct_type] = 'RV' or T1.[acct_type] = 'EX'
GROUP BY T0.[project] ,T1.[acct_type] 

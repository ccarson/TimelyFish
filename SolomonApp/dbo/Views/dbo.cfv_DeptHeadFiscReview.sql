
CREATE view [dbo].[cfv_DeptHeadFiscReview]
AS
-----------------------------------------------------------------------------ACTUAL DETAIL
SELECT 
 GlTran.Sub As Sub
, SubAcct.Descr As 'Location'
, GLTran.PerPost AS 'WherePeriod'
, GLTran.PerPost AS 'GroupPeriod'
, Account.Descr
, GLTran.TranDesc
, Sum(GLTran.DrAmt-GLTran.CrAmt) As 'Amt'

FROM SolomonApp.dbo.GLTran GLTran (nolock)

LEFT JOIN SolomonApp.dbo.Account Account (nolock)
ON GLTran.Acct = Account.Acct

LEFT JOIN SolomonApp.dbo.SubAcct SubAcct (nolock)
ON GLTran.Sub = SubAcct.Sub

WHERE SubAcct.Active = 1
AND GLTran.Rlsed =1
AND GLTran.PerPost >=200801

GROUP BY
  GLTran.Sub
, SubAcct.Descr
, GLTran.PerPost
, Account.Descr
, GLTran.TranDesc

UNION-----------------------------------------------------------------------ACTUAL SUMMARY--

SELECT 
  GlTran.Sub As Sub
, SubAcct.Descr As 'Location'
, GLTran.PerPost AS 'WherePeriod'
, 'Actual' AS 'GroupPeriod'
, Account.Descr
, '' TranDesc
, Sum(GLTran.DrAmt-GLTran.CrAmt) As 'Amt'

FROM SolomonApp.dbo.GLTran GLTran (nolock)

LEFT JOIN SolomonApp.dbo.Account Account (nolock)
ON GLTran.Acct = Account.Acct

LEFT JOIN SolomonApp.dbo.SubAcct SubAcct (nolock)
ON GLTran.Sub = SubAcct.Sub

WHERE SubAcct.Active = 1
AND GLTran.Rlsed =1
AND GLTran.PerPost >=200801

GROUP BY
  GLTran.Sub
, SubAcct.Descr
, GLTran.PerPost
, Account.Descr

UNION-----------------------------------------------------------------------ACTUAL 2010 SUMMARY--

SELECT 
  GlTran.Sub As Sub
, SubAcct.Descr As 'Location'
, GLTran.PerPost AS 'WherePeriod'
, 'Actual 2010' AS 'GroupPeriod'
, Account.Descr
, '' TranDesc
, Sum(GLTran.DrAmt-GLTran.CrAmt) As 'Amt'

FROM SolomonApp.dbo.GLTran GLTran (nolock)

LEFT JOIN SolomonApp.dbo.Account Account (nolock)
ON GLTran.Acct = Account.Acct

LEFT JOIN SolomonApp.dbo.SubAcct SubAcct (nolock)
ON GLTran.Sub = SubAcct.Sub

WHERE SubAcct.Active = 1
AND GLTran.Rlsed =1
AND GLTran.PerPost >=201001
AND GLTran.PerPost <=201012

GROUP BY
  GLTran.Sub
, SubAcct.Descr
, GLTran.PerPost
, Account.Descr

UNION------------------------------------------------------------------------BUDGET--

Select 
Right(Rtrim(Division),2)+''+Right(RTrim(Department),2)+''+Right(RTrim(Location),4) AS Sub
, SubAcct.Descr AS 'Location'
, '2010'+Right(RTrim(Time),2) AS 'WherePeriod'
, 'Budget'AS 'GroupPeriod'
, Account.Descr
, '' AS 'TranDesc'
, cftFicalBudget.Total AS 'Amt'
From dbo.cftFicalBudget (nolock)

LEFT JOIN SolomonApp.dbo.Account Account (nolock)
ON right(cftFicalBudget.Account,5) = Account.Acct

LEFT JOIN SolomonApp.dbo.SubAcct SubAcct (nolock)
ON Right(cftFicalBudget.Division,2) = Left(SubAcct.Sub,2)
AND Right(cftFicalBudget.Department,2) = Substring(SubAcct.Sub,3,2)
AND Right(cftFicalBudget.Location,4) = Right(Rtrim(SubAcct.Sub),4)

---------------------------------------------------------------------------------VARIANCE--
UNION------------------------
select 
  sub
, location
, whereperiod
, 'Variance' as GroupPeriod
, descr
, trandesc
, sum(case when groupperiod in ('budget') then (amt*-1) else amt end) as amt
FROM (

-------Actual------
Select 
Right(Rtrim(Division),2)+''+Right(RTrim(Department),2)+''+Right(RTrim(Location),4) AS Sub
, SubAcct.Descr AS 'Location'
, '2010'+Right(RTrim(Time),2) AS 'WherePeriod'
, 'Budget'AS 'GroupPeriod'
, Account.Descr
, '' AS 'TranDesc'
, cftFicalBudget.Total AS 'Amt'
From dbo.cftFicalBudget (nolock)

LEFT JOIN SolomonApp.dbo.Account Account (nolock)
ON right(cftFicalBudget.Account,5) = Account.Acct

LEFT JOIN SolomonApp.dbo.SubAcct SubAcct (nolock)
ON Right(cftFicalBudget.Division,2) = Left(SubAcct.Sub,2)
AND Right(cftFicalBudget.Department,2) = Substring(SubAcct.Sub,3,2)
AND Right(cftFicalBudget.Location,4) = Right(Rtrim(SubAcct.Sub),4)
-------Actual------
UNION--------
-------Budget------
SELECT 
  GlTran.Sub As Sub
, SubAcct.Descr As 'Location'
, GLTran.PerPost AS 'WherePeriod'
, 'Actual' AS 'GroupPeriod'
, Account.Descr
, '' TranDesc
, Sum(GLTran.DrAmt-GLTran.CrAmt) As 'Amt'

FROM SolomonApp.dbo.GLTran GLTran (nolock)

LEFT JOIN SolomonApp.dbo.Account Account (nolock)
ON GLTran.Acct = Account.Acct

LEFT JOIN SolomonApp.dbo.SubAcct SubAcct (nolock)
ON GLTran.Sub = SubAcct.Sub

WHERE SubAcct.Active = 1
AND GLTran.Rlsed =1
AND GLTran.PerPost >=201001

GROUP BY
  GLTran.Sub
, SubAcct.Descr
, GLTran.PerPost
, Account.Descr

-------Budget------
) AS DATA

group by 
  sub
, location
, whereperiod
, descr
, trandesc
-----------------------
---------------------------------------------------------------------------------

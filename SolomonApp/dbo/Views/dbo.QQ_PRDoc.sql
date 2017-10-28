
CREATE VIEW [QQ_PRDoc]
AS
select 
Pd.EmpId AS [Employee ID], 
CASE WHEN CHARINDEX('~', e.Name) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(e.Name, 1, 
CHARINDEX('~', e.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(e.Name, CHARINDEX('~', e.Name) + 1, 60)))) 
ELSE e.Name END AS [Name],
E.Department AS [Department], '***-**-' + (SUBSTRING(e.SSN, 6, 4)) As [Social Security Number], 
Pd.Acct AS [Chk Acct], Pd.Sub AS [Subaccount], Pd.ChkNbr AS [Chk Nbr], Pd.CpnyID AS [Company ID], 
Pd.DocType AS [Type], E.PayType AS [Pay Type], Pd.PerEnt AS [Per Ent], Pd.PerPost AS [Per Post], 
convert(date,Pd.ChkDate) AS [Chk Date], Pd.PayPerNbr AS [Pay Per], convert(date,Pd.PayPerStrtDate) AS [Per Beg], convert(date,Pd.PayPerEndDate) AS [Per End], 
 pd.BatNbr AS [Batch Nbr], pd.CalQtr AS [Calendar Qtr], pd.CalYr AS [Calendar Year], 
pd.ClearAmt AS [Clear Amount], convert(date,pd.ClearDate) AS [Clear Date], convert(date,pd.Crtd_DateTime) AS [Create Date], pd.Crtd_Prog AS [Create Program], 
pd.Crtd_User AS [Create User], convert(date,pd.LUpd_DateTime) AS [Last Update Date], pd.LUpd_Prog AS [Last Update Program], pd.LUpd_User AS [Last Update User], 
pd.NoteId AS [Note ID], pd.Rlsed AS [Released], pd.Status AS [Status], pd.StdUnitRate AS [Standard Unit Rate], 
pd.User1 AS [User1], pd.User2 AS [User2], pd.User3 AS [User3], pd.User4 AS [User4], 
pd.User5 AS [User5], pd.User6 AS [User6], convert(date,pd.User7) AS [User7], convert(date,pd.User8) AS [User8]
from PRDoc pd with (nolock)
Left outer join employee e with (nolock)
On pd.EmpId = e.EmpId


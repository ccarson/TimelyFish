
Create view [QQ_employee]
AS
select 
CASE WHEN CHARINDEX('~', e.Name) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(e.Name, 1, 
CHARINDEX('~', e.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(e.Name, CHARINDEX('~', e.Name) + 1, 60)))) 
ELSE e.Name END AS [Name],
e.EmpId AS [Employee ID], Status AS [Status], e.Addr1 AS [Address Line 1], e.Addr2 AS [Address Line 2], e.City AS [City],
e.State AS [State],  e.Zip AS [Zip/Postal Code],e.Country AS [Country/Region],e.EmailAddr AS [Email Address], 
'(' + SUBSTRING(Phone, 1, 3) + ')' + SUBSTRING(Phone,4,3) + '-' + RTRIM(SUBSTRING(Phone,7,24)) AS [Phone/Ext], 
'(' + SUBSTRING(Fax, 1, 3) + ')' + SUBSTRING(Fax,4,3) + '-' + RTRIM(SUBSTRING(Fax,7,24)) AS [Fax/Ext], 
e.CpnyID AS [Company ID], e.Department AS [Department],e.DfltWrkloc AS [Default Work Location], 
e.Shift AS [Shift],e.Attn AS [Attention], convert(date,e.BirthDate) AS [Date of Birth], convert(date,e.StrtDate) AS [Date Employed], convert(date,e.EndDate) AS [Date Terminated], 
convert(date,e.LastPaidDate) AS [Last Paid Date],'***-**-' + (SUBSTRING(e.SSN, 6, 4)) As [Social Security Number], e.MarStat AS [Marital Status], 
e.MagW2 AS [Electronc W-2 Reporting],  e.DfltPersExmpt AS [Nbr Peronal Exemptions], e.DfltOthrExmpt AS [Nbr Other Exemptions], 
e.Statutory AS [Statutory Employee], e.PercentDispEarn AS [Percent of Disposable Earnings], 
e.CalYr AS [Calendar year], 
e.ChkNbr AS [Check Number], convert(date,e.Crtd_DateTime) AS [Create Date], e.Crtd_Prog AS [Create Program], e.Crtd_User AS [Create User], 
e.CurrBatNbr AS [Current Batch Number], e.CurrCheckCalc AS [Current Check Calculated], e.CurrCheckPrint AS [Current Check Printed], 
e.CurrCheckType AS [Current Check Type], e.CurrEarn AS [Current Earnings], e.CurrNet AS [Net Pay], 
convert(date,e.CurrPayPerEndDate) AS [Pay Period End Date], 
e.CurrPayPerNbr AS [Pay Period Nbr], convert(date,e.CurrPayPerStrtDate) AS [Current Pay Period Start Date], e.CurrStdUnitRate AS [Last Standard Unit Rate], 
e.DfltEarnType AS [Default Earnings Type], e.DfltExpAcct AS [Default Expense Account], e.DfltExpSub AS [Default Expense Subaccount], 
e.DirectDeposit AS [Direct Deposit], 
e.HomeUnion AS [Home Union],  convert(date,e.LUpd_DateTime) AS [Last Update Date], 
e.LUpd_Prog AS [Last Update Program], e.LUpd_User AS [Last Update User],
e.MaxGarnWarn AS [Issue Max Garnishment Warning], e.MedGovtEmpl AS [Medicare Qualified], 
e.NoteId AS [NoteID], e.PayGrpId AS [Pay Group ID], e.PayType AS [Pay Type],  
e.Salut AS [Salutation], 
e.StdSlry AS [Standard Salary], e.StdUnitRate AS [Standard Unit Rate], e.User1 AS [User1], 
e.User2 AS [User2], e.User3 AS [User3], e.User4 AS [User4], e.User5 AS [User5], e.User6 AS [User6], 
convert(date,e.User7) AS [User7], convert(date,e.User8) AS [User8], e.WCCode AS [Workers Compensation Code], e.YtdEarn AS [YTD Earnings]
from Employee e with (nolock)


CREATE VIEW [dbo].[QQ_prtran_earn]
AS
select 
pt.BatNbr AS [Batch Number], pt.RefNbr AS [Reference Number], pt.CpnyID AS [Company ID], pt.EmpId AS [Employee ID],
CASE WHEN CHARINDEX('~', e.Name) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(e.Name, 1, 
CHARINDEX('~', e.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(e.Name, CHARINDEX('~', e.Name) + 1, 60)))) 
ELSE e.Name END AS [Name],
pt.TranType AS [Transaction Type], pt.EarnDedId AS [Earnings/Deduction ID], pt.WrkLocId AS [Work Location ID],pt.TranDesc AS [Transaction Description], 
pt.Acct AS [Account],pt.Sub AS [Subaccount], convert(date,pt.TranDate) AS [Transaction Date], pt.PerEnt AS [Periodd Entered],pt.PerPost AS [Period to Post], 
pt.ProjectID AS [Project ID], pt.TaskID AS [Task ID],pt.Qty AS [Units],  pt.UnitPrice AS [Unit Price], pt.RateMult AS [Rate Multiplier], 
pt.DrCr AS [Debit/Credit], pt.TranAmt AS [Transaction Amount],pt.AcctDist AS [Account Distribution], pt.APBatch AS [AP Batch Number], 
pt.APLineId AS [AP Line ID], pt.APRefNbr AS [AP Reference Nbr], pt.ArrgAmt AS [Arrearage Amount], pt.BenClassId AS [Benefit Class ID], 
pt.BenId AS [Benefit ID], pt.Billable AS [Billable], pt.CalQtr AS [Calendar Quarter], pt.CalYr AS [Calendar Year], 
pt.CertPR AS [Certified Payroll Account], pt.ChkAcct AS [Checking Account], pt.ChkSeq AS [Check Sequence Nbr], pt.ChkSub AS [Checking Subaccount], 
pt.CostType AS [Cost Type], convert(date,pt.Crtd_DateTime) AS [Create Date], pt.Crtd_Prog AS [Create Program], pt.Crtd_User AS [Create User], 
pt.DailyOpt AS [Daily Option], pt.Dist AS [Distribution Method], pt.Group_Cd AS [Group Code], pt.HomeUnion AS [Home Union], 
pt.JrnlType AS [Journal Type], pt.Labor_Class_Cd AS [Labor Class Code], pt.LineId AS [Line ID], pt.LineNbr AS [Line Nbr], 
convert(date,pt.LUpd_DateTime) AS [Last Update Date], pt.LUpd_Prog AS [Last Update Program], pt.LUpd_User AS [Last Update User], pt.NoteId AS [NoteID], 
pt.Paid AS [Paid], pt.PayPerNbr AS [Pay Period Nbr], pt.PC_Status AS [Project Controller Status], pt.PW_cd AS [Prevailing Wage Code], 
pt.RateBaseFlg AS [Rate Base Flag], pt.Rlsed AS [Released], pt.RptEarnSubjDed AS [Earning Subject to Deduction], pt.S4Future01 AS [Subaccount Charged], 
pt.S4Future02 AS [Company ID Charged], pt.ScreenNbr AS [Screen Nbr], pt.Shift AS [Shift], pt.SS_BillableHours AS [Billable Hours], 
pt.SS_ContractID AS [Contract ID], pt.SS_EquipmentID AS [Equipment ID], pt.SS_ExtPrice AS [Extended Price], pt.SS_InvtLocId AS [Inventory Location ID], 
pt.SS_LineTypes AS [Line Types], pt.SS_LineItemID AS [Line Item ID], pt.SS_PostFlag AS [Post Flag], pt.SS_ServiceCallID AS [Service Call ID], 
 pt.StdUnitRate AS [Standard Salary Rate], pt.TimeShtFlg AS [Timesheet Flag], 
pt.TimeShtNbr AS [Timesheet Nbr], pt.Type_ AS [Transaction Subtype], pt.Union_Cd AS [Union Code], pt.UnitDesc AS [Unit Description], 
pt.UnitsDay1 AS [Units for Day 01], pt.UnitsDay2 AS [Units for Day 02], pt.UnitsDay3 AS [Units for Day 03], pt.UnitsDay4 AS [Units for Day 04], 
pt.UnitsDay5 AS [Units for Day 05],pt.UnitsDay6 AS [Units for Day 06], pt.UnitsDay7 AS [Units for Day 07], 
pt.User1 AS [User1], pt.User2 AS [User2], pt.User3 AS [User3], pt.User4 AS [User4], pt.User5 AS [User5], 
pt.User6 AS [User6], convert(date,pt.User7) AS [User7], convert(date,pt.User8) AS [User8], pt.WCtoGL AS [Posted to GL], pt.WorkComp AS [Worker's Compensation], 
pt.WorkOrder AS [Work Order Nbr], pt.WorkType AS [Type of Work] 
from prtran  pt with (nolock)
left outer join Employee e with (nolock)
on pt.EmpId = e.EmpId
WHERE pt.Type_ IN ('E', 'EB')


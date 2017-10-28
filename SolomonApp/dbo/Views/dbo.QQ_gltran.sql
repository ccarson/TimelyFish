
CREATE VIEW [QQ_gltran]
AS
select
gltran.JrnlType AS [Journal Type], gltran.BatNbr AS [Batch Number], gltran.TranType AS [Transaction Type],
gltran.OrigCpnyID AS [Original Company ID],gltran.Acct AS [Account],account.descr AS [Account Description], 
gltran.Sub AS [Subaccount], subacct.descr AS [Subaccount Description], gltran.PerEnt AS [Period Entered],
gltran.RefNbr AS [Reference Number], convert(date,gltran.TranDate) AS [Transaction Date], gltran.TranDesc AS [Transaction Description], 
gltran.DrAmt AS [Debit Amount], gltran.CrAmt AS [Credit Amount],
convert(date,gltran.AppliedDate) AS [Applied Date], gltran.BalanceType AS [Balance Type], 
gltran.BaseCuryID AS [Base Currency ID], 
gltran.CpnyID AS [Company ID],  convert(date,gltran.Crtd_DateTime) AS [Create Date], 
gltran.Crtd_Prog AS [Create Program], gltran.Crtd_User AS [Create User], 
gltran.CuryCrAmt AS [Currency Credit Amount], gltran.CuryDrAmt AS [Currency Debit Amount], 
convert(date,gltran.CuryEffDate) AS [Currency Effective Date], gltran.CuryId AS [Currency ID], 
gltran.CuryMultDiv AS [Currency Multiple/Divide], gltran.CuryRate AS [Currency Rate], 
gltran.CuryRateType AS [Currency Rate Type], 
gltran.EmployeeID AS [Employee ID], gltran.ExtRefNbr AS [External Reference Number], 
gltran.FiscYr AS [Fiscal Year], gltran.IC_Distribution AS [Intercompany Translation Status], 
gltran.Id AS [Vendor/Customer ID],  
gltran.Labor_Class_Cd AS [Labor Class Code], gltran.LedgerID AS [Ledger ID], 
gltran.LineId AS [Line ID], gltran.LineNbr AS [Line Number], gltran.LineRef AS [Line Reference], 
convert(date,gltran.LUpd_DateTime) AS [Last Update Date], gltran.LUpd_Prog AS [Last Update Program], 
gltran.LUpd_User AS [Last Update User], gltran.Module AS [Module], gltran.NoteID AS [NoteID], 
gltran.OrigAcct AS [Original Account], gltran.OrigBatNbr AS [Original Batch Number], 
gltran.OrigSub AS [Original Subaccount], 
gltran.PC_Flag AS [Project Billable], gltran.PC_Status AS [Project Controller Flag], 
 gltran.PerPost AS [Period to Post], gltran.Posted AS [Posted], 
gltran.ProjectID AS [Project ID], gltran.Qty AS [Quantity], 
gltran.Rlsed AS [Released], gltran.S4Future01 AS [Small Balance Write-off], 
gltran.S4Future03 AS [Currency Amount Cleared], convert(date,gltran.S4Future07) AS [Date Cleared], 
gltran.S4Future11 AS [Cleared Flag], gltran.TaskID AS [TaskID], 
gltran.User1 AS [User1], gltran.User2 AS [User2], 
gltran.User3 AS [User3], gltran.User4 AS [User4], gltran.User5 AS [User5], gltran.User6 AS [User6], 
convert(date,gltran.User7) AS [User7], convert(date,gltran.User8) AS [User8]
from GLTran with (nolock)
left outer join Account with (nolock)
on GLTran.Acct = Account.Acct
left outer join SubAcct with (nolock)
on GLTran.Sub = SubAcct.sub

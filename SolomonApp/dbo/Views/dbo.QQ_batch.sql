
CREATE VIEW [QQ_batch]
AS
select 
batch.BatNbr AS [Batch Number],  batch.Descr AS [Batch Description], batch.Status AS [Status], batch.Rlsed AS [Released], batch.Module AS [Module], batch.JrnlType AS [Journal Type], 
batch.LedgerID AS [LedgerID], Ledger.Descr AS [Ledger Description], batch.CtrlTot AS [Control Total], batch.CrTot AS [Credit Total], batch.DrTot AS [Debit Total], 
Batch.CuryCtrlTot AS [Currency Control Total],
batch.Acct AS [Account], batch.AutoRev AS [Auto Reversing Batch], batch.AutoRevCopy AS [Reversed Copy], batch.BalanceType AS [Balance Type], batch.BankAcct AS [Bank Account Number], 
batch.BankSub AS [Bank Subaccount], batch.BaseCuryID AS [Base Currency ID], batch.BatType AS [Batch Type], batch.clearamt AS [Clear Amount], 
batch.Cleared AS [Cleared], batch.CpnyID AS [Company ID], convert(date,batch.Crtd_DateTime) AS [Create Date], batch.Crtd_Prog AS [Create Program], batch.Crtd_User AS [Create User], 
 batch.CuryCrTot AS [Currency Credit Total],  
batch.CuryDepositAmt AS [Currency Deposit Amount], batch.CuryDrTot AS [Currency Debit Total], convert(date,batch.CuryEffDate) AS [Currency Effective Date], 
batch.CuryId AS [Currency ID], batch.CuryMultDiv AS [Currency Multiple/Divide], batch.CuryRate AS [Currency Rate], 
batch.CuryRateType AS [Currency Rate Type], batch.Cycle AS [Recurring Batch Cycle], convert(date,batch.DateClr) AS [Date the A/R Deposit Cleared], convert(date,batch.DateEnt) AS [Transaction Date for A/R Deposit], 
batch.DepositAmt AS [Deposit Amount],  batch.EditScrnNbr AS [Edit Screen Number], 
batch.GLPostOpt AS [GL Post Option],  convert(date,batch.LUpd_DateTime) AS [Last Update Date], 
batch.LUpd_Prog AS [Last Update Program], batch.LUpd_User AS [Last Update User],  batch.NbrCycle AS [Number Cycle], 
batch.NoteID AS [NoteID], batch.OrigBatNbr AS [Original Batch Number], batch.OrigCpnyID AS [Original Company ID], batch.OrigScrnNbr AS [Original Screen Number], 
batch.PerEnt AS [Period Entered], batch.PerPost AS [Period to Post],  batch.Sub AS [Subaccount], 
batch.User1 AS [User1], batch.User2 AS [User2], batch.User3 AS [User3], 
batch.User4 AS [User4], batch.User5 AS [User5], batch.User6 AS [User6], convert(date,batch.User7) AS [User7], convert(date,batch.User8) AS [User8]
from batch with (nolock)
left outer join Ledger with (nolock)
on Batch.LedgerID = Ledger.LedgerID

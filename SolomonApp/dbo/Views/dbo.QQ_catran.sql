
CREATE VIEW [QQ_catran]
AS
SELECT     T.bankacct AS [Bank Account], A.Descr AS [Bank Account Descr], CONVERT(DATE,T.TranDate) AS [Date], T.RefNbr AS [Reference Number], 
                      T.batnbr AS [Batch Number], T.Perent AS [Period Entered], T.PerPost AS [Period to Post], T.EntryId AS [Transaction Type], 
                      T.Acct AS Account, A1.Descr AS [Account Descr], T.Sub AS Subaccount, T.PayeeID, 
                      T.TranDesc AS [Transaction Description], T.TranAmt AS [Transaction Amount], T.curytranamt AS [Currency Transaction Amount], 
                      T.RcnclStatus AS Status, CONVERT(DATE,T.ClearDate) AS [Cleared Date], T.Module, T.AcctDist AS [Account Distribution], 
                      T.BankCpnyID AS [Bank Company ID], T.banksub AS [Bank Subaccount], T.ClearAmt AS [Cleared Amount], 
                      T.CpnyID AS [Company ID], CONVERT(DATE,T.Crtd_DateTime) AS [Create Date], T.Crtd_Prog AS [Create Program], T.Crtd_User AS [Create User], 
                      T.CuryID AS [Currency ID], T.CuryMultDiv AS [Currency Multiply/Divide], T.CuryRate AS [Currency Rate], 
                      T.DrCr AS [Debit/Credit], T.EmployeeID, T.JrnlType AS [Journal Type], T.Labor_Class_Cd, T.LineID, 
                      T.Linenbr, T.LineRef, CONVERT(DATE,T.LUpd_DateTime) AS [Last Update Date], T.LUpd_Prog AS [Last Update Program], 
                      T.LUpd_User AS [Last Update User], T.NoteID, T.PC_Flag AS Billable, T.PerClosed AS [Period Closed], T.ProjectID, 
                      T.Qty, T.RecurId AS [Recurring ID], T.Rlsed AS Released, T.S4Future01, T.S4Future02, T.S4Future03, 
                      T.S4Future04, T.S4Future05, T.S4Future06, CONVERT(DATE,T.S4Future07) AS [S4Future07], CONVERT(DATE,T.S4Future08) AS [S4Future08], T.S4Future09, 
                      T.S4Future10, T.S4Future11, T.S4Future12, T.TaskID, T.trsftobankacct AS [Destination Bank Account], 
                      T.trsftobanksub AS [Destination Bank Subaccount], T.TrsfToCpnyID AS [Destination Company ID], T.User1, T.User2, 
                      T.User3, T.User4, T.User5, T.User6, CONVERT(DATE,T.User7) AS [User7], CONVERT(DATE,T.User8) AS [User8]
FROM    CATran T with (nolock)
		INNER JOIN Account A with (nolock) ON T.bankacct = A.Acct 
		INNER JOIN Account A1 with (nolock) ON T.Acct = A1.Acct


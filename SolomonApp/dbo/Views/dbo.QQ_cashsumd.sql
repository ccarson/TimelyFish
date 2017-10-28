
CREATE VIEW [QQ_cashsumd]
AS
SELECT     C.CpnyID AS [Company ID], C.BankAcct AS [Bank Account], A.Descr AS Description, 
                      C.BankSub AS [Bank Subaccount], C.PerNbr AS [Period Number], CONVERT(DATE,C.TranDate) AS [Transaction Date], 
                      C.CuryID AS [Currency ID], C.ConCuryDisbursements AS [Consolidated Currency Disbursements], 
                      C.ConCuryReceipts AS [Consolidated Currency Receipts], C.Condisbursements AS [Consolidated Disbursements], 
                      C.ConReceipts AS [Consolidated Receipts], C.CuryDisbursements AS [Currency Disbursements], 
                      C.CuryReceipts AS [Currency Receipts], C.Disbursements, C.Receipts, CONVERT(DATE,C.Crtd_DateTime) AS [Create Date], 
                      C.Crtd_Prog AS [Create Program], C.Crtd_User AS [Create User], CONVERT(DATE,C.LUpd_DateTime) AS [Last Update Date], 
                      C.LUpd_Prog AS [Last Update Program], C.LUpd_User AS [Last Update User], C.NoteID, C.S4Future01, 
                      C.S4Future02, C.S4Future03, C.S4Future04, C.S4Future05, C.S4Future06, 
                      CONVERT(DATE,C.S4Future07) AS [S4Future07], CONVERT(DATE,C.S4Future08) AS S4Future08, C.S4Future09, C.S4Future10, C.S4Future11, 
                      C.S4Future12, C.User1, C.User2, C.User3, C.User4, C.User5, 
                      C.User6, CONVERT(DATE,C.User7) AS [User7], CONVERT(DATE,C.User8) AS [User8]
FROM         CashSumD C INNER JOIN
                      Account A ON C.BankAcct = A.Acct


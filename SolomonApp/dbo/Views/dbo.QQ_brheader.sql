
CREATE VIEW [QQ_brheader]
AS
SELECT     H.AcctID AS Account, A.Descr AS [Account Description], H.ReconPerNbr AS [Reconciliation Period Number], 
                      H.BBBegBal AS [Beginning Balance], H.BBChkClrd AS [Total Checks Cleared], H.BBDepClrd AS [Total Deposits Cleared], 
                      H.BBDiff AS [Beg Bal - Clrd Dep - Balance], H.BBEndBalC AS [Beg Bal - Clrd Dep], H.BBEndBalS AS Balance, 
                      H.CpnyId AS [Company ID], H.GLAcctBal AS [GL Account Balance], H.GLChkClrd AS [Sum of Cleared Checks], 
                      H.GLDepClrd AS [Sum of Cleared Deposits], H.GLDiff AS [Acct Bal + Clrd Dep - End Bal], H.GLEndBalC AS [Acct Bal + Clrd Dep], 
                      H.GLEndBalS AS [Account Ending Balance], CONVERT(DATE,H.Crtd_DateTime) AS [Create Date], H.Crtd_Prog AS [Create Program], 
                      H.Crtd_User AS [Create User], H.NoteID, CONVERT(DATE,H.LUpd_DateTime) AS [Last Update Date], 
                      H.LUpd_Prog AS [Last Update Program], H.LUpd_User AS [Last Update User], H.S4Future01, H.S4Future02, 
                      H.S4Future03, H.S4Future04, H.S4Future05, H.S4Future06, CONVERT(DATE,H.S4Future07) AS [S4Future07], 
                      CONVERT(DATE,H.S4Future08) AS [S4Future08], H.S4Future09, H.S4Future10, H.S4Future11, H.S4Future12, H.UserC1, 
                      H.UserC2, H.UserC3, H.UserC4, CONVERT(DATE,H.UserD1) AS [UserD1], CONVERT(DATE,H.UserD2) AS [UserD2], H.UserF1, H.UserF2,
                       H.UserI1, H.UserI2, H.UserL1, H.UserL2
FROM	BRHeader H with (nolock)
			INNER JOIN Account A with (nolock) ON H.AcctID = A.Acct


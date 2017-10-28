
CREATE VIEW [QQ_sminvdetail]
AS
SELECT     H.CpnyID AS [Company ID], H.DocumentId AS [Service Call ID], H.CustID AS [Customer ID], 
                      D.Refnbr AS [Invoice Reference Number], convert(date,H.DocDate) AS [Invoice Date], H.TermID AS [Terms ID], H.BranchID, 
                      D.Invtid AS [Inventory ID], D.Description, D.Quantity, D.UnitPrice, 
                      D.ExtPrice AS [Extended Price], D.ARBatNbr AS [AR Batch Number], D.SiteID, 
                      D.WhseLoc AS [Warehouse Bin Location], H.ProjectID, D.TaskID, D.Acct AS Account, 
                      D.CmmnAmt AS [Commission Amount], D.CmmnPct AS [Commission Percent], D.COGSAcct AS [COGS Account], 
                      D.COGSSub AS [COGS Subaccount], D.ContractID, D.Cost, convert(date,D.Crtd_DateTime) AS [Create Date], 
                      D.Crtd_Prog AS [Create Program], D.Crtd_User AS [Create User], D.DetailType, 
                      D.DocType AS [Document Type], D.EarnMult AS [Earnings Multiplier], D.EmpID AS [Employee ID], 
                      D.EmpPRID AS [Employee ID in Payroll], D.EquipID AS [Equipment ID], D.ExtRefNbr AS [External Reference Number], 
                      D.LineTypes, D.LotSerialPU AS [Stock UOM], D.LotSerialRep AS [Serial Number], 
                      convert(date,D.Lupd_dateTime) AS [Last Update Date], D.Lupd_Prog AS [Last Update Program], 
                      D.Lupd_User AS [Last Update User], D.NoteId, D.PerEnt AS [Period Entered], D.PerPost AS [Period to Post],
                      D.SlsperID AS [Salesperson ID], D.StdCost AS [Standard Cost], D.Sub AS Subaccount, 
                      D.TaxAmt00 AS [Tax Amount], D.TaxExempt, D.TaxID00 AS [Tax ID], D.TranAmt AS [Transaction Amount], 
                      convert(date,D.TranDate) AS [Transaction Date], D.TxblAmt00 AS [Taxable Amount], D.User1, D.User2, 
                      D.User3, D.User4, D.User5, D.User6, convert(date,D.User7) AS [User7], convert(date,D.User8) AS [User8], 
                      D.User9, D.WorkHr AS [Hours Worked]
FROM          smInvDetail D with (nolock)
		INNER JOIN SMInvoice H with (nolock) ON D.CpnyID = H.CpnyID AND D.DocumentID = H.DocumentId
		INNER JOIN Inventory I with (nolock) ON I.InvtID = D.Invtid 
		


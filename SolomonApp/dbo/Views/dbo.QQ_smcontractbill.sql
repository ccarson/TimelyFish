
CREATE VIEW [QQ_smcontractbill]
AS
SELECT     B.CpnyID AS [Company ID], B.ContractID, C.BranchId, C.CustId AS [Customer ID], C.ContractType, C.TotalAmt AS [Contract Amount], 
			CONVERT(DATE,C.StartDate) AS [Contract Start Date], CONVERT(DATE,C.ExpireDate) AS [Contract Expiration Date], C.AmortFreq AS [Amortization Frequency], 
			CONVERT(DATE,C.AmortStartDate) AS [Amortization Start Date], CONVERT(DATE,B.BillDate) AS [Billing Date], B.BillAmount AS [Billing Amount], B.Status, 
			B.Comment, B.ARBatNbr AS [Accounts Receivable Batch Number], B.ARRefNbr AS [Accounts Receivable Reference Number], B.PerPost AS [Period to Post], 
			B.LineNbr, B.MiscAmt AS [Miscellaneous Amount], B.AmtPaid, B.BillFlag, B.CB_D04, B.CB_ID01, B.CB_ID02, B.CB_ID03, B.CB_ID05, B.CB_ID06, B.CB_ID07, 
			B.CB_ID08, CONVERT(DATE,B.CB_ID09) AS [CB_ID09], B.CB_ID10, B.CmmnAmt AS [Commission Amount], B.CmmnPct AS [Commission Percent], 
			B.CmmnStatus AS [Commission Status], CONVERT(DATE,B.Crtd_DateTime) AS [Create Date], B.Crtd_Prog AS [Create Program], B.Crtd_User AS [Create User], 
			B.DocType AS [Document Type], B.InvBatNbr AS [Inventory Batch Number], B.InvoiceLineID, B.InvoiceNbr, CONVERT(DATE,B.Lupd_DateTime) AS [Last Update Date], 
			B.Lupd_Prog AS [Last Update Program], B.Lupd_User AS [Last Update User], B.NbrOfCalls, B.NoteID, CONVERT(DATE,B.ProcessDate) AS [Process Date], 
			B.ProjectID, B.RI_ID, B.TaskID, B.User1, B.User2, B.User3, B.User4, B.User5, B.User6, CONVERT(DATE,B.User7) AS [User7], CONVERT(DATE,B.User8) AS [User8]
FROM	smContractBill B with (nolock)
			INNER JOIN SMContract C with (nolock) ON B.CpnyID = C.CpnyID AND B.ContractID = C.ContractId


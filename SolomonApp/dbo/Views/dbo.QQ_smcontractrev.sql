
CREATE VIEW [QQ_smcontractrev]
AS
SELECT	R.CpnyID AS [Company ID], R.ContractID AS [Contract ID], C.BranchId AS [Branch ID], C.CustId AS [Customer ID], C.ContractType, C.TotalAmt 
		AS [Contract Amount], CONVERT(DATE,C.StartDate) AS [Contract Start Date], CONVERT(DATE,C.ExpireDate) AS [Contract Expiration Date], C.AmortFreq 
		AS [Amortization Frequency], CONVERT(DATE,C.AmortStartDate) AS [Amortization Start Date], CONVERT(DATE,R.RevDate) AS [Revenue Date], R.RevAmount 
		AS [Revenue Amount], R.Status, R.SalesAcct AS [Sales Account], A.Descr AS [Sales Account Description], R.SalesSub AS [Sales Subaccount], R.Comment, 
		R.GLBatNbr AS [GL Batch Number], R.PerPost AS [Period to Post], R.CR_ID01, R.CR_ID02, R.CR_ID03, R.CR_ID04, R.CR_ID05, R.CR_ID06, R.CR_ID07, R.CR_ID08, 
		CONVERT(DATE,R.CR_ID09) AS [CR_ID09], R.CR_ID10, CONVERT(DATE,R.Crtd_DateTime) AS [Create Date], R.Crtd_Prog AS [Create Program], R.Crtd_User AS [Create User], 
		R.DocType AS [Document Type], R.LineNbr AS [Line Number], CONVERT(DATE,R.Lupd_DateTime) AS [Last Update Date], R.Lupd_Prog AS [Last Update Program], 
		R.Lupd_User AS [Last Update User], R.NoteID, R.ProjectID, R.RevFlag AS [Revenue Flag], R.TaskID, R.User1, R.User2, R.User3, R.User4, R.User5, R.User6, 
		CONVERT(DATE,R.User7) AS [User7], CONVERT(DATE,R.User8) AS [User8]
FROM	smContractRev R with (nolock) 
			INNER JOIN SMContract C with (nolock) ON R.CpnyID = C.CpnyID AND R.ContractID = C.ContractId
			INNER JOIN Account A with (nolock) ON R.SalesAcct = A.Acct


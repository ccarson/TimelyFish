
CREATE VIEW [QQ_smconpricing]
AS
SELECT     P.ContractID, C.BranchId, C.CustId AS [Customer ID], C.SiteId, C.Status, CONVERT(DATE,C.StartDate) AS [Contract Start Date], 
			CONVERT(DATE,C.ExpireDate) AS [Contract Expiration Date], C.MatMarkupID AS [Material Markup ID], C.LabMarkupID AS [Labor Markups ID], 
			P.InvtId AS [Inventory ID], P.Descr AS [Inventory Description], P.BaseOption, P.BasePrice AS [Base Amount], P.PMOption, P.PMPrice AS [PM Amount], 
			CONVERT(DATE,P.Crtd_DateTime) AS [Create Date], P.Crtd_Prog AS [Create Program], P.Crtd_User AS [Create User], 
			CONVERT(DATE,P.Lupd_DateTime) AS [Last Update Date], P.Lupd_Prog AS [Last Update Program], P.Lupd_User AS [Last Update User], P.NoteID, P.User1, 
			P.User2, P.User3, P.User4, P.User5, P.User6, CONVERT(DATE,P.User7) AS [User7], CONVERT(DATE,P.User8) AS [User8]
FROM	smConPricing P with (nolock) 
		INNER JOIN SMContract C with (nolock) ON P.ContractID = C.ContractId


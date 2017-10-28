
CREATE VIEW [QQ_smconequipment]
AS
SELECT	CE.ContractId, C.BranchId, C.CustId AS [Customer ID], C.SiteId, C.Status AS [Contract Status], CONVERT(DATE,C.StartDate) AS [Contract Start Date], 
		CONVERT(DATE,C.ExpireDate) AS [Contract Expiration Date], CE.EquipID AS [Equipment ID], CE.BasePrice AS [Calculated Price], CE.AmtContract AS 
		[Contract Amount], CE.PMFlag AS [Schedule PM], CE.PmCode AS [PM Code], E.ModelId AS [Model ID], CE.EquipTypeID AS [Equipment Type ID], CE.Descr AS 
		[Description], CE.SerialNbr AS [Serial Number], CE.AssetNbr AS [Asset Number], CONVERT(DATE,CE.StartWarranty) AS [Warranty Starts], 
		CONVERT(DATE,CE.EndWarranty) AS [Warranty Ends], CE.AmtBilled AS [Billed Amount], CE.AmtBooked AS [Booked Amount], CE.AmtRevenue AS [Revenue Amount], 
		CE.Booked, CE.BookReversed, CE.CE_ID01, CE.CE_ID02, CE.CE_ID03, CE.CE_ID04, CE.CE_ID05, CE.CE_ID06, CE.CE_ID07, CE.CE_ID08, CONVERT(DATE,CE.CE_ID09) AS 
		[CE_ID09], CE.CE_ID10, CE.CE_ID11, CE.CE_ID12, CE.CE_ID13, CE.CE_ID14, CE.CE_ID15, CE.CE_ID16, CE.CE_ID17, CE.CE_ID18, CONVERT(DATE,CE.CE_ID19) AS [CE_ID19], 
		CE.CE_ID20, CONVERT(DATE,CE.Crtd_DateTime) AS [Create Date], CE.Crtd_Prog AS [Create Program], CE.Crtd_User AS [Create User], CONVERT(DATE,CE.EndDate) AS
		[End Date], CONVERT(DATE,CE.Lupd_DateTime) AS [Last Update Date], CE.Lupd_Prog AS [Last Update Program], CE.Lupd_User AS [Last Update User], CE.NoteID, 
		CE.PrimaryKey, CE.Qty AS Quantity, CE.Retired, CONVERT(DATE,CE.RetireDate) AS [Date Retired], CE.RevAccount AS [Revenue Account], CE.RevSub AS 
		[Revenue Subaccount], CE.ScreenID, CE.SSNOteID AS [Service Note ID], CONVERT(DATE,CE.StartDate) AS [Start Date], CE.Status, CE.User1, CE.User2, CE.User3, 
		CE.User4, CE.User5, CE.User6, CONVERT(DATE,CE.User7) AS [User7], CONVERT(DATE,CE.User8) AS [User8], CE.User9, CE.Void
FROM	smConEquipment CE with (nolock)
		INNER JOIN SMContract C with (nolock) ON CE.ContractId = C.ContractId 
		INNER JOIN smSvcEquipment E with (nolock) ON CE.EquipID = E.EquipID


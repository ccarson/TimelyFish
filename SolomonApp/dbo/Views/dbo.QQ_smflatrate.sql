
CREATE VIEW [QQ_smflatrate]
AS
SELECT	FlatRateId AS [Flat Rate ID], FlatRateDesc AS [Description], BranchId AS [Branch ID], CONVERT(DATE,EffectiveDate) AS [Effective Date], 
		FlatRateType AS [Flat Rate Type], FlatRateCategory, FlatRateSubCategory, CONVERT(DATE,DatePrinted) AS [Date Printed], 
		CONVERT(DATE,LastUpdate) AS [Last Update], BasePrice, MarkupPercent, StandardHours, CONVERT(DATE,Crtd_DateTime) AS [Create Date], 
		Crtd_Prog AS [Create Program], Crtd_User AS [Create User], LaborWarranty AS [Labor Warranty Duration], LaborWarrantyType, 
		CONVERT(DATE,Lupd_DateTime) AS [Last Update Date], Lupd_Prog AS [Last Update Program], Lupd_User AS [Last Update User], NoteID, 
		PartsWarranty AS [Parts Warranty Duration], PartsWarrantyType, TaxBasis, TaxID, TaxTotal, User1, User2, User3, User4, User5, User6, 
		CONVERT(DATE,User7) AS [User7], CONVERT(DATE,User8) AS [User8]
FROM         smFlatRate with (nolock)


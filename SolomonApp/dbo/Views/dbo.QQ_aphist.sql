
CREATE VIEW [QQ_aphist]
AS
SELECT     H.CpnyID AS [Company ID], H.VendId AS [Vendor ID], CASE WHEN CHARINDEX('~' , V.Name) > 0 THEN 	CONVERT (CHAR(60), LTRIM(SUBSTRING(V.Name, 1 , CHARINDEX('~' , V.Name) - 1)) + ', ' + LTRIM(RTRIM
(SUBSTRING(V.Name, CHARINDEX('~' , V.Name) + 1 , 60)))) ELSE V.Name END AS [Name], H.FiscYr AS [Fiscal Year], H.PerNbr AS [Current Period Number], H.BegBal AS [Beginning Balance], H.YtdPurch AS [YTD Purchases], 
            H.YtdPaymt AS [YTD Payments], H.YtdDiscTkn AS [YTD Discounts Taken], H.YtdDrAdjs AS [YTD Debit Adjustments], 
            H.YtdCrAdjs AS [YTD Credit Adjustments], H.PtdPurch00 AS [PTD Purchases 01], H.PtdPurch01 AS [PTD Purchases 02], 
            H.PtdPurch02 AS [PTD Purchases 03], H.PtdPurch03 AS [PTD Purchases 04], H.PtdPurch04 AS [PTD Purchases 05], 
            H.PtdPurch05 AS [PTD Purchases 06], H.PtdPurch06 AS [PTD Purchases 07], H.PtdPurch07 AS [PTD Purchases 08], 
            H.PtdPurch08 AS [PTD Purchases 09], H.PtdPurch09 AS [PTD Purchases 10], H.PtdPurch10 AS [PTD Purchases 11], 
            H.PtdPurch11 AS [PTD Purchases 12], H.PtdPurch12 AS [PTD Purchases 13], H.PtdPaymt00 AS [PTD Payments 01], 
            H.PtdPaymt01 AS [PTD Payments 02], H.PtdPaymt02 AS [PTD Payments 03], H.PtdPaymt03 AS [PTD Payments 04], 
            H.PtdPaymt04 AS [PTD Payments 05], H.PtdPaymt05 AS [PTD Payments 06], H.PtdPaymt06 AS [PTD Payments 07], 
            H.PtdPaymt07 AS [PTD Payments 08], H.PtdPaymt08 AS [PTD Payments 09], H.PtdPaymt09 AS [PTD Payments 10], 
            H.PtdPaymt10 AS [PTD Payments 11], H.PtdPaymt11 AS [PTD Payments 12], H.PtdPaymt12 AS [PTD Payments 13], 
            H.PtdDiscTkn00 AS [PTD Discounts Taken 01], H.PtdDiscTkn01 AS [PTD Discounts Taken 02], 
            H.PtdDiscTkn02 AS [PTD Discounts Taken 03], H.PtdDiscTkn03 AS [PTD Discounts Taken 04], 
            H.PtdDiscTkn04 AS [PTD Discounts Taken 05], H.PtdDiscTkn05 AS [PTD Discounts Taken 06], 
            H.PtdDiscTkn06 AS [PTD Discounts Taken 07], H.PtdDiscTkn07 AS [PTD Discounts Taken 08], 
            H.PtdDiscTkn08 AS [PTD Discounts Taken 09], H.PtdDiscTkn09 AS [PTD Discounts Taken 10], 
            H.PtdDiscTkn10 AS [PTD Discounts Taken 11], H.PtdDiscTkn11 AS [PTD Discounts Taken 12], 
            H.PtdDiscTkn12 AS [PTD Discounts Taken 13], H.PtdDrAdjs00 AS [PTD Debit Adjustments 01], 
            H.PtdDrAdjs01 AS [PTD Debit Adjustments 02], H.PtdDrAdjs02 AS [PTD Debit Adjustments 03], 
            H.PtdDrAdjs03 AS [PTD Debit Adjustments 04], H.PtdDrAdjs04 AS [PTD Debit Adjustments 05], 
            H.PtdDrAdjs05 AS [PTD Debit Adjustments 06], H.PtdDrAdjs06 AS [PTD Debit Adjustments 07], 
            H.PtdDrAdjs07 AS [PTD Debit Adjustments 08], H.PtdDrAdjs08 AS [PTD Debit Adjustments 09], 
            H.PtdDrAdjs09 AS [PTD Debit Adjustments 10], H.PtdDrAdjs10 AS [PTD Debit Adjustments 11], 
            H.PtdDrAdjs11 AS [PTD Debit Adjustments 12], H.PtdDrAdjs12 AS [PTD Debit Adjustments 13], 
            H.PtdCrAdjs00 AS [PTD Credit Adjustments 01], H.PtdCrAdjs01 AS [PTD Credit Adjustments 02], 
            H.PtdCrAdjs02 AS [PTD Credit Adjustments 03], H.PtdCrAdjs03 AS [PTD Credit Adjustments 04], 
            H.PtdCrAdjs04 AS [PTD Credit Adjustments 05], H.PtdCrAdjs05 AS [PTD Credit Adjustments 06], 
            H.PtdCrAdjs06 AS [PTD Credit Adjustments 07], H.PtdCrAdjs07 AS [PTD Credit Adjustments 08], 
            H.PtdCrAdjs08 AS [PTD Credit Adjustments 09], H.PtdCrAdjs09 AS [PTD Credit Adjustments 10], 
            H.PtdCrAdjs10 AS [PTD Credit Adjustments 11], H.PtdCrAdjs11 AS [PTD Credit Adjustments 12], 
            H.PtdCrAdjs12 AS [PTD Credit Adjustments 13], convert(date,H.Crtd_DateTime) AS [Create Date], H.Crtd_Prog AS [Create Program], 
            H.Crtd_User AS [Create User], H.CuryID AS [Currency ID], convert(date,H.LUpd_DateTime) AS [Last Update Date], 
            H.LUpd_Prog AS [Last Update Program], H.LUpd_User AS [Last Update User], H.NoteID, H.User1, H.User2, 
            H.User3, H.User4, H.User5, H.User6, convert(date,H.User7) AS [User7], convert(date,H.User8) AS [User8]
FROM         APHist H with (nolock) 
				INNER JOIN Vendor V with (nolock) ON H.VendId = V.VendId


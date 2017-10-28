
CREATE VIEW [QQ_soaddress]
AS
SELECT	A.CustId AS [Customer ID], CASE WHEN CHARINDEX('~' , C.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(C.Name, 1 , CHARINDEX('~' , C.Name) - 1)) 
		+ ', ' + LTRIM(RTRIM(SUBSTRING(C.Name, CHARINDEX('~' , C.Name) + 1 , 60)))) ELSE C.Name END AS [Customer Name], A.ShipToId AS [Ship To ID], 
		A.Descr AS [Ship To Description], CASE WHEN CHARINDEX('~' , A.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(A.Name, 1 , CHARINDEX('~' , A.Name) - 1)) 
		+ ', ' + LTRIM(RTRIM(SUBSTRING(A.Name, CHARINDEX('~' , A.Name) + 1 , 60)))) ELSE A.Name END AS [Ship To Name], CASE WHEN CHARINDEX('~' , A.Attn) > 0 THEN CONVERT 
		(CHAR(60) , LTRIM(SUBSTRING(A.Attn, 1 , CHARINDEX('~' , A.Attn) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(A.Attn, CHARINDEX('~' , A.Attn) + 1 , 60)))) ELSE A.Attn 
		END AS Attention, A.Addr1 AS [Address 1], A.Addr2 AS [Address 2], A.City, A.State AS [State/Province], A.Zip AS [Zip/Postal Code], A.Country AS 
		[Country/Region],  '(' + SUBSTRING(A.Phone, 1, 3) + ')' + SUBSTRING(A.Phone, 4, 3) + '-' + RTRIM(SUBSTRING(A.Phone, 7, 24)) AS [Phone/Ext], 
		'(' + SUBSTRING(A.Fax, 1, 3) + ')' + SUBSTRING(A.Fax, 4, 3) + '-' + RTRIM(SUBSTRING(A.Fax, 7, 24)) AS [Fax/Ext], A.EMailAddr AS [Email Address], 
		A.TaxRegNbr AS [Tax Registration Number], A.TaxLocId AS [Tax Location ID], A.TaxId00 AS [Tax ID 01], A.TaxId01 AS [Tax ID 02], A.TaxId02 AS [Tax ID 03], 
		A.TaxId03 AS [Tax ID 04], A.COGSAcct AS [COGS Account], A.COGSSub AS [COGS Subaccount], CONVERT(DATE,A.Crtd_DateTime) AS [Create Date], 
		A.Crtd_Prog AS [Create Program], A.Crtd_User AS [Create User], A.DiscAcct AS [Discount Account], A.DiscSub AS [Discount Subaccount], A.FOB, 
		A.FrghtCode AS [Freight Code], A.FrtAcct AS [Freight Account], A.FrtSub AS [Freight Subaccount], A.FrtTermsID AS [Freight Terms ID], 
		A.GeoCode AS [Geographic Code], CONVERT(DATE,A.LUpd_DateTime) AS [Last Update Date], A.LUpd_Prog AS [Last Update Program], A.LUpd_User AS [Last Update User], 
		A.MapLocation, A.MiscAcct AS [Miscellaneous Account], A.MiscSub AS [Miscellaneous Subaccount], A.NoteId, A.S4Future01, A.S4Future02, A.S4Future03, 
		A.S4Future04, A.S4Future05, A.S4Future06, CONVERT(DATE,A.S4Future07) AS [S4Future07], CONVERT(DATE,A.S4Future08) AS [S4Future08], A.S4Future09, A.S4Future10, 
		A.S4Future11, A.S4Future12, A.ShipViaID, A.SiteID, A.SlsAcct AS [Sales Account], A.SlsPerID AS [Salesperson ID], A.SlsSub AS [Sales Subaccount], A.Status, 
		A.User1, A.User2, A.User3, A.User4, A.User5, A.User6, CONVERT(DATE,A.User7) AS [User7], CONVERT(DATE,A.User8) AS [User8]
FROM	SOAddress A with (nolock)
			INNER JOIN Customer C with (nolock) ON A.CustId = C.CustId


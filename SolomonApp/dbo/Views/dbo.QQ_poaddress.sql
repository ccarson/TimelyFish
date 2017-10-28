
CREATE VIEW [QQ_poaddress]
AS
SELECT	A.VendId AS [Vendor ID], CASE WHEN CHARINDEX('~' , Vendor.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(Vendor.Name, 1 , CHARINDEX('~' , 
		Vendor.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(Vendor.Name, CHARINDEX('~' , Vendor.Name) + 1 , 60)))) ELSE Vendor.Name END AS [Vendor Name], 
		A.OrdFromId AS [Vendor Address ID], A.Descr AS [Description], CASE WHEN CHARINDEX('~' , A.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(A.Name, 
		1 , CHARINDEX('~' , A.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(A.Name, CHARINDEX('~' , A.Name) + 1 , 60)))) ELSE A.Name END AS [Vendor Address Name], 
		CASE WHEN CHARINDEX('~' , A.Attn) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(A.Attn, 1 , CHARINDEX('~' , A.Attn) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(A.Attn, 
		CHARINDEX('~' , A.Attn) + 1 , 60)))) ELSE A.Attn END AS [Attention], A.Addr1 AS [Address 1], A.Addr2 AS [Address 2], A.City, A.State AS [State/Province], 
		A.Zip AS [Zip/Postal Code], 
		A.Country AS [Country/Region], '(' + SUBSTRING(A.Phone, 1, 3) + ')' + SUBSTRING(A.Phone, 4, 3) + '-' + RTRIM(SUBSTRING(A.Phone, 7, 24)) AS [Phone/Ext], 
		'(' + SUBSTRING(A.Fax, 1, 3) + ')' + SUBSTRING(A.Fax, 4, 3) + '-' + RTRIM(SUBSTRING(A.Fax, 7, 24)) AS [Fax/Ext], A.EmailAddr AS [Email Address], 
		A.TaxRegNbr AS [Tax Registration Number], A.TaxLocId AS [Tax Location ID], A.TaxId00 AS [Tax ID 01], A.TaxId01 AS [Tax ID 02], A.TaxId02 AS [Tax ID 03], 
		A.TaxId03 AS [Tax ID 04], CONVERT(DATE,A.Crtd_DateTime) AS [Create Date], A.Crtd_Prog AS [Create Program], A.Crtd_User AS [Create User], 
		CONVERT(DATE,A.LUpd_DateTime) AS [Last Update Date], A.LUpd_Prog AS [Last Update Program], A.LUpd_User AS [Last Update User], A.NoteID, A.S4Future01, 
		A.S4Future02, A.S4Future03, A.S4Future04, A.S4Future05, A.S4Future06, CONVERT(DATE,A.S4Future07) AS [S4Future07], CONVERT(DATE,A.S4Future08) AS [S4Future08], 
		A.S4Future09, A.S4Future10, A.S4Future11, A.S4Future12, A.User1, A.User2, A.User3, A.User4, A.User5, A.User6, CONVERT(DATE,A.User7) AS [User7], 
		CONVERT(DATE,A.User8) AS [User8]
FROM	POAddress A with (nolock)
		INNER JOIN Vendor with (nolock) ON A.VendId = Vendor.VendId



CREATE VIEW [QQ_slsperhist]
AS
SELECT				H.SlsperId AS [Salesperson ID], CASE WHEN CHARINDEX('~' , S.Name) > 0 THEN CONVERT (CHAR(60) , 
					LTRIM(SUBSTRING(S.Name, 1 , CHARINDEX('~' , S.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(S.Name, 
					CHARINDEX('~' , S.Name) + 1 , 60)))) ELSE S.Name END AS [Name], H.FiscYr AS [Fiscal Year], 
					H.PerNbr AS [Current Period Number], H.YtdSls AS [YTD Sales], H.YtdRcpt AS [YTD Receipts], H.YtdCOGS AS [YTD COGS], 
                    H.PtdSls00 AS [PTD Sales 01], H.PtdSls01 AS [PTD Sales 02], H.PtdSls02 AS [PTD Sales 03], 
                    H.PtdSls03 AS [PTD Sales 04], H.PtdSls04 AS [PTD Sales 05], H.PtdSls05 AS [PTD Sales 06], 
                    H.PtdSls06 AS [PTD Sales 07], H.PtdSls07 AS [PTD Sales 08], H.PtdSls08 AS [PTD Sales 09], 
                    H.PtdSls09 AS [PTD Sales 10], H.PtdSls10 AS [PTD Sales 11], H.PtdSls11 AS [PTD Sales 12], 
                    H.PtdSls12 AS [PTD Sales 13], H.PtdRcpt00 AS [PTD Receipts 01], H.PtdRcpt01 AS [PTD Receipts 02], 
                    H.PtdRcpt02 AS [PTD Receipts 03], H.PtdRcpt03 AS [PTD Receipts 04], H.PtdRcpt04 AS [PTD Receipts 05], 
                    H.PtdRcpt05 AS [PTD Receipts 06], H.PtdRcpt06 AS [PTD Receipts 07], H.PtdRcpt07 AS [PTD Receipts 08], 
                    H.PtdRcpt08 AS [PTD Receipts 09], H.PtdRcpt09 AS [PTD Receipts 10], H.PtdRcpt10 AS [PTD Receipts 11], 
                    H.PtdRcpt11 AS [PTD Receipts 12], H.PtdRcpt12 AS [PTD Receipts 13], H.PtdCOGS00 AS [PTD COGS 01], 
                    H.PtdCOGS01 AS [PTD COGS 02], H.PtdCOGS02 AS [PTD COGS 03], H.PtdCOGS03 AS [PTD COGS 04], 
                    H.PtdCOGS04 AS [PTD COGS 05], H.PtdCOGS05 AS [PTD COGS 06], H.PtdCOGS06 AS [PTD COGS 07], 
                    H.PtdCOGS07 AS [PTD COGS 08], H.PtdCOGS08 AS [PTD COGS 09], H.PtdCOGS09 AS [PTD COGS 10], 
                    H.PtdCOGS10 AS [PTD COGS 11], H.PtdCOGS11 AS [PTD COGS 12], H.PtdCOGS12 AS [PTD COGS 13], 
                    convert(date,H.Crtd_DateTime) AS [Create Date], H.Crtd_Prog AS [Create Program], H.Crtd_User AS [Create User], 
                    convert(date,H.LUpd_DateTime) AS [Last Update Date], H.LUpd_Prog AS [Last Update Program], H.LUpd_User AS [Last Update User], 
                    H.NoteId, H.User1, H.User2, H.User3, H.User4, H.User5, H.User6, convert(date,H.User7) AS [User7], convert(date,H.User8) AS [User8]
FROM         SlsPerHist H with (nolock) 
				INNER JOIN Salesperson S with (nolock) ON H.SlsperId = S.SlsperId



CREATE VIEW [QQ_earnded_e]
AS
SELECT	ED.EmpId AS [Employee ID], CASE WHEN CHARINDEX('~' , E.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(E.Name, 1 , CHARINDEX('~' , E.Name) - 1)) + ', ' + 
		LTRIM(RTRIM(SUBSTRING(E.Name, CHARINDEX('~' , E.Name) + 1 , 60)))) ELSE E.Name END AS [Employee Name], ED.CalYr AS [Calendar Year], 
		ED.EarnDedId AS [Earnings ID], ED.EDType, ED.WrkLocId AS [Work Location ID], ED.YtdUnits AS [YTD Units], ED.CalYtdEarnDed AS [YTD Earnings], 
		ED.QtdEarnDed00 AS [QTD Earnings 1], ED.QtdEarnDed01 AS [QTD Earnings 2], ED.QtdEarnDed02 AS [QTD Earnings 3], ED.QtdEarnDed03 AS [QTD Earnings 4], 
		CONVERT(DATE,ED.Crtd_DateTime) AS [Create Date], ED.Crtd_Prog AS [Create Program], ED.Crtd_User AS [Create User], 
		ED.CurrEarnDedAmt AS [Current Earnings Amount], ED.CurrUnits AS [Current Units], CONVERT(DATE,ED.LUpd_DateTime) AS [Last Update Date], 
		ED.LUpd_Prog AS [Last Update Program], ED.LUpd_User AS [Last Update User], ED.MtdEarnDed00 AS [MTD Earnings 01], ED.MtdEarnDed01 AS [MTD Earnings 02], 
		ED.MtdEarnDed02 AS [MTD Earnings 03], ED.MtdEarnDed03 AS [MTD Earnings 04], ED.MtdEarnDed04 AS [MTD Earnings 05], ED.MtdEarnDed05 AS [MTD Earnings 06], 
        ED.MtdEarnDed06 AS [MTD Earnings 07], ED.MtdEarnDed07 AS [MTD Earnings 08], ED.MtdEarnDed08 AS [MTD Earnings 09], ED.MtdEarnDed09 AS [MTD Earnings 10], 
        ED.MtdEarnDed10 AS [MTD Earnings 11], ED.MtdEarnDed11 AS [MTD Earnings 12], ED.MtdUnits00 AS [MTD Units 01], ED.MtdUnits01 AS [MTD Units 02], 
        ED.MtdUnits02 AS [MTD Units 03], ED.MtdUnits03 AS [MTD Units 04], ED.MtdUnits04 AS [MTD Units 05], ED.MtdUnits05 AS [MTD Units 06], 
        ED.MtdUnits06 AS [MTD Units 07], ED.MtdUnits07 AS [MTD Units 08], ED.MtdUnits08 AS [MTD Units 09], ED.MtdUnits09 AS [MTD Units 10], 
        ED.MtdUnits10 AS [MTD Units 11], ED.MtdUnits11 AS [MTD Units 12], ED.NoteId, ED.S4Future01, ED.S4Future02, ED.S4Future03, ED.S4Future04, ED.S4Future05, 
        ED.S4Future06, CONVERT(DATE,ED.S4Future07) AS [S4Future07], CONVERT(DATE,ED.S4Future08) AS [S4Future08], ED.S4Future09, ED.S4Future10, ED.S4Future11, 
        ED.S4Future12, ED.User1, ED.User2, ED.User3, ED.User4, ED.User5, ED.User6, CONVERT(DATE,ED.User7) AS [User7], CONVERT(DATE,ED.User8) AS [User8]
FROM    EarnDed ED with (nolock) 
			INNER JOIN Employee E with (nolock) ON ED.EmpId = E.EmpId
WHERE     (ED.EDType = 'E')


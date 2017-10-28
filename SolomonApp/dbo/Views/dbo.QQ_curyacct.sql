
CREATE VIEW [QQ_curyacct]
AS
SELECT     CA.CpnyID AS [Company ID], CA.Acct AS Account, A.Descr AS [Acct Description], CA.Sub AS Subaccount, 
                      CA.LedgerID, CA.FiscYr AS [Fiscal Year], CA.CuryId AS [Currency ID], C.Descr AS [Currency Description], 
                      C.CurySym AS [Currency Symbol], C.DecPl AS [Currency Decimal Places], CA.BaseCuryID AS [Base Currency ID], 
                      C1.Descr AS [Base Currency Description], C1.CurySym AS [Base Currency Symbol], C1.DecPl AS [Base Currency Decimal Places], 
                      CA.BalanceType, CA.CuryBegBal AS [Currency Beginning Balance], CA.BegBal AS [Beginning Balance], 
                      CA.CuryYtdBal00 AS [Currency YTD Balance 01], CA.CuryYtdBal01 AS [Currency YTD Balance 02], 
                      CA.CuryYtdBal02 AS [Currency YTD Balance 03], CA.CuryYtdBal03 AS [Currency YTD Balance 04], 
                      CA.CuryYtdBal04 AS [Currency YTD Balance 05], CA.CuryYtdBal05 AS [Currency YTD Balance 06], 
                      CA.CuryYtdBal06 AS [Currency YTD Balance 07], CA.CuryYtdBal07 AS [Currency YTD Balance 08], 
                      CA.CuryYtdBal08 AS [Currency YTD Balance 09], CA.CuryYtdBal09 AS [Currency YTD Balance 10], 
                      CA.CuryYtdBal10 AS [Currency YTD Balance 11], CA.CuryYtdBal11 AS [Currency YTD Balance 12], 
                      CA.CuryYtdBal12 AS [Currency YTD Balance 13], CA.YtdBal00 AS [YTD Balance 01], CA.YtdBal01 AS [YTD Balance 02], 
                      CA.YtdBal02 AS [YTD Balance 03], CA.YtdBal03 AS [YTD Balance 04], CA.YtdBal04 AS [YTD Balance 05], 
                      CA.YtdBal05 AS [YTD Balance 06], CA.YtdBal06 AS [YTD Balance 07], CA.YtdBal07 AS [YTD Balance 08], 
                      CA.YtdBal08 AS [YTD Balance 09], CA.YtdBal09 AS [YTD Balance 10], CA.YtdBal10 AS [YTD Balance 11], 
                      CA.YtdBal11 AS [YTD Balance 12], CA.YtdBal12 AS [YTD Balance 13], CONVERT(DATE,CA.Crtd_DateTime) AS [Create Date], 
                      CA.Crtd_Prog AS [Create Program], CA.Crtd_User AS [Create User], CA.CuryPtdBal00 AS [Currency PTD Balance 01], 
                      CA.CuryPtdBal01 AS [Currency PTD Balance 02], CA.CuryPtdBal02 AS [Currency PTD Balance 03], 
                      CA.CuryPtdBal03 AS [Currency PTD Balance 04], CA.CuryPtdBal04 AS [Currency PTD Balance 05], 
                      CA.CuryPtdBal05 AS [Currency PTD Balance 06], CA.CuryPtdBal06 AS [Currency PTD Balance 07], 
                      CA.CuryPtdBal07 AS [Currency PTD Balance 08], CA.CuryPtdBal08 AS [Currency PTD Balance 09], 
                      CA.CuryPtdBal09 AS [Currency PTD Balance 10], CA.CuryPtdBal10 AS [Currency PTD Balance 11], 
                      CA.CuryPtdBal11 AS [Currency PTD Balance 12], CA.CuryPtdBal12 AS [Currency PTD Balance 13], 
                      CONVERT(DATE,CA.LUpd_DateTime) AS [Last Update Date], CA.LUpd_Prog AS [Last Update Program], CA.LUpd_User AS [Last Update User], 
                      CA.NoteId, CA.PtdBal00 AS [PTD Balance 01], CA.PtdBal01 AS [PTD Balance 02], CA.PtdBal02 AS [PTD Balance 03], 
                      CA.PtdBal03 AS [PTD Balance 04], CA.PtdBal04 AS [PTD Balance 05], CA.PtdBal05 AS [PTD Balance 06], 
                      CA.PtdBal06 AS [PTD Balance 07], CA.PtdBal07 AS [PTD Balance 08], CA.PtdBal08 AS [PTD Balance 09], 
                      CA.PtdBal09 AS [PTD Balance 10], CA.PtdBal10 AS [PTD Balance 11], CA.PtdBal11 AS [PTD Balance 12], 
                      CA.PtdBal12 AS [PTD Balance 13], CA.S4Future01, CA.S4Future02, CA.S4Future03, CA.S4Future04, 
                      CA.S4Future05, CA.S4Future06, CONVERT(DATE,CA.S4Future07) AS [S4Future07], CONVERT(DATE,CA.S4Future08) AS [S4Future08], CA.S4Future09, 
                      CA.S4Future10, CA.S4Future11, CA.S4Future12, CA.User1, CA.User2, CA.User3, CA.User4, CA.User5, 
                      CA.User6, CONVERT(DATE,CA.User7) AS [User7], CONVERT(DATE,CA.User8) AS [User8]
FROM         CuryAcct CA with (nolock) 
		INNER JOIN Currncy C with (nolock) ON CA.CuryId = C.CuryId 
		INNER JOIN Account A with (nolock) ON CA.Acct = A.Acct 
		INNER JOIN Currncy C1 with (nolock) ON CA.BaseCuryID = C1.CuryId


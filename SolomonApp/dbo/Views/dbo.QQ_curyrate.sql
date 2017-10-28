
CREATE VIEW [QQ_curyrate]
AS
SELECT     CR.FromCuryId AS [From Currency ID], C1.Descr AS [From Cury ID Description], CR.ToCuryId AS [To Currency ID], 
                      C.Descr AS [To Cury ID Description], CR.RateType, CONVERT(DATE,CR.EffDate) AS [Effective Date], CR.Rate, CR.RateReciprocal, 
                      CR.MultDiv AS [Multiply/Divide], CR.AutoCalcMeth AS [Auto Calculation Method], CONVERT(DATE,CR.Crtd_DateTime) AS [Create Date], 
                      CR.Crtd_Prog AS [Create Program], CR.Crtd_User AS [Create User], CONVERT(DATE,CR.LUpd_DateTime) AS [Last Update Date], 
                      CR.LUpd_Prog AS [Last Update Program], CR.LUpd_User AS [Last Update User], CR.NoteId, CR.S4Future01, 
                      CR.S4Future02, CR.S4Future03, CR.S4Future04, CR.S4Future05, CR.S4Future06, CONVERT(DATE,CR.S4Future07) AS [S4Future07], 
                      CONVERT(DATE,CR.S4Future08) AS [S4Future08], CR.S4Future09, CR.S4Future10, CR.S4Future11, CR.S4Future12, CR.User1, 
                      CR.User2, CR.User3, CR.User4, CR.User5, CR.User6, CONVERT(DATE,CR.User7) AS [User7], CONVERT(DATE,CR.User8) AS [User8]
FROM         CuryRate CR with (nolock)
		INNER JOIN Currncy C1 with (nolock) ON CR.FromCuryId = C1.CuryId 
		INNER JOIN Currncy C with (nolock) ON CR.ToCuryId = C.CuryId


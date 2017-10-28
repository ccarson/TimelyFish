



-- 20140115   32,039 rows in 8 seconds

CREATE VIEW [dbo].[cfv_Finance_Cube_quikload]
AS
SELECT
H.Sub,
H.FiscYr,
H.Acct,
H.BegBal,
H.CpnyID,
H.LastClosePerNbr,
H.PtdBal00,
H.PtdBal01,
H.PtdBal02,
H.PtdBal03,
H.PtdBal04,
H.PtdBal05,
H.PtdBal06,
H.PtdBal07,
H.PtdBal08,
H.PtdBal09,
H.PtdBal10,
H.PtdBal11,
H.PtdBal12,
H.YtdBal00,
H.YtdBal01,
H.YtdBal02,
H.YtdBal03,
H.YtdBal04,
H.YtdBal05,
H.YtdBal06,
H.YtdBal07,
H.YtdBal08,
H.YtdBal09,
H.YtdBal10,
H.YtdBal11,
H.YtdBal12,
A.AcctType,
A.Descr
FROM [$(SolomonApp)].dbo.AcctHist H (nolock)
left join [$(SolomonApp)].dbo.Account A (nolock)
on A.Acct = H.Acct
WHERE H.FiscYr in (year(getdate()),year(getdate())-1)
    AND H.LedgerID = 'A'
--ORDER BY
--H.Sub,
--H.FiscYr,
--H.CpnyID,
--H.Acct







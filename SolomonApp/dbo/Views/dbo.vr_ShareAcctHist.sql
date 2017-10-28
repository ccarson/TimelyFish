 

CREATE VIEW vr_ShareAcctHist AS 

SELECT h.Acct,h.begbal,h.CpnyID,h.CuryId,h.fiscyr,h.LastClosePerNbr,h.LedgerID,
	PerPost=r.BegPerNbr,PtdBal00,
	PtdBal01,PtdBal02,PtdBal03,PtdBal04,PtdBal05,PtdBal06,PtdBal07,PtdBal08,PtdBal09,
	PtdBal10,PtdBal11,PtdBal12,r.RI_ID,h.Sub,YtdBal00,YtdBal01,YtdBal02,YtdBal03,YtdBal04,
	YtdBal05,YtdBal06,YtdBal07,YtdBal08,YtdBal09,YtdBal10,YtdBal11,YtdBal12

FROM AcctHist h, RptRuntime r
WHERE (h.FiscYr between substring(r.BegPerNbr,1,4) and substring(r.EndPerNbr,1,4)  )
	

 

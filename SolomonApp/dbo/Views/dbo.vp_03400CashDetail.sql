 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_03400CashDetail AS

/****** File Name: 0312vp_03400CashDetail.Sql				******/
/****** Last Modified by Chuck Schroeder 11/06/98 16:00 		******/
/****** Modified by C. Seibert 12/14/98 2:15pm - VC should be an adjustment to Disbursements    ******/
/****** Select amounts to be affecting the cash detail balances.	******/

SELECT t.CpnyId, t.Acct, t.Sub, t.PerPost, t.TranDate, 
	Disbursement = Sum(CASE 
		WHEN (t.TranType = "HC" OR t.TranType = "CK" OR t.TranType = "EP") AND t.DrCr = "C" 
		THEN t.TranAmt
            
            WHEN t.TranType = "VC" AND t.DrCr = "D"
            THEN t.TRanAmt * -1

            ELSE 0 END),
      Receipt = 0,
/*****Receipt = Sum(CASE 					******/
/*****	WHEN t.TranType = "VC" AND t.DrCr = "D"   ******/
/*****	THEN t.TranAmt ELSE 0 END),               ******/
	CuryDisbursement = Sum(CASE 
		WHEN (t.TranType = "HC" OR t.TranType = "CK" OR t.TranType = "EP") AND t.DrCr = "C" 
		THEN t.CuryTranAmt 
            
            WHEN t.TranType = "VC" AND t.DrCr = "D"
            THEN t.CuryTRanAmt * -1
            
            ELSE 0 END),
      CuryReceipt = 0
/*****CuryReceipt = Sum(CASE 					******/
/*****	WHEN t.TranType = "VC" AND t.DrCr = "D"   ******/
/*****	THEN t.CuryTranAmt ELSE 0 END)		******/
		,useraddress
FROM APTran t, WrkRelease w, CashAcct c
WHERE w.Module = "AP" AND t.BatNbr = w.BatNbr AND t.Acct = c.BankAcct AND t.Sub = c.BankSub AND t.CpnyID = c.CpnyID
GROUP BY t.CpnyId,t.Acct, t.Sub, t.PerPost, t.TranDate,useraddress


 

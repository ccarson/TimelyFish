 

--APPTABLE
--USETHISSYNTAX

/****** File Name: 0313vp_03400CashAcct.Sql				******/
/****** Last Modified by Scott Guan 10/02/98 12:55 am 		******/
/****** Select amounts to be affecting the cash account balances.	******/

CREATE VIEW vp_03400CashAcct AS

SELECT v.Acct, v.Sub, CurrentBal = Sum(v.Disbursement) + Sum(v.Receipt), 
	CuryCurrentBal = Sum(v.CuryDisbursement) + Sum(v.CuryReceipt)
FROM vp_03400CashDetail v
GROUP BY v.Acct, v.Sub

 

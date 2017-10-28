 

/****** Object:  View dbo.vp_10400_UpdateARCOGS_CustId    Script Date: 7/13/98 11:18:42 AM ******/
CREATE VIEW vp_10400_UpdateARCOGS_CustId As
SELECT T.UserAddress, T.Id, T.CpnyId, T.FiscYr,
	PtdCOGS00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13') 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	YtdCOGS = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) <= S.CurrPerNbr) 
  	                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End)
FROM vp_10400_UpdateARCOGS_INTran T, INSetup S
GROUP BY T.UserAddress, T.Id, T.CpnyId, T.FiscYr


 

 

/****** Object:  View dbo.vp_10400_UpdateARCOGS_SlsPerId    Script Date: 7/13/98 11:18:42 AM ******/
CREATE VIEW vp_10400_UpdateARCOGS_SlsPerId As
SELECT T.UserAddress, T.FiscYr, T.PerNbr, T.SlsPerId,
	PtdCOGS00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'CG') 
                                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'CG') 
  	                   	   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'CG') 
                                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'CG') 
  	                           Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'CG') 
  	                           Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'CG') 
                                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'CG') 
  	                           Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'CG') 
  	                           Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'CG') 
                                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'CG') 
  	                           Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'CG') 
  	                           Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'CG') 
                                   Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdCOGS12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'CG') 
  	                           Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	YtdCOGS = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) <= S.CurrPerNbr AND T.TranType = 'CG') 
  	                         Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType IN ('IN', 'CM', 'DM'))
  	                          Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType IN ('IN', 'CM', 'DM'))
                                  Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType IN ('IN', 'CM', 'DM'))
  	                          Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType IN ('IN', 'CM', 'DM'))
  	                          Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType IN ('IN', 'CM', 'DM'))
  	                          Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType IN ('IN', 'CM', 'DM'))
                                  Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType IN ('IN', 'CM', 'DM'))
  	                          Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType IN ('IN', 'CM', 'DM'))
  	                          Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType IN ('IN', 'CM', 'DM'))
  	                          Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType IN ('IN', 'CM', 'DM'))
	 	                  Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType IN ('IN', 'CM', 'DM'))
                                  Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType IN ('IN', 'CM', 'DM'))
  	                          Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	PtdSls12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType IN ('IN', 'CM', 'DM'))
  	                          Then (T.TranAmt * T.InvtMult) * -1 Else 0 End),
	YtdSls = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) <= S.CurrPerNbr AND T.TranType IN ('IN', 'CM', 'DM'))
                                Then (T.TranAmt * T.InvtMult) * -1 Else 0 End)
FROM vp_10400_UpdateARCOGS_INTranOM T, INSetup S
GROUP BY T.UserAddress, T.SlsPerId, T.FiscYr, T.PerNbr


 

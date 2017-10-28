 

/****** Object:  View dbo.vp_10400_BMIUpdateItemHist    Script Date: 7/13/98 11:18:42 AM ******/
CREATE VIEW vp_10400_BMIUpdateItemHist As
SELECT T.UserAddress, T.FiscYr, T.InvtId, T.SiteId,
       BMIPtdCostRcvd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '01' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '02' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' And T.TranType = 'RC') 
	                              Or (RIGHT(RTRIM(T.PerPost),2) = '03' And T.TranType = 'AS' and T.KitID = '') 
   	                                 Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '04' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '05' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '06' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '07' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '08' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '09' And T.TranType = 'AS' and T.KitID = '') 
     	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '10' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '11' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '12' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostRcvd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' And T.TranType = 'RC') 
	                             Or (RIGHT(RTRIM(T.PerPost),2) = '13' And T.TranType = 'AS' and T.KitID = '') 
   	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),

       BMIPtdCostAdjd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AC') 
                            Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR') 
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostAdjd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AJ') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AC') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'PI') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR')
	                                Then (T.BMITranAmt * T.InvtMult) Else 0 End),

       BMIPtdCostIssd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostIssd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AS' and T.KitID <> '') 
                                     Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'II') 
  	                                Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),

       BMIPtdCostTrsfrIn00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' and T.ToSiteId = '') 
                                           Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIPtdCostTrsfrIn12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                   Then (T.BMITranAmt * T.InvtMult) Else 0 End),

       BMIPtdCostTrsfrOut00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' and T.ToSiteId <> '') 
 	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCostTrsfrOut12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),

       BMIPtdCOGS00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'CG')
                                    Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIPtdCOGS12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'CG') 
  	                            Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),

       BMIYtdCostRcvd = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIYtdCostAdjd = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr AND T.TranType = 'AJ') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr AND T.TranType = 'AC')
                                   Or (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr AND T.TranType = 'PI')
                                   Or (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr AND T.TranType = 'TR')
	                              Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIYtdCostIssd = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr AND T.TranType = 'II')
  	                              Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIYtdCostTrsfrIn = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.BMITranAmt * T.InvtMult) Else 0 End),
       BMIYtdCostTrsfrOut = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End),
       BMIYtdCOGS = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) <= T.PerNbr AND T.TranType = 'CG') 
  	                          Then ((T.BMITranAmt * T.InvtMult) * -1) Else 0 End)

       FROM vp_10400_UpdateItemHist_INTran T, INSetup S
/*       Where T.Rlsed = 0	*/
       GROUP BY T.UserAddress, T.FiscYr, T.InvtId, T.SiteId



 

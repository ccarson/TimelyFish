 

CREATE VIEW vp_10990_SumItemHist As
SELECT T.InvtId, T.SiteId, T.Fiscyr, 

	-- Cost Of Goods Sold for each period.
	PtdCOGS00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'CG') 
          	                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCOGS12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'CG') 
  	                          Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	
	--Cost Adjustments for each period.
	PtdCostAdjd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostAdjd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AJ') 
 	                           Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AC') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'PI') 
	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	
	--Cost Issued for each period
	PtdCostIssd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
            When (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                  Else 0 End),
	PtdCostIssd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),
	PtdCostIssd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'RI') Then ((T.ExtCost * T.InvtMult) * -1)
				 WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AS' and T.KitID <> '') 
                                   Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'II' and I.StkItem = 1)
  	                              Then ((T.TranAmt * T.InvtMult) * -1) 
                                 When (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'II' and I.StkItem = 0)
                                      Then ((T.ExtCost * T.InvtMult) * -1)
                                 Else 0 End),

	--Cost Received for each period.
	PtdCostRcvd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '01' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '02' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '03' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '04' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '05' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '06' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '07' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '08' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '09' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '10' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '11' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '12' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostRcvd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' And T.TranType = 'RC') 
	                           Or (RIGHT(RTRIM(T.PerPost),2) = '13' And T.TranType = 'AS' and T.KitID = '') 
   	                              Then (T.TranAmt * T.InvtMult) Else 0 End),

	--Cost Transfer In for each period.
	PtdCostTrsfrIn00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
        PtdCostTrsfrIn08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),
	PtdCostTrsfrIn12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' and T.ToSiteId = '') 
  	                                 Then (T.TranAmt * T.InvtMult) Else 0 End),

	--Cost Transfer Out for each period.
	PtdCostTrsfrOut00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
        PtdCostTrsfrOut08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                  Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdCostTrsfrOut12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' and T.ToSiteId <> '') 
  	                 Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),

	--Adjustment Qty for each period.
	PtdQtyAdjd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyAdjd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AJ') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'PI') 
  	                             Then (T.Qty * T.InvtMult) Else 0 End),

	--Issued Qty for each period.
	PtdQtyIssd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'RI')
				  Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
 	PtdQtyIssd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	PtdQtyIssd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'RI') 
				  Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'AS' and T.KitID <> '') 
                                  Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'II')
	                             Then ((T.Qty * T.InvtMult) * -1) Else 0 End),

	-- Received Qty for each period.
	PtdQtyRcvd00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' And T.TranType = 'RC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '01' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' And T.TranType = 'RC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '02' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' And T.TranType = 'RC') 
 	                          Or (RIGHT(RTRIM(T.PerPost),2) = '03' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' And T.TranType = 'RC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '04' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' And T.TranType = 'RC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '05' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' And T.TranType = 'RC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '06' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' And T.TranType = 'RC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '07' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' And T.TranType = 'RC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '08' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' And T.TranType = 'RC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '09' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' And T.TranType = 'RC') 
  	                          Or (RIGHT(RTRIM(T.PerPost),2) = '10' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' And T.TranType = 'RC') 
 	                          Or (RIGHT(RTRIM(T.PerPost),2) = '11' And T.TranType = 'AS' and T.KitID = '') 
   	       Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' And T.TranType = 'RC') 
	                          Or (RIGHT(RTRIM(T.PerPost),2) = '12' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),
	PtdQtyRcvd12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'RC')
    	                          Or (RIGHT(RTRIM(T.PerPost),2) = '13' And T.TranType = 'AS' and T.KitID = '') 
   	                             Then (T.Qty * T.InvtMult) Else 0 End),

	--Qty Sold for each period.
        PtdQtySls00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0)
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                               	 Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	          Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0)
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtySls12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                                 Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'IN' AND T.NoQtyUpdate = 0) 
   	                            Then ((T.Qty * T.InvtMult) * -1) Else 0 End),

	--Qty Transfer In
        PtdQtyTrsfrIn00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' AND T.ToSiteId = '') 
        	                        Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' AND T.ToSiteId = '') 
     	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' AND T.ToSiteId = '') 
     	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),
        PtdQtyTrsfrIn12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' AND T.ToSiteId = '') 
   	                                Then (T.Qty * T.InvtMult) Else 0 End),

	--Qty Transfer Out
        PtdQtyTrsfrOut00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
        PtdQtyTrsfrOut12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'TR' AND T.ToSiteId <> '') 
   	                                 Then ((T.Qty * T.InvtMult) * -1) Else 0 End),

	--Amount Sold for each period.
	PtdSls00 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '01' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls01 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '02' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls02 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '03' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls03 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '04' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls04 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '05' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls05 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '06' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls06 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '07' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls07 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '08' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls08 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '09' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls09 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '10' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls10 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '11' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls11 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '12' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	PtdSls12 = SUM(CASE WHEN (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'CM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'DM') 
                              Or (RIGHT(RTRIM(T.PerPost),2) = '13' AND T.TranType = 'IN') 
	                         Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),

	YtdCOGS = SUM(CASE WHEN ( T.TranType = 'CG') 
  	                        Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	YtdCostAdjd = SUM(CASE WHEN ( T.TranType = 'AJ') 
                                 Or ( T.TranType = 'AC') 
                                 Or ( T.TranType = 'PI') 
	                            Then (T.TranAmt * T.InvtMult) Else 0 End),
	YtdCostIssd = SUM(CASE WHEN (T.TranType = 'RI')
				    Then (T.ExtCost * T.InvtMult) * -1
			       WHEN (T.TranType = 'AS' and T.KitID <> '') 
	                         Or (T.TranType = 'II' and I.StkItem = 0) 
   	                            Then ((T.TranAmt * T.InvtMult) * -1) 
			       WHEN (T.TranType = 'II' and I.StkItem = 1)
				    Then ((T.ExtCost * T.InvtMult) * -1)
				Else 0 End),
	YtdCostRcvd = SUM(CASE WHEN (T.TranType = 'RC') 
	                         Or (T.TranType = 'AS' and T.KitID = '') 
   	                            Then (T.TranAmt * T.InvtMult) Else 0 End),
	YtdCostTrsfrIn = SUM(CASE WHEN ( T.TranType = 'TR' and T.ToSiteId = '') 
  	                               Then (T.TranAmt * T.InvtMult) Else 0 End),
	YtdCostTrsfrOut = SUM(CASE WHEN ( T.TranType = 'TR' and T.ToSiteId <> '') 
  	                                Then ((T.TranAmt * T.InvtMult) * -1) Else 0 End),
	YtdQtyAdjd = SUM(CASE WHEN ( T.TranType = 'AJ') 
                                Or ( T.TranType = 'AC') 
                                Or ( T.TranType = 'PI') 
	                           Then (T.Qty * T.InvtMult) Else 0 End),
	YtdQtyIssd = SUM(CASE WHEN ( T.TranType = 'RI') 				  
			        Or ( T.TranType = 'AS' and T.KitID <> '') 
	                        Or ( T.TranType = 'II') 
  	                           Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	YtdQtyRcvd = SUM(CASE WHEN ( T.TranType = 'RC') 
                                Or ( T.TranType = 'AS' and T.KitID = '') 
   	                           Then (T.Qty * T.InvtMult) Else 0 End),
	YtdQtySls = SUM(CASE WHEN ( T.TranType = 'CM' AND T.NoQtyUpdate = 0) 
                          Or ((T.TranType = 'DM' AND T.NoQtyUpdate = 0) 
                          Or (T.TranType = 'IN') AND T.NoQtyUpdate = 0) 
				Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	YtdQtyTrsfrIn = SUM(CASE WHEN (T.TranType = 'TR' and T.ToSiteId = '') 
  	                              Then (T.Qty * T.InvtMult) Else 0 End),
	YtdQtyTrsfrOut = SUM(CASE WHEN ( T.TranType = 'TR' and T.ToSiteId <> '') 
  	                               Then ((T.Qty * T.InvtMult) * -1) Else 0 End),
	YtdSls = SUM(CASE WHEN ( T.TranType = 'CM') 
                            Or ( T.TranType = 'DM') 
                            Or ( T.TranType = 'IN') Then ((T.TranAmt * T.InvtMult) * -1)
                          Else 0 End)
        FROM vp_10990_ItemHist_INTran T, Inventory I 
	Where T.Invtid = I.Invtid
        Group By  T.InvtId, T.SiteId, T.Fiscyr

 

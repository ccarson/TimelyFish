 

/****** Object:  View dbo.vp_10400_UpdateItemHist_INTran    Script Date: 7/13/98 11:18:43 AM ******/
CREATE VIEW vp_10990_ItemHist_INTran As

    SELECT BMITranAmt = Case When T.TranType IN ('TR','AS') and T.TranDesc='Standard Cost Variance'
                                  Then 0 
                                  Else BMITranAmt 
                        End,
           T.KitID, 
           T.CnvFact,
           T.Cpnyid,
           FiscYr = (SUBSTRING(T.PerPost, 1, 4)), 
           T.InvtId,
	   T.InvtMult,
           T.PerPost,
           Qty = Case 
                    When (T.TranType IN ('TR','AS') 
                          and T.TranDesc='Standard Cost Variance') 
                       Then 0 
                    Else Case 
                            When CnvFact = 0 
                               Then T.Qty 
                            Else Case 
                                    When T.UnitMultDiv = 'D' 
                                       Then Round((T.Qty / T.CnvFact), S.DecPlQty) 
                                    Else Round((T.Qty * T.CnvFact), S.DecPlQty) 
                                    End
                            End 
                    End, 
           T.SiteId,
           T.ToSiteId,
           TranAmt = Case When T.TranType IN ('TR','AS') and T.TranDesc='Standard Cost Variance'
                             Then 0 
                          Else T.TranAmt
                          End,
	   T.ExtCost,
           T.TranType,
	   NoQtyUpdate = T.S4Future09
    FROM INTran T, INSetup S
       Where Rlsed = 1         


 

 

CREATE VIEW vp_10400_UpdateItemHist_INTran
As
    SELECT W.UserAddress,
           T.BatNbr,
           BMITranAmt = Case When T.TranType IN ('TR','AS') and T.TranDesc = 'Standard Cost Variance'
                                  Then 0 
                                  Else BMITranAmt 
                        End,
           T.KitID, 
           T.CnvFact,
           T.CostType,
           CurPer = (RIGHT(RTRIM(S.PerNbr), 2)),
           CurYr = (SUBSTRING(S.PerNbr, 1, 4)),
	   T.Crtd_Prog, 
           T.ExtCost,
           FiscYr = (SUBSTRING(T.PerPost, 1, 4)),
           T.InvtId,
           T.InvtMult,
           T.JrnlType,
           T.LineId,
           S.PerNbr,
           T.PerPost,
	   T.OvrhdFlag,
           Qty = Case When T.TranType IN ('TR','AS') and T.TranDesc = 'Standard Cost Variance' 
                           Then 0 
                           Else Case When CnvFact = 0 
                                          Then T.Qty 
                                          Else Case When T.UnitMultDiv = 'D' 
                                                         Then Round((T.Qty / T.CnvFact), S.DecPlQty) 
                                                         Else Round((T.Qty * T.CnvFact), S.DecPlQty) 
                                               End
                                End 
                 End, 
           T.RcptNbr,
           T.Rlsed,
           T.RcptDate,
           T.ShortQty,
           T.SiteId,
           T.SpecificCostId,
           T.ToSiteId,
           TranAmt = Case When T.TranType IN ('TR','AS') and T.TranDesc='Standard Cost Variance'
                                  Then 0 
                                  Else T.TranAmt
                     End,
           T.TranType,
           T.UnitMultDiv,
           NoQtyUpdate = T.S4Future09,
           UseTranCost = T.S4Future10,
           UnitPrice = 
		Case When CnvFact = 0 
			Then T.unitprice 
			Else
	        		Case When T.UnitMultDiv = 'D' 
        	                         Then Round((T.UnitPrice * T.CnvFact), S.DecPlPrcCst) 
                	                 Else Round((T.UnitPrice / T.CnvFact), S.DecPlPrcCst) 
                      	End
		End,
           T.WhseLoc,
           OrigJrnlType = convert(varchar(3), T.S4Future12)

         FROM 	INTran T, INSetup S, WrkRelease W
         Where 	T.BatNbr = W.BatNbr


 

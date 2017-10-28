 

/****** Object:  View dbo.vp_10400_UpdateTransfer_INTran    Script Date: 7/13/98 11:18:43 AM ******/
CREATE VIEW vp_10400_UpdateTransfer_INTran As

    SELECT W.UserAddress,
           T.BatNbr,
           S.DecPlQty,
           T.CnvFact,
           T.InvtId,
           T.InvtMult,
           Qty = Case When T.TranDesc='Standard Cost Variance' 
                           Then 0 
                           Else Case When CnvFact = 0 
                                          Then T.Qty 
                                          Else Case When T.UnitMultDiv = 'D' 
                                                         Then Round((T.Qty / T.CnvFact), S.DecPlQty) 
                                                         Else Round((T.Qty * T.CnvFact), S.DecPlQty) 
                                               End
                                End 
                 End, 
	   SiteId = Case When D.Status = 'P'
                              Then T.ToSiteId
                              Else T.SiteId
                    End,
           D.Status,
           D.TransferType,
           T.UnitMultDiv,
           NoQtyUpdate = T.S4Future09,
           UseTranCost = T.S4Future10,
           T.WhseLoc
         FROM INTran T, INSetup S, WrkRelease W, TrnsfrDoc D
         Where T.BatNbr = W.BatNbr
           And T.TranType = 'TR'
           And (T.BatNbr = D.BatNbr or T.BatNbr = D.S4Future11)
           And D.TransferType = '2'
           And T.Rlsed = 0
           And T.JrnlType <> 'OM'
	   And D.Source <> 'OM'

 

 CREATE PROC pp_PORelease_CalcAdj_Count
    @BatNbr VARCHAR (10)

as

Select Count(*)
       From vp_PORelease_Intran_TotQty v
               Join ItemSite S
                  On v.InvtId = s.InvtId
                 And v.SiteId = s.SiteId
       Where S.QtyOnHand < 0
         And v.Qty >= Abs(S.QtyOnHand)
         And v.BatNbr = @BatNbr
         And v.Rlsed = 0
         And v.Jrnltype = 'PO'



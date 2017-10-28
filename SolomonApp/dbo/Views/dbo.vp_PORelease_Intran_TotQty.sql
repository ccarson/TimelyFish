 

Create View vp_PORelease_Intran_TotQty

AS

SELECT t.JrnlType,
       t.BatNbr,
       t.InvtId,
       t.SiteId,
       t.Rlsed,
       Qty=SUM(t.Qty)
 FROM INTran t
 Where JrnlType = 'PO'
 GROUP BY t.JrnlType, t.BatNbr, t.InvtId, t.SiteId, t.Rlsed


 

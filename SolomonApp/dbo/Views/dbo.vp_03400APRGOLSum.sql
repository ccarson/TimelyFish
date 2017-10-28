 

CREATE VIEW vp_03400APRGOLSum AS

-- Purpose:  This view will return a summary amount of RGOL (Gain or Loss) for each 
--           Check Batch, at a Batch, Vendor, RefNbr level, released during this release 
--           pass.  
--    Note:  Since the UserAddress field cannot be qualified it is up to the code
--           using this view to then filter the result set returned by this view on 
--           UserAddress.

SELECT BatNbr  = w.BatNbr,
       VendID  = d.VendID,
       RefNbr  = d.RefNbr,
       RGOLAmt = SUM(t.TranAmt * CASE WHEN t.TranType = 'RL' Then -1 ELSE 1 END)
FROM WrkRelease w, APDoc d, APTran t
WHERE w.Module = "AP" AND
      w.BatNbr = d.BatNbr AND
      w.BatNbr = t.BatNbr AND
      d.RefNbr = t.RefNbr AND  
      d.BatNbr = t.BatNbr AND
      d.DocType IN ('CK', 'HC', 'EP') AND
      t.TranType IN ('RL', 'RG') 
GROUP BY w.BatNbr, d.VendId, d.RefNbr

 

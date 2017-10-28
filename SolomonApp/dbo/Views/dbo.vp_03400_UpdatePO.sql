 


CREATE VIEW dbo.vp_03400_UpdatePO AS 

Select distinct w.useraddress, p.ponbr, 
       StatusCount = Sum(Case When p.Vouchstage = 'F'
                              Then 0
                              Else 1
                         End)
from Purorddet p
     Join APTran t on t.ponbr = p.ponbr
     Join APDoc c  on c.batnbr = t.batnbr and c.doctype = t.trantype and c.refnbr = t.refnbr
     Join WrkRelease w 
                   on c.BatNbr = w.BatNbr
Where c.DocType <> 'VC' and w.module = "AP" and p.PurchaseType <> 'DL'
Group by p.ponbr,w.useraddress
     

 

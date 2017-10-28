 

CREATE view vr_03681_WITH_CK as
select  coeff = case when d.perclosed>j.perappl then -1 else 1 end,
        perclosed = case when d.perclosed>j.perappl then j.perappl else d.perclosed end,
        perpost = case when d.perclosed>j.perappl then j.perappl else d.perpost end,
 	refnbr = case when d.perclosed>j.perappl then j.adjgrefnbr else d.refnbr end,
	doctype  = case when d.perclosed>j.perappl then t.trantype else d.doctype end,
	d.acct, d.sub,
	d.cpnyid, d.vendid, 
       	d.S4Future11,
       	d.terms,  d.status,
       	d.CuryId, d.InvcNbr, d.DiscDate, d.MasterDocNbr,
       	d.User1,d.User2,
       	d.User3,d.User4,
       	d.User5,d.User6,
       	d.User7,d.User8,
       	d.Paydate, d.InvcDate,
        d.docdate, d.duedate,
        CuryOrigDocAmt  = case when d.perclosed>j.perappl then t.curytranamt else d.CuryOrigDocAmt end, 
        OrigDocAmt  = case when d.perclosed>j.perappl then t.tranamt else d.OrigDocAmt end, 
	d.rlsed
from apdoc d left outer join apadjust j on d.doctype=j.adjddoctype and d.refnbr=j.adjdrefnbr 
     left outer join aptran t
  on j.adjgrefnbr =t.refnbr and t.cpnyid=d.cpnyid and t.vendid=d.vendid and ( j.adjgdoctype not in ('CK', 'HC','EP') or ( j.adjgdoctype in ('CK', 'HC','EP') and t.drcr='C' ))


 

 

create view vp_24630Wrk as

select v.ri_id, v.cpnyid, v.curyid, v.doctype, v.refnbr, v.custid, v.vendid, docstatus=v.status, origrate=v.curyrate, origmultdiv=v.curymultdiv, 
v.curypmtamt,v.origbasepmtamt, v.calcrate, v.calcmultdiv, v.calcbasepmtamt,  
unrlgain=(case when (v.doctype not in ('AC', 'CM', 'VO') and v.calcbasepmtamt>v.origbasepmtamt) or (v.doctype in ('AC', 'CM', 'VO') and v.calcbasepmtamt<v.origbasepmtamt) then abs(v.calcbasepmtamt-v.origbasepmtamt) else 0 end),
unrlloss=(case when (v.doctype not in ('AC', 'CM', 'VO') and v.calcbasepmtamt<v.origbasepmtamt) or (v.doctype in ('AC', 'CM', 'VO') and v.calcbasepmtamt>v.origbasepmtamt) then abs(v.origbasepmtamt-v.calcbasepmtamt) else 0 end),
ugolacct=(case when (v.doctype not in ('AC', 'CM', 'VO') and v.calcbasepmtamt>v.origbasepmtamt) or (v.doctype in ('AC', 'CM', 'VO') and v.calcbasepmtamt<v.origbasepmtamt) then v.UnrlGainAcct else v.UnrlLossAcct end),
ugolsub=(case when (v.doctype not in ('AC', 'CM', 'VO') and v.calcbasepmtamt>v.origbasepmtamt) or (v.doctype in ('AC', 'CM', 'VO') and v.calcbasepmtamt<v.origbasepmtamt) then v.UnrlGainSub else v.UnrlLossSub end)
from vp_24630Docs v



 

 

create view vr_08740_Accrued as 

select d.*, r.RI_ID as riid
from RptRuntime r 
INNER JOIN RptCompany c ON c.RI_ID=r.RI_ID 
INNER JOIN ARDoc d ON d.CpnyID=c.CpnyID
LEFT OUTER JOIN ARDoc d1 on d1.CustID = d.CustID and d1.refnbr = d.refnbr and d1.doctype != d.doctype and d1.doctype in ('AD','RA') and d1.rlsed = 1
where d.rlsed = 1 and 
((d.doctype = 'AD' and d.perpost between r.begpernbr and r.endpernbr and (d.docbal != 0 or d.docbal = 0 and d1.perpost not between r.begpernbr and r.endpernbr)) or
(d.doctype = 'RA' and d.perpost between r.begpernbr and r.endpernbr and d1.perpost not between r.begpernbr and r.endpernbr ))


 

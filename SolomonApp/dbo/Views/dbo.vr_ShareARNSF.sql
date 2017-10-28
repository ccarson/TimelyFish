 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vr_ShareARNSF AS

select 
v.*,

HoldRP = (Case when (v.doctype = 'PA' 
                           and exists (select 'x'
                                         from aradjust j 
                                        where v.adjdrefnbr = j.adjdrefnbr 
                                          and v.refnbr     = j.adjgrefnbr
                                          and j.adjgdoctype = 'RP' 
                                          and v.custid = j.custid))  
                   then 'RP' else 'oo' end),

HoldNSF = (Case when (v.doctype = 'PA' 
                           and exists (select 'x'
                                         from aradjust j INNER JOIN ARDoc d ON j.S4Future11=d.BatNbr
                                        where v.adjdrefnbr = j.adjdrefnbr 
                                          and v.refnbr     = j.adjgrefnbr
                                          and j.adjgdoctype = 'RP' AND d.DocType='NS' 
                                          and v.custid = j.custid))  
                   then 'NS' else 'oo' end)

from vr_Sharearcustdetail v
where v.doctype <> 'VT'


 

 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vr_08610SelectAdjs AS

Select v.*,   

    gAdjAmt = g.AdjAmt, gAdjgDocDate = g.AdjgDocDate, 
    gAdjgPerPost = ISNull(g.AdjgPerPost,v.PerPost), 
    g.CuryAdjgAmt, jCuryAdjdAmt = j.CuryAdjdAmt, gCuryAdjdAmt = g.CuryAdjdAmt,

    jAdjAmt = j.AdjAmt, j.AdjDiscAmt, jAdjgDocDate = j.AdjgDocDate, 
    jAdjgPerPost = j.AdjgPerPost, j.CuryAdjdAmt, j.CuryAdjdDiscAmt,
    jPerAppl = j.perappl, gPerAppl = g.perappl,t.Descr


FROM vr_08610SelectDocs v 

Left Outer Join aradjust j on v.custid = j.custid and 

v.doctype = j.adjddoctype and v.refnbr = j.adjdrefnbr

Left Outer Join Aradjust g on v.custid = g.custid and v.refnbr = g.adjgrefnbr 
     and v.doctype = g.adjgdoctype

Left outer join terms t on v.terms = t.termsid

where 
((v.doctype = g.adjgdoctype or g.adjgdoctype is null or 
(v.doctype <> g.adjgdoctype and g.adjgdoctype in ('RP', 'NS', 'NC', 'SB')))
And v.DocType <> "RP")


 

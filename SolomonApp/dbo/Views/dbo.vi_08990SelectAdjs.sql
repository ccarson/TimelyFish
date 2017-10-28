 

Create View vi_08990SelectAdjs as

SELECT i.custid, i.doctype , i.refnbr,
       curyorigdocamt =  CONVERT(dec(23,3),i.curyorigdocamt),
       origdocamt = CONVERT(dec(23,3),i.origdocamt), 
       curydocbal = CONVERT(dec(23,3),i.curydocbal), 
       docbal = CONVERT(dec(23,3),i.docbal), 
       rgolamt = CONVERT(dec(23,3),i.rgolamt), 
       curyadjamt = CONVERT(dec(23,3), ISNULL(g.curyadjgamt,0)),
       adjamt = CONVERT(dec(23,3), ISNULL(g.adjamt,0)),  
       curyadjdiscamt = CONVERT(dec(23,3), ISNULL(g.curyadjgdiscamt,0)), 
       adjdiscamt = CONVERT(dec(23,3), ISNULL(g.adjdiscamt,0))
FROM ArDoc i LEFT JOIN ArAdjust g
                    ON g.custid = i.custid AND g.Adjgrefnbr = i.refnbr AND 
                       g.adjgdoctype = i.doctype 
 WHERE  i.rlsed = 1 AND 
        i.doctype IN ('PA', 'PP', 'CM', 'SB') 

UNION ALL

SELECT i.custid, i.doctype , i.refnbr,
       curyorigdocamt =  CONVERT(dec(23,3),i.curyorigdocamt),
       origdocamt = CONVERT(dec(23,3),i.origdocamt), 
       curydocbal = CONVERT(dec(23,3),i.curydocbal), 
       docbal = CONVERT(dec(23,3),i.docbal), 
       rgolamt = CONVERT(dec(23,3),i.rgolamt), 
       curyadjamt = CONVERT(dec(23,3), ISNULL(d.curyadjdamt,0)),
       adjamt = CONVERT(dec(23,3), ISNULL(d.adjamt,0)),  
       curyadjdiscamt = CONVERT(dec(23,3), ISNULL(d.curyadjddiscamt,0)), 
       adjdiscamt = CONVERT(dec(23,3), ISNULL(d.adjdiscamt,0))
FROM ArDoc i LEFT JOIN ArAdjust d 
                    ON d.custid = i.custid AND d.adjdrefnbr = i.refnbr AND
                       d.adjddoctype = i.doctype
             LEFT JOIN Terms t 
                    ON i.Terms = t.TermsID
 WHERE  i.rlsed = 1 AND 
        i.doctype IN ('IN', 'DM', 'NC', 'FI', 'SC', 'NS', 'RP') AND
        ISNULL(t.TermsType, '') <> 'M'


 

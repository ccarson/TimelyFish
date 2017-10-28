 
create view vr_08611_docs as 
SELECT r.ri_id, rc.cpnyname,
       d.cpnyid, d.custid, d.doctype,
       d.refnbr, d.docdate, d.perpost,
       d.terms, d.perclosed,d.curyid, 
       ARAcct = CASE d.Doctype WHEN 'PA' THEN c.ARAcct WHEN 'PP' THEN c.PrePayAcct ELSE d.BankAcct END, 
       ARSub = CASE d.DocType WHEN 'PA' THEN c.ARSub WHEN 'PP' THEN c.PrePaySub ELSE d.BankSub END,
       r.reportdate,
       jadjamt = ISNULL(j.adjamt,0),
       gadjamt = ISNULL(g.adjamt,0),
       jcuryadjdamt = ISNULL(j.curyadjdamt,0),
       gcuryadjgamt = ISNULL(g.curyadjgamt,0),
       -- Period sensitive OrigDocAmt
       -- If document had applications to/from it before the document itself was posted, those applications
       -- took place before the document had an inital value, thus 0 out origdocamt in this case.
       CalcdCuryOrigDocAmt = CASE WHEN d.Perpost > r.begpernbr
                                  THEN 0        
                                ELSE
                                  CASE WHEN  (d.doctype in ('PA', 'PP', 'CM', 'SB', 'RA')) 
                                         THEN -d.CuryOrigDocAmt 
                                       ELSE  d.CuryOrigDocAmt 
                                  END
                           END, 
       CuryOrigDocAmt = CASE WHEN  (d.doctype in ('PA', 'PP', 'CM', 'SB', 'RA')) 
                              THEN -d.CuryOrigDocAmt 
                             ELSE  d.CuryOrigDocAmt 
                        END,
       DueDate = CASE WHEN  d.doctype IN ('PA', 'PP', 'CM', 'SB', 'RA')
                                        OR duedate = CONVERT(smalldatetime,' ') 
                   THEN CASE d.docdate 
                        WHEN CONVERT(smalldatetime,' ') 
                        THEN GETDATE() 
                        ELSE d.docdate
                        END
                   ELSE  d.duedate 
                   END, 
       -- Period sensitive OrigDocAmt.
       -- If document had applications to/from it before the document itself was posted, those applications
       -- took place before the document had an inital value, thus 0 out origdocamt in this case
       CalcdOrigDocAmt = CASE WHEN d.Perpost > r.begpernbr
                                  THEN 0        
                                ELSE
                                  CASE WHEN  (d.doctype in ('PA', 'PP', 'CM', 'SB', 'RA')) 
                                         THEN -d.OrigDocAmt 
                                       ELSE  d.OrigDocAmt 
                                  END
                           END, 
       OrigDocAmt = CASE WHEN  (d.doctype in ('PA', 'PP', 'CM', 'SB', 'RA')) 
                           THEN -d.OrigDocAmt 
                         ELSE  d.OrigDocAmt 
                    END,
       	d.User1 as ARDocUser1, d.User2 as ARDocUser2, d.User3 as ARDocUser3, d.User4 as ARDocUser4, 
       	d.User5 as ARDocUser5, d.User6 as ARDocUser6, d.User7 as ARDocUser7, d.User8 as ARDocUser8                    
  FROM rptruntime r INNER  LOOP JOIN RptCompany rc ON r.ri_id = rc.ri_id
                    INNER JOIN ArDoc d ON d.cpnyid = rc.cpnyid
                                      AND d.s4Future01 <= r.begpernbr 
                                      AND (d.perclosed > r.begpernbr or perclosed = ' ')
                    LEFT  OUTER JOIN vr_08611_adjinv j ON d.custid = j.custid
                                                  AND d.refnbr = j.adjdrefnbr
                                                  AND d.doctype = j.adjddoctype
                                                  AND r.ri_id =j.ri_id
                    LEFT  OUTER JOIN vr_08611_adjchk g ON d.custid = g.custid
                                                  AND d.refnbr = g.adjgrefnbr
                                                  AND d.doctype = g.adjgdoctype
                                                  AND r.ri_id =g.ri_id
                    INNER JOIN Customer c ON d.Custid = c.Custid
 WHERE doctype NOT IN ('VT','RC','NS','RP')
   AND d.rlsed = 1 



 

 

CREATE view vr_03681_docs as 
SELECT r.ri_id, rc.cpnyname,
       d.acct APAcct, d.sub APSub,
       d.cpnyid, d.vendid, d.doctype,
       d.refnbr, d.docdate, d.perpost, d.S4Future11,
       d.terms, d.perclosed, d.status,
       d.CuryId, d.InvcNbr, d.DiscDate, d.MasterDocNbr,
       d.User1 docUser1,d.User2 docUser2,
       d.User3 docUser3,d.User4 docUser4,
       d.User5 docUser5,d.User6 docUser6,
       d.User7 docUser7,d.User8 docUser8,
       r.reportdate, d.Paydate,
       d.InvcDate,
       jadjamt = ISNULL(j.adjamt,0),
       jcuryadjdamt = ISNULL(j.curyadjdamt,0),
       CuryOrigDocAmt = CASE WHEN  d.doctype in ('AD','PP')
                         	THEN -d.CuryOrigDocAmt 
                          	ELSE  d.CuryOrigDocAmt 
                          END, 
       CurrBalance = CASE WHEN d.doctype = 'PP' 
                          THEN -d.curyorigdocamt + isnull(jpp.curyadjdamt,
                                                CASE WHEN j.ADJDRefNbr IS NOT NULL 
                                                     THEN CASE WHEN(SELECT VENDID 
                                                                      FROM APADJUST vc
                                                                     WHERE vc.ADJDREFNBR = j.ADJDRefNbr 
                                                                     and vc.ADJGDocType = 'VC' 
                                                                     and vc.AdjdDocType = 'PP' 
                                                                      AND vc.VENDID = d.vendid
                                                                      AND vc.perappl <= r.begpernbr)IS NULL 
                                                                THEN 0
                                                                ELSE d.curyorigdocamt
                                                                 END
                                                     ELSE d.curyorigdocamt END)
		     	ELSE
		     CASE WHEN  d.doctype in( 'AD')
                      	     THEN -convert(dec(28,3),d.CuryOrigDocAmt)
			  WHEN d.doctype in ('CK','HC','EP')
			     THEN convert(dec(28,3),(d.CuryDocBal))
                      	     ELSE  convert(dec(28,3),d.CuryOrigDocAmt)				
                      END - (CASE WHEN d.doctype IN ('CK','HC','EP')
                                     THEN ISNULL(c.curyadjgamt,0)
                                     ELSE ISNULL(j.curyadjdamt,0)
                                 END) 
		      END,
       DueDate = CASE WHEN  duedate = CONVERT(smalldatetime,'') 
                   	 THEN CASE d.docdate 
                      		WHEN CONVERT(smalldatetime,'') 
                         	   THEN GETDATE() 
                         	   ELSE d.docdate
                        	END
                   	ELSE  d.duedate 
                   END, 
       OrigDocAmt = CASE WHEN  d.doctype in ( 'AD', 'PP') 
                      	    THEN -d.OrigDocAmt 
                      	    ELSE  d.OrigDocAmt 
                      END,
       Balance =   CASE WHEN d.doctype = 'PP' 
                        THEN -d.origdocamt + isnull(jpp.adjamt + jpp.curyrgolamt,
                                                CASE WHEN j.ADJDRefNbr IS NOT NULL 
                                                     THEN CASE WHEN(SELECT VENDID 
                                                                      FROM APADJUST vc
                                                                     WHERE vc.ADJDREFNBR = j.ADJDRefNbr 
                                                                     and vc.ADJGDocType = 'VC' 
                                                                     and vc.AdjdDocType = 'PP' 
                                                                      AND vc.VENDID = d.vendid
                                                                      AND vc.perappl <= r.begpernbr)IS NULL 
                                                                THEN 0
                                                                ELSE d.OrigDocAmt
                                                                 END
                                                     ELSE d.origdocamt END)
			ELSE
		  CASE WHEN  d.doctype in ( 'AD')
                        THEN -convert(dec(28,3),d.OrigDocAmt)
		     WHEN d.doctype in ('CK','HC','EP')
			THEN convert(dec(28,3),(d.DocBal))
                        ELSE convert(dec(28,3),d.OrigDocAmt)
                   END - (CASE WHEN d.doctype IN ('CK','HC','EP')
                                  THEN ISNULL(c.adjamt,0)
                                  ELSE ISNULL(j.adjamt,0)				   
                             END) 
		   END
 
         FROM rptruntime r INNER LOOP JOIN RptCompany rc ON r.ri_id = rc.ri_id
                    JOIN ApDoc d ON d.cpnyid = rc.cpnyid
                                      AND d.perpost <= r.endpernbr 
                                      AND 
			(d.perclosed > r.begpernbr or perclosed = '' OR
					(d.doctype IN ('PP','CK','HC','EP')))
                    LEFT  OUTER JOIN vr_03681_adjvo j ON d.vendid = j.vendid
							AND d.refnbr = j.adjdRefnbr
							AND d.doctype = j.adjdDoctype
							AND r.ri_id = j.ri_id
		    LEFT OUTER JOIN vr_apreport_adjpp jpp ON d.vendid = jpp.vendid
							    AND d.refnbr = jpp.adjdRefnbr
							    AND d.doctype = jpp.adjdDoctype
							    AND r.ri_id = jpp.ri_id
		    LEFT  OUTER JOIN vr_03681_adjchk c ON d.vendid = c.vendid
							 AND d.refnbr = c.adjgRefnbr
							 AND d.acct = c.adjgacct
							 AND d.sub = c.adjgsub
							 AND r.ri_id =c.ri_id
                                       
 WHERE (doctype IN ('VO','AD','AC','PP')
   AND d.status <> 'V' OR doctype IN ('HC','EP','CK')
   AND (d.perclosed > r.begpernbr or perclosed = '' or ISNULL(c.curyadjgamt,0) <> 0))
   AND d.rlsed = 1


 

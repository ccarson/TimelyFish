 
--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_Rebuild_1099 AS 

/****** Rebuild amounts for 1099 Docs.		        	******/
SELECT d.CpnyID, d.VendId,  
	CalendarYr = LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate)))),  
	
	Box00 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '1' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box01 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '2' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box02 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '3' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt  + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box03 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '4' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* j.AdjAmt
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END) * -1,
	Box04 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '5' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box05 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '6' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box06 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '7' OR COALESCE(t3.BoxNbr, t.BoxNbr) = '25'THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld) 
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box07 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '8' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
        Box09 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '10' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
        Box11 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '26' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),			
		Box13 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '13' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
					  (CASE WHEN t3.RefNbr IS NOT NULL THEN
					CASE WHEN d3.OrigDocAmt <> 0 THEN
							  d3.OrigDocAmt 
							 ELSE
												  t3.TranAmt
											 END
					   ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
							  d2.OrigDocAmt 
							 ELSE
							  t.TranAmt
											 END
				END))* (j.AdjAmt + j.AdjBkupWthld)
				 * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
			ELSE 0 END),
		Box14 = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '14' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
					  (CASE WHEN t3.RefNbr IS NOT NULL THEN
					CASE WHEN d3.OrigDocAmt <> 0 THEN
							  d3.OrigDocAmt 
							 ELSE
												  t3.TranAmt
											 END
					   ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
							  d2.OrigDocAmt 
							 ELSE
							  t.TranAmt
											 END
				END))* (j.AdjAmt + j.AdjBkupWthld)
				 * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
			ELSE 0 END),
        Box15a = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '15' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
        Box15b = SUM(CASE WHEN COALESCE(t3.BoxNbr, t.BoxNbr) = '25' THEN 
			 (COALESCE(t3.TranAmt, t.TranAmt) / 
			          (CASE WHEN t3.RefNbr IS NOT NULL THEN
				 	CASE WHEN d3.OrigDocAmt <> 0 THEN
				 	          d3.OrigDocAmt 
				             ELSE
                                                  t3.TranAmt
                                             END
			           ELSE CASE WHEN d2.OrigDocAmt <> 0 THEN
				 	          d2.OrigDocAmt 
				             ELSE
					          t.TranAmt
                                             END
			    END))* (j.AdjAmt + j.AdjBkupWthld)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END)
        FROM 	Vendor v join APDoc d on v.vendid = d.vendid
	join APAdjust j on d.refnbr = j.adjgrefnbr and
				d.doctype = j.adjgdoctype and
				d.acct = j.adjgacct and
				d.sub = j.adjgsub
	join apdoc d2 on j.adjdrefnbr = d2.refnbr and
				j.adjddoctype = d2.doctype
	left join apdoc d3 on d2.prepay_refnbr = d3.refnbr and
				d3.doctype = 'PP' and 
				d2.prepay_refnbr <> ''
	left join APAdjust j3 on d.refnbr = j3.adjgrefnbr and
				d.doctype = j3.adjgdoctype and
				d.acct = j3.adjgacct and
				d.sub = j3.adjgsub and
				j3.adjddoctype = d3.doctype and
				j3.adjdrefnbr = d3.refnbr 
	left join aptran t on j.adjdrefnbr = t.refnbr and
				j.adjddoctype = t.trantype and 
				j3.adjdrefnbr is null
	left join aptran t3 on j3.adjdrefnbr = t3.refnbr and
				j3.adjddoctype = t3.trantype 
	where d.DocType IN ('HC','EP','CK', 'VC', 'ZC') AND
		v.Vend1099 = 1 AND
		COALESCE(t3.BoxNbr, t.BoxNbr, '') <> '' AND
		COALESCE(t3.TranAmt, t.TranAmt, 0) <> 0


GROUP BY  d.VendId, d.CpnyID, LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate))))



 

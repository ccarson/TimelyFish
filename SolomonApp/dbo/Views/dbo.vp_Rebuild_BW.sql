 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_Rebuild_BW AS 

/****** Backup Withholding amounts 1099 Docs.		        	******/
SELECT  d.CpnyID, d.VendId,
	CalendarYr = LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate)))), 
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
			    END))* (ROUND(j.AdjAmt, 2) + ROUND(j.AdjBkupWthld, 2) + CASe when j.AdjDiscAmt <> 0  then ROUND(j.AdjDiscAmt, 2) else 0 end)
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END)
        FROM 	Vendor v join APDoc d on v.vendid = d.vendid
	join APAdjust j on d.refnbr = j.adjgrefnbr and
				d.doctype = j.adjgdoctype and
				d.acct = j.adjgacct and
				d.sub = j.adjgsub 
				and j.AdjBkupWthld <> 0 
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
	left join aptran t on j.adjgrefnbr = t.refnbr and
				j3.adjdrefnbr is null and t.tranamt = j.adjbkupwthld
	left join aptran t3 on j3.AdjgRefNbr = t3.refnbr 				
	where d.DocType IN ('HC','EP','CK', 'VC', 'ZC') AND
		v.Vend1099 = 1 AND
		COALESCE(t3.BoxNbr, t.BoxNbr, '') = '4' AND
		COALESCE(t3.TranAmt, t.TranAmt, 0) <> 0
GROUP BY  d.VendId, d.CpnyID, LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate))))

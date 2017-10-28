 
create view vr_03681_adjchk as

SELECT SUM((CASE COALESCE(p.Status,'') WHEN 'V' THEN CASE
		  WHEN j.AdjgDocType <> 'VC' AND r.begpernbr < COALESCE(d.perpost ,'') OR  j.AdjgDocType = 'VC' AND r.begpernbr < COALESCE(d.perpost ,'') AND r.begpernbr >= COALESCE(p.perpost ,'999999')
		    THEN convert(dec(28,3),(Adjamt+AdjDiscAmt)) 
		    ELSE 0 END
	    ELSE CASE
		  WHEN r.begpernbr < COALESCE(d.perpost ,'')
		    THEN convert(dec(28,3),(Adjamt+AdjDiscAmt)) 
		    ELSE 0 END 
              END) * CASE WHEN adjddoctype = 'AD' 
			     THEN 1 
			     ELSE -1 
		       END)  adjamt,  
       SUM((CASE COALESCE(p.Status,'') WHEN 'V' THEN CASE
		  WHEN j.AdjgDocType <> 'VC' AND r.begpernbr < COALESCE(d.perpost ,'') OR  j.AdjgDocType = 'VC' AND r.begpernbr < COALESCE(d.perpost ,'') AND r.begpernbr >= COALESCE(p.perpost ,'999999')
		    THEN convert(dec(28,3),(CASE WHEN CuryAdjdCuryID<>COALESCE(p.CuryID,CuryAdjdCuryID)
                    THEN CuryAdjgAmt+CuryAdjgDiscAmt ELSE CuryAdjdAmt+CuryAdjdDiscAmt END)) 
		    ELSE 0 END
	    ELSE CASE
		  WHEN r.begpernbr < COALESCE(d.perpost ,'')
		    THEN convert(dec(28,3),(CASE WHEN CuryAdjdCuryID<>COALESCE(p.CuryID,CuryAdjdCuryID)
                    THEN CuryAdjgAmt+CuryAdjgDiscAmt ELSE CuryAdjdAmt+CuryAdjdDiscAmt END)) 
		    ELSE 0 END 
	      END) * CASE WHEN adjddoctype = 'AD' 
			     THEN 1 
			     ELSE -1 
		       END)  curyadjgamt,
       j.VendId,
       j.adjgrefnbr,
       j.adjgacct,
       j.adjgsub,
       r.RI_ID
  FROM ApAdjust j LEFT OUTER JOIN ApDoc d ON
		d.doctype = j.adjdDoctype
                AND d.refnbr = j.adjdRefnbr
                LEFT JOIN APDoc p ON p.DocType=j.AdjgDocType AND p.RefNbr=j.AdjgRefNbr
                AND p.Acct=j.AdjgAcct AND p.Sub=j.AdjgSub
CROSS JOIN RPTRunTime r WHERE J.PERAPPL <= R.BEGPERNBR  
GROUP BY r.ri_id,
       j.vendid,
       j.adjgrefnbr,
       j.adjgacct,
       j.adjgsub


 

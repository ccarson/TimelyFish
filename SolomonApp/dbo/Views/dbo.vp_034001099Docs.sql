 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_034001099Docs AS 

/****** File Name: 0316vp_034001099Docs.Sql			******/	
/****** Last Modified by Scott Guan on 10/02/98 at 12:57 am 	******/
/****** Select/Calculate amounts for 1099 Docs.			******/


SELECT w.UserAddress, d.CpnyID, d.CuryID, d.VendId, 
	CalendarYr = LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate)))),  
	Amount = SUM(CASE d.doctype WHEN 'ZC' then t.TranAmt
				     ELSE (t.TranAmt / d2.OrigDocAmt) * j.AdjAmt  END
			*(CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)),
	Box00 = SUM(CASE WHEN t.BoxNbr = '1' THEN 
			CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
			   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END 
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END  ),
	Box01 = SUM(CASE WHEN t.BoxNbr = '2' THEN 
			CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
			   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld))  END
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box02 = SUM(CASE WHEN t.BoxNbr = '3' THEN 
			CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
			   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box03 = SUM(CASE WHEN t.BoxNbr = '4' THEN 
			CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE (t.TranAmt / 
			   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* j.AdjAmt END 
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)) * -1  + isnull((select sum(tranamt) from VP_03400_BWTRANS vpb
											where vpb.UserAddress = w.UserAddress and vpb.Vendid = d.Vendid ), 0 ),
	Box04 = SUM(CASE WHEN t.BoxNbr = '5' THEN 
			CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE (t.TranAmt / 
			   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld) END 
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box05 = SUM(CASE WHEN t.BoxNbr = '6' THEN 
			CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE (t.TranAmt / 
			   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld) END 
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box06 = SUM(CASE WHEN t.BoxNbr = '7' OR t.BoxNbr = '25' THEN 
			CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
			   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END 
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box07 = SUM(CASE WHEN t.BoxNbr = '8' THEN 
			CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
			   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box08 = SUM(CASE WHEN t.BoxNbr = '9' THEN 
			CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
			   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt  WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END
			     * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		    ELSE 0 END),
	Box09 = SUM(CASE WHEN t.BoxNbr = '10' THEN 
		CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
		   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt  WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END
			 * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		ELSE 0 END),
	Box11 = SUM(CASE WHEN t.BoxNbr = '26' THEN 
		CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
		   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt  WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END
			 * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		ELSE 0 END),		
	Box12 = SUM(CASE WHEN t.BoxNbr = '13' THEN 
		CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
		   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt  WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld )) END
			 * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		ELSE 0 END),
	Box13 = SUM(CASE WHEN t.BoxNbr = '14' THEN 
		CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
		   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt  WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END
			 * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		ELSE 0 END),
	Box15a = SUM(CASE WHEN t.BoxNbr = '15' THEN 
		CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
		   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt  WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END 
			 * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		ELSE 0 END),
	Box15b = SUM(CASE WHEN t.BoxNbr = '25' THEN 
		CASE d.doctype WHEN 'ZC' THEN t.TranAmt ELSE ((t.TranAmt / 
		   (CASE d2.DocType WHEN 'HC' THEN d2.PmtAmt  WHEN 'EP' THEN d2.PmtAmt ELSE d2.OrigDocAmt END))* (j.AdjAmt + j.AdjBkupWthld)) END
			 * (CASE j.AdjdDocType WHEN 'AD' THEN -1 ELSE 1 END)
		ELSE 0 END)
FROM APDoc d, APAdjust j, APTran t, APDoc d2, Vendor v, WrkRelease w
WHERE d.DocType IN ('HC','EP','CK', 'VC', 'ZC') AND d.VendId = v.Vendid AND v.Vend1099 = 1 AND
	j.AdjgRefNbr = d.RefNbr AND j.AdjgDocType = d.DocType AND j.AdjgAcct = d.Acct and j.AdjgSub = d.Sub and j.VendID = d.VendID AND
	t.RefNbr = j.AdjdRefNbr AND (t.TranType = j.AdjdDocType or t.trantype = 'BW') AND t.LineNbr < 0 AND
	d2.RefNbr = j.AdjdRefNbr AND d2.DocType = j.AdjdDocType AND 
	w.BatNbr = d.Batnbr AND w.Module = 'AP' AND (t.BoxNbr <> ' ' or j.AdjBkupWthld <> 0)
GROUP BY w.UserAddress, d.VendId, d.CpnyID, d.CuryID, LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate))))

--******************************




 

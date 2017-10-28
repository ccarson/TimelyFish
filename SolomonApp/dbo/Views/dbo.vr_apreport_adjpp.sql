 

Create view vr_apreport_adjpp as 
SELECT pp.VendID, jp.adjdRefNbr, AdjdDocType = 'PP', Max(jpv.PerAppl) PerAppl, SUM(jpv.AdjAmt) AdjAmt, ri_id, SUM(jpv.curyadjdamt) curyadjdamt, SUM(jpv.curyrgolamt) curyrgolamt
FROM APDOC pp join AP_PPApplic p on pp.RefNbr = p.PrePay_RefNbr  JOIN APDOC d
	      	   ON pp.VendID = d.VendID and p.AdjdRefNbr = d.RefNbr AND d.DocType in ('VO','AC')
	      JOIN APAdjust jp
		   ON pp.VendID = jp.VENDID AND pp.DocType = jp.AdjdDocType AND pp.RefNbr = jp.AdjdRefNbr
	      JOIN APAdjust jpv -- adjustment where the pp was applied to the voucher
		   ON pp.VendID = jpv.VENDID AND d.DocType = jpv.AdjdDocType AND d.RefNbr = jpv.AdjdRefNbr
		        AND jp.AdjgRefNbr = jpv.AdjgRefNbr and jp.AdjgDocType = jpv.AdjgDocType AND jpv.AdjgDocType <> 'VC'
	      CROSS JOIN RPTRunTime r
WHERE pp.Doctype = 'PP' AND jpv.perappl <= r.begpernbr
GROUP BY pp.VendID, jp.adjdRefNbr, jp.AdjdDocType, ri_id

 

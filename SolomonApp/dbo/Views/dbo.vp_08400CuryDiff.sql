 

create view vp_08400CuryDiff as 
SELECT w.UserAddress, d.BatNbr, d.Custid, d.DocType, d.RefNbr,
MAX(CASE WHEN t.TranClass IN ('D', 'T') THEN 0 ELSE t.RecordID END) RecordID,
RoundDiff = 
ROUND(MAX (d.DocBal) -
CASE WHEN MAX (COALESCE (tx0.PrcTaxIncl, '')) = 'N' THEN MAX (d.TaxTot00) ELSE 0 END -
CASE WHEN MAX (COALESCE (tx1.PrcTaxIncl, '')) = 'N' THEN MAX (d.TaxTot01) ELSE 0 END -
CASE WHEN MAX (COALESCE (tx2.PrcTaxIncl, '')) = 'N' THEN MAX (d.TaxTot02) ELSE 0 END -
CASE WHEN MAX (COALESCE (tx3.PrcTaxIncl, '')) = 'N' THEN MAX (d.TaxTot03) ELSE 0 END -
SUM(CASE t.TranClass WHEN 'D' THEN -t.TranAmt ELSE t.TranAmt END), MAX (c.DecPl)) 
FROM WrkRelease w
	INNER JOIN Batch b ON b.batnbr = w.batnbr AND b.module = w.module
	INNER JOIN ARDoc d ON d.BatNbr = b.BatNbr
	                  AND b.basecuryid <> d.curyid
	INNER JOIN Currncy c ON c.CuryID = b.BaseCuryID
	INNER JOIN ARTran t ON t.batnbr = d.batnbr AND t.refnbr = d.refnbr
                           AND t.trantype = d.doctype AND t.CustID = d.CustID
        LEFT JOIN SalesTax tx0 ON d.TaxID00 = tx0.TaxID
        LEFT JOIN SalesTax tx1 ON d.TaxID01 = tx1.TaxID
        LEFT JOIN SalesTax tx2 ON d.TaxID02 = tx2.TaxID
        LEFT JOIN SalesTax tx3 ON d.TaxID03 = tx3.TaxID
 WHERE w.Module = 'AR' AND b.editscrnnbr IN ('08010','08050') AND t.tranamt <> 0   
 GROUP BY w.UserAddress, d.BatNbr, d.Custid, d.DocType, d.RefNbr


 

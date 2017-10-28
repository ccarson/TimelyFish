 


CREATE VIEW vp_08400CorrectARInvoice as

Select w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr, 
CuryDocBal = sum(v.curytaxamt) + min(t.curytranamt),
CuryOrigDocAmt = sum(v.curytaxamt) + min(t.curytranamt),
CuryTaxTot00 = min(t.CuryTaxtot00),
CuryTaxTot01 = min(t.CuryTaxtot01),
CuryTaxTot02 = min(t.CuryTaxtot02),
CuryTaxTot03 = min(t.CuryTaxtot03),
CuryTxblTot00 = min(t.CuryTxbltot00),
CuryTxblTot01 = min(t.CuryTxbltot01),
CuryTxblTot02 = min(t.CuryTxbltot02),
CuryTxblTot03 = min(t.CuryTxbltot03),
DocBal = sum(v.taxamt) + min(t.tranamt),
OrigDocAmt = sum(v.taxamt) + min(t.tranamt),
TaxTot00 = min(t.Taxtot00),
TaxTot01 = min(t.Taxtot01),
TaxTot02 = min(t.Taxtot02),
TaxTot03 = min(t.Taxtot03), 
TxblTot00 = min(t.Txbltot00),
TxblTot01 = min(t.Txbltot01),
TxblTot02 = min(t.Txbltot02),
TxblTot03 = min(t.Txbltot03)

from wrkrelease w, batch b, vp_08400SumTaxTrans v, vp_08400SumARTrans t
where w.batnbr = b.batnbr and w.module = "AR" and b.module = "AR" and b.batnbr = t.batnbr 
and b.editscrnnbr+' ' = "08010"
and v.batnbr = t.batnbr and v.custid = t.custid and v.trantype = t.trantype and v.refnbr = t.refnbr
group by w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr




 

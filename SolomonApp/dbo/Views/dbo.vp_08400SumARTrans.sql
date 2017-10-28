 

Create view vp_08400SumARTrans as

select w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr, 
Curytranamt = sum(t.curytranamt),
Tranamt = sum(t.tranamt),
CuryTaxTot00 = sum(t.CuryTaxAmt00),
CuryTaxTot01 = sum(t.CuryTaxAmt01),
CuryTaxTot02 = sum(t.CuryTaxAmt02),
CuryTaxTot03 = sum(t.CuryTaxAmt03),
CuryTxblTot00 = sum(t.CuryTxblAmt00),
CuryTxblTot01 = sum(t.CuryTxblAmt01),
CuryTxblTot02 = sum(t.CuryTxblAmt02),
CuryTxblTot03 = sum(t.CuryTxblAmt03),
TaxTot00 = sum(t.TaxAmt00),
TaxTot01 = sum(t.TaxAmt01),
TaxTot02 = sum(t.TaxAmt02),
TaxTot03 = sum(t.TaxAmt03),
TxblTot00 = sum(t.TxblAmt00),
TxblTot01 = sum(t.TxblAmt01),
TxblTot02 = sum(t.TxblAmt02),
TxblTot03 = sum(t.TxblAmt03)
from wrkrelease w, artran t
where w.batnbr = t.batnbr and w.module = 'AR' 
And ((t.drcr = 'C' and t.trantype IN ('DM', 'IN', 'CS')) or 
(t.drcr = 'D' and t.trantype = 'CM'))
group by w.useraddress, t.batnbr, t.custid, t.trantype, t.refnbr




 

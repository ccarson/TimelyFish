 

CREATE VIEW vp_08400SumPATrans AS

SELECT t.batnbr, t.Refnbr, t.Custid, t.trantype, 
        SumTranAmt = Sum(convert(dec(28,3),Tranamt)), 
       SumCuryTranAmt = Sum(Convert(dec(28,3),curytranamt))
  FROM ARTran t
 WHERE t.rlsed = 0  And drcr = 'U' and t.trantype IN ('PA','CM','PP')
GROUP BY t.batnbr, t.refnbr, t.custid, t.trantype



 

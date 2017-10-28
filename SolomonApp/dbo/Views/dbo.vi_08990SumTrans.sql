 

CREATE View vi_08990SumTrans
AS 
SELECT Batnbr,custid,trantype,refnbr, 
       SUM(CASE WHEN TranClass = 'D' AND Trantype IN ('IN','DM') 
                 THEN -Tranamt -- Include Discounts from OM
                WHEN TranClass = 'D' AND Trantype NOT IN ('IN','DM')
                 THEN 0 --Exclude Discounts from AR
                ELSE TranAmt
            END) TranAmtTot
  FROM ARTran 
 WHERE (DRCR = 'C' or (DrCr = 'D' and TranClass='D')) AND 
       NOT (Tranamt <> 0 AND CuryTranamt = 0) --Exclude RGOL
 GROUP BY Batnbr,Custid,trantype,Refnbr


 

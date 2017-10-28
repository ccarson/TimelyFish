 

--APPTABLE
--USETHISSYNTAX

CREATE view vp_ExceptionAPPrcTaxIncl AS


SELECT t.UserAddress,  tBatNbr = t.batnbr, 
       tRefNbr = t.RefNbr,
       tTranTot= Sum( t.CurytaxAmt)
  FROM vp_SalesTaxAPTran t
  WHERE EXISTS(SELECT * FROM vp_SalesTaxID WHERE RecordID = t.TaxID AND PrcTaxIncl = 'Y')

 group by t.UserAddress, t.Batnbr, t.Refnbr



 

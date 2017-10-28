 

CREATE VIEW vp_SalesTaxARTranRls AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_SalesTaxARTranRls
*
*++* Narrative:  
*     
*
*
*   Called by: pp_08400, and vp_SalesTaxARPrcTaxIncl
* 
*/

SELECT  t.UserAddress, d.CpnyID, t.CuryId, t.CuryMultDiv, t.CuryRate, 
        t.CuryTaxAmt, t.CuryTranAmt, t.CuryTxblAmt, 
        t.DrCr, t.RefNbr, t.TaxAmt, t.TaxCalced, t.TaxCat,  
	t.TranAmt, t.TranDate, tRecordID = t.RecordID, t.TranType, 
        t.TxblAmt, d.BatNbr, dCuryId = d.CuryId, 
	dCuryMultDiv = d.CuryMultDiv, 
        CuryOrigDocAmt = CONVERT(dec(28,3),d.CuryOrigDocAmt), 
        dCuryRate = CONVERT(dec(19,6),d.CuryRate), 
        d.DocType, d.CustID, d.PerPost, d.OrigDocAmt,
	TaxAcct = CASE v.SlsTaxAcct WHEN ' ' THEN t.Acct ELSE v.SlsTaxAcct END, 
	TaxSub = CASE v.SlsTaxSub WHEN ' ' THEN t.Sub ELSE v.SlsTaxSub END, 
        v.TaxCalcLvl, v.Lvl2Exmpt, v.TaxID, v.TaxCalcType, 
        CONVERT(dec(9,6),v.TaxRate) TaxRate, c.DecPl, v.PrcTaxIncl, 
	TaxDate = LTRIM(RTRIM(STR(DATEPART(YEAR, d.DocDate)))) 
                  + RIGHT('0' + LTRIM(RTRIM(STR(DATEPART(MONTH, d.DocDate)))),2),
        v.RefType
  FROM  vp_SalesTaxARTran t INNER JOIN ARDoc d
                                  ON t.RefNbr = d.RefNbr
                                  AND t.TranType = d.DocType
                            INNER JOIN vp_SalesTax v
                                  ON t.TaxId = v.RecordId
                                  AND t.TaxCat = v.CatId
                            INNER JOIN Currncy c
                                  ON t.CuryId = c.CuryId



 

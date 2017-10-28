 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_08400Exception3 AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400Exception3
*
*++* Narrative: This view will remove Batches where Sales Tax ID is used 
*++*            as an individual tax and group tax in the same document.               
*
*
*   Called by: pp_08400prepwork
* 
*/
 
/***** Sales Tax ID is used as an individual tax and group tax in the same document *****/
SELECT DISTINCT v.UserAddress, Module = 'AR', d.BatNbr, MsgID = 6624
  FROM WrkRelease w INNER JOIN ARDoc d 
                          ON w.Batnbr = d.Batnbr 
                    INNER JOIN vp_SalesTaxARUsage v 
                          ON d.RefNbr = v.RefNbr 
                          AND d.DocType = v.TranType
                          AND v.UserAddress = w.UserAddress
 WHERE w.Module = 'AR'
GROUP BY d.BatNbr, v.refnbr, v.UserAddress, v.TaxID, v.RecordID
HAVING COUNT(*) > 1



 

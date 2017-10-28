 
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400ChkSumARDocs
*
*++* Narrative: This view will sum up the origdocamt, and curydocamt to make sure that  
*++* the totals match the batch totals.     
*
*
*   Called by: pp_08400prepwork
* 
*/

CREATE VIEW vp_08400ChkSumARDocs AS


SELECT w.useraddress, d.batnbr,
       CuryCtrlTot = sum(convert(dec(28,3),d.curyorigdocamt)),
       CtrlTot = sum(convert(dec(28,3),d.origdocamt))
  FROM wrkrelease w INNER JOIN ardoc d 
                            ON d.Batnbr = w.batnbr
                    INNER JOIN batch b 
                            ON b.module = w.module AND b.batnbr = d.batnbr 
                       --the totals can not sum the Small Balance Writeoff from the Payment Application screen, because 
                       --the batch totals do not include them until the batch is released. This is due to the fact that
                       --the Payment Application screen can only have the Payment's in the batch's total for the screen to balance.
 WHERE w.module = 'AR' AND NOT(b.EditScrnNbr = '08030' AND d.doctype = 'SB') 

 GROUP BY w.useraddress, d.batnbr

 

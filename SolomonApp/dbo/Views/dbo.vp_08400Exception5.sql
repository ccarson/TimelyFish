 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vp_08400Exception5 AS 
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400Exception5
*
*++* Narrative: This view will remove Batches where Taxtype is null for the taxid. 
*     
*
*
*   Called by: pp_08400prepwork
* 
*/

/***** MSG = Taxtype for taxid is null and must be populated with T for a tax or G for a group.  *****/
/***** Please correct and re-release batch 'XXXXXX'.                                                                        *****/

SELECT DISTINCT d.BatNbr, Module = 'AR', 
                msgid = 6958, w.UserAddress 
  FROM WrkRelease w INNER LOOP JOIN ardoc d 
                          ON w.batnbr = d.batnbr
                          AND d.doctype IN ('IN', 'CM', 'DM')
	            INNER LOOP JOIN salestax t 
                          ON (d.taxid00 = t.taxid OR d.taxid01 = t.taxid OR 
                              d.taxid02 = t.taxid OR d.taxid03 = t.taxid)
 WHERE w.module = 'AR' and t.taxtype = ' '


 

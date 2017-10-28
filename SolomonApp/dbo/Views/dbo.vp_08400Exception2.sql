 

--APPTABLE
--USETHISSYNTAX


CREATE VIEW vp_08400Exception2 AS 
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400Exception2
*
*++* Narrative: This view will remove Batches where Customer does not exist 
*++*            or Sales Tax ID does not exist.               
*
*
*   Called by: pp_08400prepwork
* 
*/


/***** Customer does not exist *****/
SELECT DISTINCT d.BatNbr, Module = 'AR', MsgID = 12347, w.UserAddress 
  FROM WrkRelease w INNER JOIN ARDoc d 
                          ON w.Module = 'AR' AND w.BatNbr = d.BatNbr
                     LEFT OUTER JOIN customer c
                          ON c.CustID = d.CustID
 WHERE d.CustID = ' ' OR  c.CustID IS null
	

UNION

/***** Sales Tax ID does not exist *****/
SELECT DISTINCT d.BatNbr, Module = 'AR', MsgID = 12348, w.UserAddress
  FROM wrkrelease w INNER JOIN ARdoc d 
                          ON w.Module = 'AR' AND w.BatNbr = d.BatNbr 
                     LEFT OUTER JOIN salestax s1 
                          ON taxid00 = s1.taxid
                     LEFT OUTER JOIN salestax s2 
                          ON taxid01 = s2.taxid
                     LEFT OUTER JOIN salestax s3 
                          ON taxid02 = s3.taxid
                     LEFT OUTER JOIN salestax s4 
                          ON taxid03 = s4.taxid
  WHERE ((taxid00 <> ' ' AND s1.taxid IS null) 
      OR (taxid01 <> ' ' AND s2.taxid IS null) 
      OR (taxid02 <> ' ' AND s3.taxid IS null) 
      OR (taxid03 <> ' ' AND s4.taxid IS null)) 

 

 

 

CREATE VIEW vp_08400ChkSumGlTrans AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400ChkSumGlTrans
*
*++* Narrative: This view will sum the GLTrans to see if the batch is in balance. 
*     
*
*
*   Called by: pp_08400
* 
*/

SELECT
    g.batnbr,
    curyid = MIN(g.curyid), 
    cramt = SUM(CONVERT(dec(28,3),g.cramt)), 
    dramt = SUM(CONVERT(dec(28,3),g.dramt)), 
    curycramt = SUM(CONVERT(dec(28,3),g.curycramt)), 
    curydramt = SUM(CONVERT(dec(28,3),g.curydramt))

  FROM wrkrelease w INNER JOIN gltran g
                          ON w.batnbr = g.batnbr
                          AND w.module = g.module
WHERE w.module = 'AR'
GROUP BY g.batnbr


 

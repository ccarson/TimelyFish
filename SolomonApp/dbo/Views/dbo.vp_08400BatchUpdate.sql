 


CREATE VIEW vp_08400BatchUpdate AS
/********************************************************************************
*             Copyright Solomon Software, Inc. 1994-1999 All Rights Reserved
*
*    View Name: vp_08400BatchUpdate
*
*++* Narrative: Computes batch DR/CR totals  
*     
*
*
*   Called by: pp_08400
* 
*/
SELECT CrTot =     (SELECT SUM(CONVERT(dec(28,3),CrAmt)) 
                      FROM GLTran g 
                     WHERE g.BatNbr = b.BatNbr AND g.Module = 'AR' 
                           AND g.trantype <> 'IC'),
       CuryCrTot = (SELECT SUM(CONVERT(dec(28,3),CuryCrAmt)) 
                      FROM GLTran g 
                     WHERE g.BatNbr = b.BatNbr AND g.Module = 'AR'
                           AND g.trantype <> 'IC'),
       DrTot =     (SELECT SUM(CONVERT(dec(28,3),DRAmt)) 
                      FROM GLTran g 
                     WHERE g.BatNbr = b.BatNbr AND g.Module = 'AR' 
                           AND g.trantype <> 'IC'),
       CuryDrTot = (SELECT SUM(CONVERT(dec(28,3),CuryDRAmt)) 
                      FROM GLTran g 
                     WHERE g.BatNbr = b.BatNbr AND g.Module = 'AR'
                           AND g.trantype <> 'IC'),
       DocCount =  (SELECT COUNT(BatNbr) 
                      FROM GLTran g 
                     WHERE g.BatNbr = b.BatNbr AND g.Module = 'AR' 
                           AND g.trantype <> 'IC'),
       b.BatNbr
  FROM WrkRelease w INNER JOIN Batch b
                        ON w.BatNbr = b.BatNbr
                        AND w.module = b.module
 WHERE w.Module = 'AR'
  



 

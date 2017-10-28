 

CREATE VIEW vp_03400APBatchUpdate AS

/****** File Name: 0345vp_03400APBatchUpdate.Sql		******/
/****** Prepare records to be used updating batch status.	******/

SELECT b.BatNbr, Status = 'U',
        crAmt = SUM(convert(dec(28,3),CrAmt)), 
        crCuryAmt = SUM(convert(dec(28,3),CuryCrAmt)),
        DrAmt = SUM(convert(dec(28,3),DrAmt)), 
        DrCuryAmt = SUM(convert(dec(28,3),CuryDrAmt))
  FROM WrkRelease w WITH(NOLOCK) INNER LOOP JOIN Batch b
                       ON w.batnbr = b.batnbr AND w.Module = b.Module
                    INNER JOIN GLTran t
                       ON t.BatNbr = b.BatNbr 
 WHERE w.Module = 'AP' AND b.EditScrnNbr NOT IN ('03060')
   AND t.TranType NOT IN ( 'SC' ,'IC')
   AND t.Module = 'AP'
 GROUP BY b.BatNbr

UNION

SELECT b.BatNbr, Status = 'C', SUM(convert(dec(28,3),TranAmt)), SUM(convert(dec(28,3),CuryTranAmt)),
        SUM(convert(dec(28,3),TranAmt)), SUM(convert(dec(28,3),CuryTranAmt))
  FROM WrkRelease w WITH(NOLOCK) INNER LOOP JOIN Batch b
                     ON w.batnbr = b.batnbr AND w.Module = b.Module
                  INNER JOIN APTran t
                     ON t.BatNbr = b.BatNbr 
 WHERE b.EditScrnNbr = '03060' AND b.CtrlTot <> 0
 GROUP BY b.BatNbr



 

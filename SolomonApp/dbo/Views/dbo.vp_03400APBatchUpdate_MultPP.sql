
CREATE VIEW vp_03400APBatchUpdate_MultPP AS
						
/****** View to select all tax amounts for a given Document's Wrk08220ARDoc record  ******/

SELECT b.BatNbr, Status = 'U',
        crAmt = SUM(convert(dec(28,3),CrAmt)), 
        crCuryAmt = SUM(convert(dec(28,3),CuryCrAmt)),
        DrAmt = SUM(convert(dec(28,3),DrAmt)), 
        DrCuryAmt = SUM(convert(dec(28,3),CuryDrAmt))
  FROM WrkRelease w WITH(NOLOCK) INNER LOOP JOIN Batch b
                       ON w.batnbr = b.VOBatNbrForPP AND w.Module = b.Module
                    INNER JOIN GLTran t
                       ON t.BatNbr = b.VOBatNbrForPP 
 WHERE w.Module = 'AP' AND b.EditScrnNbr NOT IN ('03060')
 GROUP BY b.BatNbr



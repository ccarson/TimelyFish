 
CREATE VIEW vp_08400IncorrectRGOL AS

SELECT BatNbr = w.batnbr, UserAddress = w.UserAddress, AdjgRefNbr = j.AdjgRefNbr,
	CuryRGOLAmt = SUM(CONVERT(DEC(28,3),j.CuryRGOLAmt))
  FROM WRKRELEASE w INNER JOIN BATCH b  
                       ON w.BatNbr = b.BatNbr 
                      AND w.Module = b.Module
                    INNER JOIN ARAdjust j
                       ON b.BatNbr = j.AdjBatNbr
		    CROSS JOIN GLSetup g (NOLOCK)

 WHERE w.Module = 'AR' 
   AND j.CuryAdjdCuryId = g.BaseCuryId
   AND b.CuryID = g.BaseCuryId
 GROUP BY w.UserAddress, w.BatNbr, j.AdjgRefNbr


 

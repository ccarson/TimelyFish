 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_03400Exception1 AS 

/****** File Name: 0314vp_03400Exception1.Sql					******/
/****** Last Modified by DCR on 12/07/98 at 15:30 			******/
/****** Determine if records to be released violate exception rules. 	******/

/***** Batch is out of balance *****/

SELECT DISTINCT  d.BatNbr, w.Module,  Situation = 6019, w.UserAddress
FROM APDoc d, WrkRelease w,Currncy c
WHERE w.Module = "AP" AND w.BatNbr = d.BatNbr and d.curyid = c.curyid AND d.DocType <> "ZC" 
  AND d.DocType <> "SC" AND d.DocType <> "VC" AND d.DocType <> "MC" 
  AND (  (          








            (ROUND(d.CuryOrigDocAmt, c.DecPl) <> (SELECT ROUND(SUM(t.CuryTranAmt * SIGN(t.UnitPrice)), c.DecPl) 
                                            FROM APTran t 
                                           WHERE t.RefNbr = d.RefNbr AND t.TranType = d.DocType)
            )
            AND d.DocType IN ("CK")
           )  
        OR (
            (ROUND(d.CuryPmtAmt, c.DecPl) <> (SELECT ROUND(SUM(t.CuryTranAmt * SIGN(t.UnitPrice)), c.DecPl) 
                                          FROM APTran t 
                                         WHERE t.RefNbr = d.RefNbr AND t.TranType = d.DocType 
                                           AND t.Acct = d.Acct AND t.Sub = d.Sub) 
            OR d.CuryPmtAmt <> d.CuryOrigDocAmt) 
            AND d.DocType IN ("HC","EP")
           ) 
        OR ( 
            (SELECT COUNT(t.RefNbr) 
               FROM APTran t
              WHERE t.RefNbr = d.RefNbr AND t.TranType = d.DocType) = 0
                AND d.DocType NOT IN ("CK")
           )
      )


---SELECT DISTINCT w.UserAddress, Module = "AP", t.BatNbr, Situation = 6019
---  FROM WrkRelease w, APTran t 
---  LEFT JOIN APDoc d ON t.RefNbr = d.RefNbr AND t.TranType = d.DocType AND t.BatNbr = d.BatNbr
--- WHERE w.Module = "AP" AND w.BatNbr = t.BatNbr AND t.TranType IN ("VO", "AD", "AC") 
---   AND d.RefNbr is Null


 

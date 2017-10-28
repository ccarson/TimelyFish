 

CREATE VIEW vi_08990UpdArBal AS

SELECT d.CustID, d.CpnyID, d.PerPost, NbrInvcPaid = COUNT(*),
       PaidInvcDays = SUM(DATEDIFF(DAY,d.DocDate , jsum.AdjgDocDate)), jsum.AdjgPerPost
  FROM ARDoc d  JOIN (SELECT j.Custid, j.AdjdDocType, j.AdjdRefNbr, AdjgDocDate=MAX(j.AdjgDocDate), AdjgPerPost = Max(j.AdjgPerPost)
                        FROM ArAdjust j
                       WHERE j.S4Future12 NOT IN ('RP','NS') --This is to make sure that Reclassifications, and Voids are not taken into consideration.
                       		and j.AdjgDocType <> 'CM'
                       GROUP BY j.Custid, j.AdjdDocType, j.AdjdRefNbr) jsum

                  ON jsum.custid = d.custid AND jsum.AdjdRefNbr = d.RefNbr 
                            AND jsum.AdjdDocType = d.DocType
 WHERE d.Docbal = 0 AND d.Origdocamt <> 0 AND
       d.DocType IN ('IN','DM','NC','FI','AD')
 GROUP BY d.Custid, d.Cpnyid, d.PerPost, jsum.AdjgPerPost


 

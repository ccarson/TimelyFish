 


--APPTABLE
--USETHISSYNTAX

CREATE VIEW vr_ShareARDetail AS

SELECT DISTINCT Parent = CASE 
                WHEN v.Ord = 1 THEN d.RefNbr 
                WHEN v.Ord = 2 AND v.CNum = 1  
                    AND j.AdjdDocType NOT IN ('CM','PA','RF','SB','PP') 
                THEN j.AdjgRefNbr
                WHEN v.Ord = 2 AND v.CNum = -1  
                     AND j.AdjdDocType IN ('CM','PA','RF','SB','PP') 
                THEN j.AdjgRefNbr
                ELSE j.AdjdRefNbr END,
        v.Ord, d.CustID, dStatus = CASE Ord WHEN 1 THEN d.Status ELSE ' ' END, 
        RefNbr = CASE v.Ord WHEN 1 THEN d.RefNbr ELSE j.AdjgRefNbr END,
        DueDate = CASE v.Ord WHEN 1 THEN 
                                   (CASE WHEN d.doctype = 'NC' 
                                         THEN d.docdate 
                                         ELSE d.DueDate END) 
                             ELSE j.AdjgDocDate END,
        DiscDate = CASE v.Ord WHEN 1 THEN d.DiscDate ELSE j.AdjgDocDate END,
        DocDate = CASE v.Ord WHEN 1 THEN d.DocDate ELSE j.AdjgDocDate END,
        DocType = CASE v.Ord WHEN 1 THEN d.DocType 
                             WHEN 2 THEN j.AdjgDocType 
                             WHEN 3 THEN 'DT' END,
        DocDesc = CASE v.Ord WHEN 1 THEN d.DocDesc ELSE ' ' END,
        PerEnt = CASE v.Ord WHEN 3 THEN j.PerAppl ELSE d.PerEnt END,
        PerPost = CASE v.Ord 
		  WHEN 3 THEN j.PerAppl
		  WHEN 2 THEN j.PerAppl
		  ELSE d.PerPost END,
        PerClosed = CASE 
		    WHEN v.Ord = 3 THEN j.PerAppl 
		    WHEN v.Ord = 2 AND d.doctype IN ('CM','PA','RF','SB','PP') AND v.CNum = -1 
                    THEN j.PerAppl
                    ELSE d.PerClosed END,
        OrigDocAmt = CASE v.Ord 
		WHEN 1 THEN d.OrigDocAmt * (CASE WHEN d.DocType IN ('CM','PA','RF','SB','PP') 
                       THEN -1 ELSE 1 END)
		WHEN 2 THEN j.AdjAmt * v.CNum
		WHEN 3 THEN j.AdjDiscAmt * (CASE WHEN j.AdjdDocType IN ('CM','PA','RF','SB','PP') 
                                                 THEN 1 ELSE -1 END) 
                 END,
        DocBal = CASE v.Ord WHEN 1 
                            THEN d.DocBal * (CASE WHEN d.DocType IN ('CM','PA','RF','SB','PP') 
                                                  THEN -1 ELSE 1 END) 
                            ELSE 0 END,
        CuryOrigDocAmt = CASE v.Ord 
		WHEN 1 
                THEN d.CuryOrigDocAmt * (CASE WHEN d.DocType IN ('CM','PA','RF','SB','PP') 
                                              THEN -1 ELSE 1 END)
		WHEN 2 THEN j.CuryAdjdAmt * v.CNum
		WHEN 3 
                THEN j.CuryAdjdDiscAmt * (CASE WHEN j.AdjdDocType IN ('CM','PA','RF','SB','PP') 
                                               THEN 1 ELSE -1 END) 
                 END,
        CuryDocBal = CASE v.Ord 
                WHEN 1 
                THEN d.CuryDocBal * (CASE WHEN d.DocType IN ('CM','PA','RF','SB','PP') 
                                          THEN -1 ELSE 1 END) 
                ELSE 0 END,
        CuryID = CASE v.Ord WHEN 1 THEN d.CuryID ELSE j.CuryAdjdCuryID END,
        PDocType = CASE 
		WHEN v.Ord = 1 THEN d.DocType 
		WHEN v.Ord = 2 AND v.CNum = 1 AND j.AdjdDocType NOT IN ('CM','PA','RF','SB','PP') 
                 THEN d.DocType
		WHEN v.Ord = 2 AND v.CNum = -1 AND j.AdjdDocType IN ('CM','PA','RF','SB','PP') 
                 THEN d.DocType
		ELSE j.AdjdDocType END,
        AdjdRefNbr = CASE v.Ord WHEN 1 THEN d.RefNbr ELSE j.AdjdRefNbr END
FROM vr_ShareControlDoc32 v, ARDoc d LEFT OUTER JOIN ARAdjust j 
                                       ON j.AdjgRefNbr = d.RefNbr AND 
                                    (CASE WHEN (j.adjgdoctype in ('SB','RP') AND
                                                d.doctype IN ('PA','SB','PP','CM'))
                                          THEN d.doctype
                                          ELSE j.adjgdoctype 
                                           END) = d.doctype
                                      AND j.CustID = d.CustID
WHERE d.Rlsed = 1 AND (
	(v.Ord = 1) OR
	(v.Ord = 2 AND j.AdjgRefNbr IS NOT NULL) OR
	(v.Ord = 3 AND j.AdjDiscAmt <> 0 AND j.AdjgRefNbr IS NOT NULL))




 

 

CREATE VIEW vr_08620ARDetail AS

SELECT DISTINCT Parent = CASE 
		WHEN v.Ord = 1 THEN d.RefNbr 
		WHEN v.Ord = 2 AND v.CNum = 1 AND j.AdjdDocType NOT IN ("CM", "PA","RF","SB","PP") THEN j.AdjgRefNbr
		WHEN v.Ord = 2 AND v.CNum = -1 AND j.AdjdDocType IN ("CM", "PA","RF","SB","PP") THEN j.AdjgRefNbr
		ELSE j.AdjdRefNbr END,
	v.Ord, d.CustID, dStatus = CASE Ord WHEN 1 THEN d.Status ELSE ' ' END, 
	RefNbr = CASE v.Ord WHEN 1 THEN d.RefNbr ELSE j.AdjgRefNbr END,
	DueDate = CASE v.Ord WHEN 1 THEN (Case when d.doctype = "NC" then d.docdate Else d.DueDate End) ELSE j.AdjgDocDate END,
	DiscDate = CASE v.Ord WHEN 1 THEN d.DiscDate ELSE j.AdjgDocDate END,
	DocDate = CASE v.Ord WHEN 1 THEN d.DocDate ELSE j.AdjgDocDate END,
	DocType = CASE v.Ord WHEN 1 THEN d.DocType WHEN 2 THEN j.AdjgDocType WHEN 3 THEN "DT" END,
	DocDesc = CASE v.Ord WHEN 1 THEN d.DocDesc ELSE ' ' END,
	PerEnt = CASE v.Ord WHEN 3 THEN j.PerAppl ELSE d.PerEnt END,
	PerPost = CASE v.Ord WHEN 3 THEN j.AdjgPerPost ELSE d.PerPost END,
	PerClosed = CASE 
		WHEN v.Ord = 3 THEN j.PerAppl 
		WHEN v.Ord = 2 AND d.doctype in ("CM", "PA","RF","SB","PP") and v.CNum = -1 THEN j.PerAppl
                ELSE d.PerClosed END,
	OrigDocAmt = CASE v.Ord 
		WHEN 1 THEN d.OrigDocAmt * (CASE WHEN d.DocType IN ("CM", "PA","RF","SB","PP") THEN -1 ELSE 1 END)
		WHEN 2 THEN j.AdjAmt * v.CNum
		WHEN 3 THEN j.AdjDiscAmt * (CASE WHEN j.AdjdDocType IN ("CM", "PA","RF","SB","PP") THEN 1 ELSE -1 END) END,
	DocBal = CASE v.Ord WHEN 1 THEN d.DocBal * (CASE WHEN d.DocType IN ("CM", "PA","RF","SB","PP") THEN -1 ELSE 1 END) ELSE 0 END,
	CuryOrigDocAmt = CASE v.Ord 
		WHEN 1 THEN d.CuryOrigDocAmt * (CASE WHEN d.DocType IN ("CM", "PA","RF","SB","PP") THEN -1 ELSE 1 END)
		WHEN 2 THEN j.CuryAdjdAmt * v.CNum
		WHEN 3 THEN j.CuryAdjdDiscAmt * (CASE WHEN j.AdjdDocType IN ("CM", "PA","RF","SB","PP") THEN 1 ELSE -1 END) END,
	CuryDocBal = CASE v.Ord WHEN 1 THEN d.CuryDocBal * (CASE WHEN d.DocType IN ("CM", "PA","RF","SB","PP") THEN -1 ELSE 1 END) ELSE 0 END,
	CuryID = CASE v.Ord WHEN 1 THEN d.CuryID ELSE j.CuryAdjdCuryID END,
	PDocType = CASE 
		WHEN v.Ord = 1 THEN d.DocType 
		WHEN v.Ord = 2 AND v.CNum = 1 AND j.AdjdDocType NOT IN ("CM", "PA","RF","SB","PP") THEN j.AdjgDocType
		WHEN v.Ord = 2 AND v.CNum = -1 AND j.AdjdDocType IN ("CM", "PA","RF","SB","PP") THEN j.AdjgDocType
		ELSE j.AdjdDocType END,
	AdjdRefNbr = CASE v.Ord WHEN 1 THEN d.RefNbr ELSE j.AdjdRefNbr END
FROM vr_ShareControlDoc32 v (NOLOCK) CROSS JOIN dbo.ARDoc d (NOLOCK)
      LEFT OUTER JOIN dbo.ARAdjust j (NOLOCK) ON j.AdjgRefNbr = d.RefNbr AND 
      ((case j.adjgdoctype when "SB" then "PA" else j.adjgdoctype end) = (case d.DocType when "SB" then "PA" else d.doctype end))
 AND j.CustID = d.CustID
      CROSS JOIN (SELECT TOP 1 * FROM dbo.ARSETUP (NOLOCK)) ars
WHERE d.Rlsed = 1 AND (
      (v.Ord = 1) OR
      (v.Ord = 2 AND j.AdjgRefNbr is not NULL) OR
      (v.Ord = 3 AND j.AdjDiscAmt <> 0 AND j.AdjgRefNbr Is not NULL))
  AND (d.opendoc = 1 or 
       (CASE      WHEN v.Ord = 3 THEN j.PerAppl 
            WHEN v.Ord = 2 AND d.doctype in ("CM", "PA","RF","SB","PP") and v.CNum = -1 THEN j.PerAppl
                ELSE d.PerClosed END) >= ars.pernbr)


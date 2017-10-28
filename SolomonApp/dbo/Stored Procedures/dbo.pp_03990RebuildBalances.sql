 CREATE	PROCEDURE pp_03990RebuildBalances
AS
UPDATE	AP_Balances SET CurrBal=ROUND(bCurrent, cDecPl), FutureBal=ROUND(bFuture, cDecPl)
FROM	(SELECT	bVendID=sVendID, bCpnyID=sCpnyID, cDecPl=MAX(c.DecPl),
	bCurrent=SUM(ROUND(sCurrent, c.DecPl)), bFuture=SUM(ROUND(sFuture, c.DecPl))
FROM	(SELECT sVendID=v.VendID, sCpnyID=d.CpnyID,

	sCurrent=(CASE WHEN d.DocType IN('VO','AC') THEN 1 ELSE -1 END)*(CASE WHEN MAX(d.PerPost)<=MAX(v.PerNbr) THEN
	(CASE WHEN d.DocType<>'PP' OR MIN(COALESCE(j.VendID,''))='' THEN MAX(d.DocBal) ELSE 0 END)
	+SUM(CASE WHEN COALESCE(j.AdjgPerPost,'')>v.PerNbr OR COALESCE(j.AdjdDocType,'')='PP' THEN j.AdjAmt+j.AdjDiscAmt+j.AdjBkupWthld ELSE 0 END)
	ELSE -SUM(CASE WHEN COALESCE(j.AdjgPerPost,'999999')<=v.PerNbr THEN j.AdjAmt+j.AdjDiscAmt+j.AdjBkupWthld ELSE 0 END) END),

	sFuture=(CASE WHEN d.DocType IN('VO','AC') THEN 1 ELSE -1 END)*(CASE WHEN MAX(d.PerPost)>MAX(v.PerNbr) THEN
	(CASE WHEN d.DocType<>'PP' OR MIN(COALESCE(j.VendID,''))='' THEN MAX(d.DocBal) ELSE 0 END)
	+SUM(CASE WHEN COALESCE(j.AdjgPerPost,'999999')<=v.PerNbr THEN j.AdjAmt+j.AdjDiscAmt+j.AdjBkupWthld ELSE 0 END)
	ELSE -SUM(CASE WHEN COALESCE(j.AdjgPerPost,'')>v.PerNbr THEN j.AdjAmt+j.AdjDiscAmt+j.AdjBkupWthld ELSE 0 END) END)

	FROM Vendor v INNER JOIN APDoc d ON d.VendID=v.VendID LEFT JOIN APAdjust j ON j.VendID=d.VendID AND j.AdjdDocType=d.DocType
	AND j.AdjdRefNbr=d.RefNbr
	WHERE d.Rlsed=1 AND d.DocType IN('VO','AC','AD','PP')
	GROUP BY v.VendID, d.CpnyID, d.DocType, d.RefNbr) s
	CROSS JOIN GLSetup g (NOLOCK) INNER JOIN Currncy c (NOLOCK) ON c.CuryID=g.BaseCuryID
GROUP BY sVendID, sCpnyID) b
WHERE	bVendID=VendID AND bCpnyID=CpnyID




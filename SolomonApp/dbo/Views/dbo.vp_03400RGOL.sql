 

CREATE VIEW vp_03400RGOL AS

SELECT c.BatNbr, c.RefNbr , cDocType=min(c.doctype), t.CuryAdjdCuryId,
	cRGOLAmt = sum(convert(dec(28,3),t.curyrgolamt) * CASE WHEN t.AdjdDocType = 'AD' THEN -1 ELSE 1  END), d.cpnyid, w.UserAddress

 FROM APDoc d, APAdjust t, WrkRelease w, APDoc c
CROSS JOIN GLSetup g 
WHERE t.AdjBatNbr = w.BatNbr AND d.RefNbr = t.AdjdRefNbr AND w.Module = 'AP' AND
	d.DocType = t.AdjdDocType AND 
	((d.CuryID <> c.CuryID OR d.CuryRate <> c.CuryRate) OR (d.CuryID = c.CuryID AND c.CuryID <> g.BaseCuryID)) 
	AND 
	c.BatNbr = w.BatNbr AND c.BatNbr = t.AdjBatNbr AND c.RefNbr = t.AdjgRefNbr AND c.DocType = t.AdjgDocType
GROUP BY c.BatNbr, c.RefNbr, t.CuryAdjdCuryId, d.cpnyid, w.UserAddress

 

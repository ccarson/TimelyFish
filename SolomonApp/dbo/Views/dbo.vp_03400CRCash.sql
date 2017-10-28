 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_03400CRCash AS

/****** File Name: 0348vp_03400CRCash.Sql				******/
/****** Created by DCR on 12/13/98 at 11:42am 		******/

/****** Select/Calculate adjamt+RGOL Amount.				******/

SELECT t.AdjBatNbr, t.AdjgRefnbr, t.AdjgAcct, t.Adjgsub, t.AdjgDocType, cCRCash = SUM( (round(t.adjamt,3)+round(t.curyrgolamt,3))*
	CASE WHEN t.AdjdDocType = "AD" THEN -1 ELSE 1  END),cCuryCRgCash = SUM(t.curyadjgamt*CASE WHEN t.AdjdDocType = "AD" then -1 else 1 END), cCuryCRdCash = SUM(t.curyadjdamt*CASE WHEN t.AdjdDocType = "AD" then -1 else 1 END),
	t.CuryAdjdCuryId
FROM APAdjust t, WrkRelease w, APDoc c
WHERE t.AdjBatNbr = w.BatNbr AND w.Module = 'AP' AND
c.BatNbr = w.BatNbr AND c.BatNbr = t.AdjBatNbr AND c.RefNbr = t.AdjgRefNbr AND c.DocType = t.AdjgDocType
and c.acct = t.AdjgAcct and c.sub = t.Adjgsub
Group BY t.adjbatnbr,  t.AdjGDocType,  t.AdjgAcct, t.Adjgsub, t.AdjgRefNbr, t.CuryAdjdCuryId


 

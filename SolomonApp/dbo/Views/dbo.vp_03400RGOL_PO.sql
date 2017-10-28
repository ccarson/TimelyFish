 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_03400RGOL_PO AS

/****** File Name: 0347vp_03400RGOL_PO.Sql				******/
/****** Select/Calculate RGOL Amount for AP/PO.				******/

SELECT t.BatNbr, t.RefNbr, t.TranType, t.acct, t.sub, t.fiscyr, 
	tRGOLAmt = (sum(convert(dec(28,3),t.tranamt)) - 
			CASE when min(po.curymultdiv) = 'D' then
				convert(dec(28,3),round(sum(convert(dec(28,3),t.curytranamt) / convert(dec(19,9),po.curyrate)), max(Currncy.DecPl)))
			ELSE
				convert(dec(28,3),round(sum(convert(dec(28,3),t.curytranamt) * convert(dec(19,9),po.curyrate)), max(Currncy.DecPl)))
			end)
		* CASE WHEN min(t.TranType) = 'AD' THEN -1 ELSE 1 END, 
	t.cpnyid, w.UserAddress


FROM  WrkRelease w, APTran t, poreceipt po,
	GLSetup (NOLOCK), Currncy (NOLOCK)
WHERE t.BatNbr = w.BatNbr AND po.RcptNbr = t.RcptNbr AND w.Module = 'AP' AND
	(po.CuryID <> t.CuryID OR po.CuryRate <> t.CuryRate) AND
	GLSetup.BaseCuryID = Currncy.CuryID
GROUP BY t.BatNbr, t.RefNbr, t.trantype, t.cpnyid, t.acct, t.sub, t.fiscyr, w.UserAddress



 

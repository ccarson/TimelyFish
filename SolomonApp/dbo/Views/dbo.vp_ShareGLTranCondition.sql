 

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_ShareGLTranCondition AS

SELECT w.UserAddress, t.BatNbr, t.Module, DrAmt = SUM(t.DrAmt), CrAmt = SUM(t.CrAmt), 
	TranCount = Count(t.BatNbr)
FROM WrkRelease w LEFT OUTER JOIN GLTran t ON w.BatNbr = t.BatNbr AND w.Module = t.Module
GROUP BY w.UserAddress, t.BatNbr, t.Module

 

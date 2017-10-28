 

CREATE VIEW vp_11400_Variance As
	SELECT T.Batnbr, T.KitId, T.InvtId, T.RefNbr, T.Cpnyid, T.Fiscyr, T.PerEnt, T.PerPost, T.JrnlType,
       		TranAmt = (T.Qty * T.UnitPrice), T.BMITranAmt, T.Extcost, T.BMIExtCost, T.OvrhdAmt
	FROM INTran T
	Where T.TranType = 'AS'
		AND T.KitId <> ''
		And T.Rlsed = 0
	GROUP BY T.Batnbr, T.KitId, T.InvtId, T.RefNbr, T.Cpnyid, T.Fiscyr, T.PerEnt, T.PerPost, T.JrnlType,
       		T.Qty, T.UnitPrice, T.BMITranAmt, T.Extcost, T.BMIExtCost, T.OvrhdAmt

 

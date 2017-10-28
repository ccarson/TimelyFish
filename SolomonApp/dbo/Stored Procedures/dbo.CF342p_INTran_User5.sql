
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE CF342p_INTran_User5
	@BatNbr varchar (10)
	AS 
	SELECT i.Acct, i.COGSAcct,i.CpnyId, i.DrCr,
		GroupCpnyID = IsNull(g.CpnyID,''),i.JrnlType,
		ProjCpnyID = p.CpnyId, i.Sub,   
		TranAmt = Sum(i.TranAmt)  
	FROM INTran i
	JOIN PJProj p on i.ProjectID = p.Project
	LEFT JOIN cftPigGroup g ON i.TaskID = g.TaskID	 
	WHERE i.User5 = @BatNbr
	GROUP BY i.CpnyID, i.JrnlType, i.Acct, i.COGSAcct, i.Sub, i.DrCr, p.CpnyID, g.CpnyID
	ORDER BY i.CpnyID, i.JrnlType, i.Acct, i.COGSAcct, i.Sub, i.DrCr, p.CpnyID, g.CpnyID

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF342p_INTran_User5] TO [MSDSL]
    AS [dbo];


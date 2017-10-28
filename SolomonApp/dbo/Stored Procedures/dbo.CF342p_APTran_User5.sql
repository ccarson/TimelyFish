
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE CF342p_APTran_User5
	@BatNbr varchar (10)
	AS 
	SELECT a.Acct, a.CpnyId, a.DrCr,
		GroupCpnyID = IsNull(g.CpnyID,''),
		ProjCpnyID = p.CpnyId, a.Sub,   
		TranAmt = Sum(a.TranAmt)  
	FROM APTran a
	JOIN PJProj p on a.ProjectID = p.Project
	LEFT JOIN cftPigGroup g ON a.TaskID = g.TaskID	 
	WHERE a.User5 = @BatNbr
	GROUP BY a.CpnyID, a.Acct, a.Sub, a.DrCr, p.CpnyID, g.CpnyID
	ORDER BY a.CpnyID, a.Acct, a.Sub, a.DrCr, p.CpnyID, g.CpnyID

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF342p_APTran_User5] TO [MSDSL]
    AS [dbo];


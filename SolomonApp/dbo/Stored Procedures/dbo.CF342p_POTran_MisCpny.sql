
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE CF342p_POTran_MisCpny 
	-- NOTE: This procedures where clause needs to be the same
	-- as CF342p_POTran_Update procedure
	@CpnyId varchar (10),
	@PerPost varchar(6) 
	AS 
	SELECT a.cpnyid, p.cpnyid, g.cpnyid  
	FROM POTran a
	JOIN PJProj p on a.ProjectID = p.Project
	JOIN POReceipt pr ON a.RcptNbr = pr.RcptNbr AND pr.Rlsed = 1
	LEFT JOIN cftPigGroup g ON a.TaskID = g.TaskID	 
	WHERE a.CpnyId = @CpnyId 
	AND a.User5 = '' 
	AND a.PerPost <= @PerPost
	AND ((a.CpnyID <> p.CpnyID AND g.CpnyID Is Null) 
	      Or
	     (a.CpnyID <> g.CpnyID and g.CpnyID IS NOT NULL))

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF342p_POTran_MisCpny] TO [MSDSL]
    AS [dbo];


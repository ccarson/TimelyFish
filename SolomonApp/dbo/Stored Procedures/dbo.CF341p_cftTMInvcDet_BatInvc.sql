CREATE PROCEDURE CF341p_cftTMInvcDet_BatInvc @parm1 varchar (10), @parm2 varchar (10) 
	as 
    	SELECT * FROM cftTMInvcDet 
	WHERE BatNbr = @parm1 
	AND RefNbr = @parm2
	ORDER BY BatNbr, RefNbr, OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_cftTMInvcDet_BatInvc] TO [MSDSL]
    AS [dbo];


CREATE PROCEDURE CF341p_cftTMInvcHdr_Ref @parm1 varchar (10), @parm2 varchar (10) 
	as 
	SELECT * FROM cftTMInvcHdr 
	WHERE BatNbr = @parm1 
	AND RefNbr Like @parm2
	ORDER BY BatNbr, RefNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_cftTMInvcHdr_Ref] TO [MSDSL]
    AS [dbo];


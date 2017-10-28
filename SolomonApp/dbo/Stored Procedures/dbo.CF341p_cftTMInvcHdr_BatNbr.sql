CREATE PROCEDURE CF341p_cftTMInvcHdr_BatNbr @parm1 varchar (10) 
	as 
    	SELECT * FROM cftTMInvcHdr 
	WHERE BatNbr = @parm1
	ORDER BY BatNbr, RefNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_cftTMInvcHdr_BatNbr] TO [MSDSL]
    AS [dbo];


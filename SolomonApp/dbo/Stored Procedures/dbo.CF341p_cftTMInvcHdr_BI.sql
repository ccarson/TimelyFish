CREATE PROCEDURE CF341p_cftTMInvcHdr_BI @parm1 varchar (10), @parm2 varchar (10) 
	as 
	SELECT * FROM cftTMInvcHdr 
	WHERE BatNbr = @parm1 
	AND InvcNbr Like @parm2
	ORDER BY BatNbr, InvcNbr

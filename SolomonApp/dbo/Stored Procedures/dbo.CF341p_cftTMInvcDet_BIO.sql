CREATE PROCEDURE CF341p_cftTMInvcDet_BIO @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (10) 
	as
    	SELECT * FROM cftTMInvcDet 
	WHERE BatNbr = @parm1 
	AND RefNbr = @parm2 
	AND OrdNbr Like @parm3
	ORDER BY BatNbr, RefNbr, OrdNbr

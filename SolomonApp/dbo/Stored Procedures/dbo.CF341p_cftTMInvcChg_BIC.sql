CREATE PROCEDURE CF341p_cftTMInvcChg_BIC @parm1 varchar (10), @parm2 varchar (10), @parm3 varchar (5) 
	as
	SELECT * FROM cftTMInvcChg 
	WHERE BatNbr = @parm1 
	AND RefNbr = @parm2 
	AND ChrgId Like @parm3
	ORDER BY BatNbr, RefNbr, ChrgId

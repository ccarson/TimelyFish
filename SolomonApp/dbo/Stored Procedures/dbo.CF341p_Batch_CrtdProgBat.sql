CREATE PROCEDURE CF341p_Batch_CrtdProgBat @parm1 varchar (8), @parm2 varchar (10) 
	as
	SELECT * FROM Batch 
	WHERE Crtd_Prog = @parm1 
	AND BatNbr like @parm2 
	ORDER BY BatNbr DESC

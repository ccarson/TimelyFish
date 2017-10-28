CREATE PROCEDURE CF341p_Batch_APBatNbr @parm1 varchar (10) 
	as 
	SELECT * FROM Batch 
	WHERE BatNbr = @parm1 
	AND Module = 'AP'

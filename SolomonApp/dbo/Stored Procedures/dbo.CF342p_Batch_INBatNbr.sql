CREATE PROCEDURE CF342p_Batch_INBatNbr @parm1 varchar (10) AS 
    SELECT * FROM Batch 
	WHERE BatNbr = @parm1 
	AND Module = 'IN'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF342p_Batch_INBatNbr] TO [MSDSL]
    AS [dbo];


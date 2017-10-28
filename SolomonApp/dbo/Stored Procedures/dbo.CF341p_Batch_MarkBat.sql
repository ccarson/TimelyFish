CREATE PROCEDURE CF341p_Batch_MarkBat @parm1 varchar (10), @parm2 varchar (1) 
	as 
    	Update Batch Set EditScrnNbr = '03010', Status = @parm2 
	WHERE BatNbr = @parm1 
	AND Module = 'AP'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF341p_Batch_MarkBat] TO [MSDSL]
    AS [dbo];


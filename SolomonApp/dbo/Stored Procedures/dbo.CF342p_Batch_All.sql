CREATE PROCEDURE CF342p_Batch_All 
	AS 
	SELECT * FROM Batch WHERE Module = 'XX' and Batnbr = ''

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF342p_Batch_All] TO [MSDSL]
    AS [dbo];


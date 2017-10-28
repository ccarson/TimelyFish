CREATE PROCEDURE CF342p_GLTran_All 
	AS 
	SELECT * FROM GLTran WHERE Module = 'XX' and Batnbr = ''

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF342p_GLTran_All] TO [MSDSL]
    AS [dbo];


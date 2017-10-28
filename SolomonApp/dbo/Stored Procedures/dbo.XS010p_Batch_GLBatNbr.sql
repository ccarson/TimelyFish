CREATE PROCEDURE XS010p_Batch_GLBatNbr 
	-- CREATED BY: TJones
	-- CREATED ON: 6/06/05
	@parm1 varchar (10) 
	AS 
    	SELECT * FROM Batch
	WHERE BatNbr = @parm1
	AND Module = 'GL'

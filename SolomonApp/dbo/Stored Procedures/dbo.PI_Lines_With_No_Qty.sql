 CREATE PROCEDURE PI_Lines_With_No_Qty
	@PIID VarChar(10),
	@StartRange Int,
	@EndRange Int

AS
 Select Count(*)
	From PIDetail
	WHERE Status = 'N' AND
		PIID = @PIID AND
		(Number < @StartRange OR
		Number > @EndRange)



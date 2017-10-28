CREATE FUNCTION dbo.ReturnHighValue (@Value1 As Int, @Value2 As Int, @Value3 As Int, @Value4 As Int)
	RETURNS INT
	AS
	BEGIN
	DECLARE @HighValue As INT
	SELECT @HighValue = @Value1
	IF @Value2 > @HighValue
		BEGIN 
		SELECT @HighValue = @Value2
		END
	IF @Value3 > @HighValue
		BEGIN
		SELECT @HighValue = @Value3
		END
	IF @Value4 > @HighValue
		BEGIN
		SELECT @HighValue = @Value4
		END
	RETURN @HighValue
 	END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ReturnHighValue] TO [PRD]
    AS [dbo];


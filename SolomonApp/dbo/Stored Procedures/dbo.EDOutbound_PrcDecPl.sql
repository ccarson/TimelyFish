 CREATE PROCEDURE EDOutbound_PrcDecPl @CurrencyID varchar(4)
AS
Declare @CurrencyDecPl  as smallint
Declare @CustomDecPl  as smallint

	SELECT @CurrencyDecPl = DecPl FROM Currncy (NOLOCK) where CuryId = @CurrencyID

	SELECT   @CustomDecPl =
	      CASE (SELECT S4Future09 FROM EDSetup (NOLOCK))
	         WHEN 1 THEN @CurrencyDecPl
	         ELSE (SELECT DecPlPrcCst FROM INSetup (NOLOCK))
	      END

	-- set return value = -1 if it is undefined
	SELECT @CurrencyDecPl = ISNULL(@CurrencyDecPl, -1)
	SELECT @CustomDecPl = ISNULL(@CustomDecPl, -1)

	Select @CurrencyDecPl, @CustomDecPl



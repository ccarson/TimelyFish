 create procedure DMG_CuryTransToBase
	@TransactionAmount	decimal(25,9),
	@CuryRate		decimal(25,9),
	@CuryMultDiv		varchar(1),
	@DecimalPlaces		smallint,
	@BaseAmount		decimal(25,9) OUTPUT
as
	if @CuryMultDiv = 'M'
		Set @BaseAmount = round(@TransactionAmount * @CuryRate, @DecimalPlaces)
	else begin
		if @CuryRate = 0
			Set @BaseAmount = 0
		else
			Set @BaseAmount = round(@TransactionAmount / @CuryRate, @DecimalPlaces)
	end
	--select @BaseAmount



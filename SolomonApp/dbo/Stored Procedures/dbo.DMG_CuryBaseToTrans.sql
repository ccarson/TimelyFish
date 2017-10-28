 create procedure DMG_CuryBaseToTrans
	@BaseAmount		decimal(25,9),
	@CuryRate		decimal(25,9),
	@CuryMultDiv		varchar(1),
	@DecimalPlaces		smallint,
	@TransactionAmount	decimal(25,9) OUTPUT
as
	-- Need to invert the meaning of the flag because we are going from base to transaction
	if @CuryMultDiv = 'M' begin
		if @CuryRate = 0
			Set @TransactionAmount = 0
		else
			Set @TransactionAmount = round(@BaseAmount / @CuryRate, @DecimalPlaces)
	end
	else
		Set @TransactionAmount = round(@BaseAmount * @CuryRate, @DecimalPlaces)

	--select @TransactionAmount



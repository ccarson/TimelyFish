 create proc DMG_Precision_GetPrec
	@DecPlPrcCst	smallint OUTPUT,
	@DecPlQty	smallint OUTPUT,
	@DecPlNonStdQty	smallint OUTPUT
as
	declare @INSetupCount smallint
	declare @SOSetupCount smallint

	--Set the factors to default values
	set @DecPlPrcCst = 9
	set @DecPlQty = 9
	set @DecPlNonStdQty = 9

	--Get the setup record counts
	select @INSetupCount = Count(*) from INSetup (NOLOCK)
	select @SOSetupCount = Count(*) from SOSetup (NOLOCK)

	if @INSetupCount = 0 and @SOSetupCount = 0
		return 0
		if @INSetupCount > 0 and @SOSetupCount > 0
		select	@DecPlPrcCst = i.DecPlPrcCst,
			@DecPlQty = i.DecPlQty,
			@DecPlNonStdQty = s.DecPlNonStdQty
		from	INSetup i (NOLOCK),
			SOSetup s (NOLOCK)

	if @INSetupCount > 0 and @SOSetupCount = 0
		select	@DecPlPrcCst = i.DecPlPrcCst,
			@DecPlQty = i.DecPlQty,
			@DecPlNonStdQty = Convert(smallint, 9)
		from	INSetup i (NOLOCK)

	if @INSetupCount = 0 and @SOSetupCount > 0
		select	@DecPlPrcCst = Convert(smallint, 9),
			@DecPlQty = Convert(smallint, 9),
			@DecPlNonStdQty = s.DecPlNonStdQty
		from	SOSetup s (NOLOCK)

	--select @DecPlPrcCst,@DecPlQty,@DecPlNonStdQty

	return 1



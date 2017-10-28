 create procedure DMG_INSetupSelected
	@CurrPerNbr	varchar(6) OUTPUT,
	@DecPlQty	smallint OUTPUT,
	@NegQty		smallint OUTPUT,
	@WhseLocValid	varchar(1) OUTPUT
as
	select	@CurrPerNbr = ltrim(rtrim(CurrPerNbr)),
		@DecPlQty = DecPlQty,
		@NegQty = NegQty,
		@WhseLocValid = ltrim(rtrim(WhseLocValid))
	from 	INSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @CurrPerNbr = ''
		set @DecPlQty = 0
		set @NegQty = 0
		set @WhseLocValid = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_INSetupSelected] TO [MSDSL]
    AS [dbo];


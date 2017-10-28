 create proc DMG_CreditInfo_TermsCOD
	@TermsID	varchar(15),
	@COD		smallint OUTPUT
as
	select	@COD = COD
	from	Terms (NOLOCK)
	where	TermsID = @TermsID

	if @@ROWCOUNT = 0 begin
		set @COD = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditInfo_TermsCOD] TO [MSDSL]
    AS [dbo];


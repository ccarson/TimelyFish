 create proc ADG_CreditInfo_TermsCOD
	@TermsID	varchar(15)
as
	select	COD
	from	Terms (nolock)
	where	TermsID = @TermsID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_CreditInfo_TermsCOD] TO [MSDSL]
    AS [dbo];


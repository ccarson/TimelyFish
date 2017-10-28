 create proc DMG_CreditInfo_Customer_Selected
	@CustID		varchar(15),
	@CreditRule	varchar(2) OUTPUT,
	@GracePer	smallint OUTPUT
as
	select	@CreditRule = ltrim(rtrim(CreditRule)),
		@GracePer = GracePer
	from	CustomerEDI (NOLOCK)
	where	CustID = @CustID

	if @@ROWCOUNT = 0 begin
		set @CreditRule = ''
		set @GracePer = 0
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditInfo_Customer_Selected] TO [MSDSL]
    AS [dbo];


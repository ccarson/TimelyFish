 create procedure DMG_CustContactSelected
	@CustID		varchar(15),
	@Type		varchar(2) OUTPUT,
	@ContactID	varchar(10),
	@Name		varchar(60) OUTPUT,
	@OrderLimit	decimal(25,9) OUTPUT,
	@POReqdAmt	decimal(25,9) OUTPUT
as
	select	@Name = ltrim(rtrim(Name)),
		@OrderLimit = OrderLimit,
		@POReqdAmt = POReqdAmt,
		@Type = ltrim(rtrim(Type))
	from	CustContact (NOLOCK)
	where	CustID = @CustID
	and	Type like @Type
	and	ContactID = @ContactID

	if @@ROWCOUNT = 0 begin
		set @Name = ''
		set @OrderLimit = 0
		set @POReqdAmt = 0
		set @Type = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CustContactSelected] TO [MSDSL]
    AS [dbo];


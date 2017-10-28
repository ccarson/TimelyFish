 create procedure DMG_PO_REQ_POSetupSelected
	@BillAddr1		varchar(60) OUTPUT,
	@BillAddr2		varchar(60) OUTPUT,
	@BillAttn		varchar(30) OUTPUT,
	@BillCity		varchar(30) OUTPUT,
	@BillCountry		varchar(3) OUTPUT,
	@BillEmail		varchar(80) OUTPUT,
	@BillFax		varchar(30) OUTPUT,
	@BillName		varchar(60) OUTPUT,
	@BillPhone		varchar(30) OUTPUT,
	@BillState		varchar(3) OUTPUT,
	@BillZip		varchar(10) OUTPUT
as
	select	@BillAddr1 = ltrim(rtrim(BillAddr1)),
		@BillAddr2 = ltrim(rtrim(BillAddr2)),
		@BillAttn = ltrim(rtrim(BillAttn)),
		@BillCity = ltrim(rtrim(BillCity)),
		@BillCountry = ltrim(rtrim(BillCountry)),
		@BillEmail = ltrim(rtrim(BillEmail)),
		@BillFax = ltrim(rtrim(BillFax)),
		@BillName = ltrim(rtrim(BillName)),
		@BillPhone = ltrim(rtrim(BillPhone)),
		@BillState = ltrim(rtrim(BillState)),
		@BillZip = ltrim(rtrim(BillZip))
	from	POSetup (NOLOCK)

	if @@ROWCOUNT = 0 begin
		set @BillAddr1 = ''
		set @BillAddr2 = ''
		set @BillAttn = ''
		set @BillCity = ''
		set @BillCountry = ''
		set @BillEmail = ''
		set @BillFax = ''
		set @BillName = ''
		set @BillPhone = ''
		set @BillState = ''
		set @BillZip = ''
		return 0	--Failure
	end
	else
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_REQ_POSetupSelected] TO [MSDSL]
    AS [dbo];


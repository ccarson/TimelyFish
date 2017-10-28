 create proc ADG_ARSetup_InvcNbr
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select
		convert(char(10), coalesce(reverse(substring(reverse(rtrim(LastRefNbr)), 1, nullif(patindex('%[^0-9]%',reverse(rtrim(LastRefNbr))),0) - 1)), LastRefNbr)),
		convert(char(15), ''),
		SetupID
	from ARSetup



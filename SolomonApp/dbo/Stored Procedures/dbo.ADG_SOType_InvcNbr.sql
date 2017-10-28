 create proc ADG_SOType_InvcNbr
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4)
as
	select
		LastInvcNbr,
		case when InvcNbrAR = 0 then InvcNbrPrefix else coalesce(reverse(substring(reverse(rtrim(LastRefNbr)), nullif(patindex('%[^0-9]%',reverse(rtrim(LastRefNbr))),0), 10)), '') end,
		case when InvcNbrAR = 0 then InvcNbrType else '&AR' end
	from	SOType
	cross 	join ARSetup
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOType_InvcNbr] TO [MSDSL]
    AS [dbo];


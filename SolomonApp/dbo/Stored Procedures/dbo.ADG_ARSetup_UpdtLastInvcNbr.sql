 create proc ADG_ARSetup_UpdtLastInvcNbr
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4),
	@LastInvcNbr	varchar(10),
	@LUpd_DateTime	smalldatetime,
	@LUpd_Prog	varchar(8),
	@LUpd_User	varchar(10)
as

	update	ARSetup
	set	LastRefNbr = reverse(stuff(reverse(rtrim(LastRefNbr)),1,len(rtrim(@LastInvcNbr)), reverse(rtrim(@LastInvcNbr)))),
		LUpd_DateTime = @LUpd_DateTime,
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_ARSetup_UpdtLastInvcNbr] TO [MSDSL]
    AS [dbo];


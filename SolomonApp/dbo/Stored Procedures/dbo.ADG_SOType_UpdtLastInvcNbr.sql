 create proc ADG_SOType_UpdtLastInvcNbr
	@CpnyID		varchar(10),
	@SOTypeID	varchar(4),
	@LastInvcNbr	varchar(10),
	@LUpd_DateTime	smalldatetime,
	@LUpd_Prog	varchar(8),
	@LUpd_User	varchar(10)
as

	update	SOType
	set	LastInvcNbr = @LastInvcNbr,
		LUpd_DateTime = @LUpd_DateTime,
		LUpd_Prog = @LUpd_Prog,
		LUpd_User = @LUpd_User
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOType_UpdtLastInvcNbr] TO [MSDSL]
    AS [dbo];


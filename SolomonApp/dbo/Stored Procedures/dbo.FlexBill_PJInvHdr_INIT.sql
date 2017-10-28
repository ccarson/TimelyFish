 create proc FlexBill_PJInvHdr_INIT
as
	select	*
	from	PJInvHdr
	where	draft_num = ''
	  and	1 = 2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FlexBill_PJInvHdr_INIT] TO [MSDSL]
    AS [dbo];


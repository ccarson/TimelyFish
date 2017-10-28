 create proc FlexBill_PJInvDet_INIT
as
	select	*
	from	PJInvDet
	where	source_trx_id = -1
	  and	1 = 2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FlexBill_PJInvDet_INIT] TO [MSDSL]
    AS [dbo];


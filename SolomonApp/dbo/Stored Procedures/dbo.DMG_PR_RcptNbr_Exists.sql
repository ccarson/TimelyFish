 create procedure DMG_PR_RcptNbr_Exists
	@RcptNbr	varchar(10)
as
	if (
	select	count(*)
	from 	POReceipt (NOLOCK)
        where 	RcptNbr = @RcptNbr
 	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



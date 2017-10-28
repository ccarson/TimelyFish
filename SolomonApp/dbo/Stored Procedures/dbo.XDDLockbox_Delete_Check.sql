
create procedure XDDLockbox_Delete_Check
	@BatNbr		varchar( 10 )
as

	-- If this returns anything but zero, then there are good A/R Batches
	SELECT	count(*)
	FROM	XDDBatchARLB LB (nolock) LEFT OUTER JOIN Batch B (nolock)
		ON LB.PmtApplicBatNbr = B.BatNbr and B.Module = 'AR' and B.EditScrnNbr = '08030'
	WHERE	LB.LBBatNbr = @BatNbr
		and B.Status <> 'V'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDLockbox_Delete_Check] TO [MSDSL]
    AS [dbo];


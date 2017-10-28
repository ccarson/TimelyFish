
CREATE PROCEDURE XDDBatchARLB_KeepDelete
	@KeepDelete	varchar(1),
	@BatNbr		varchar(10)
	
AS
	SELECT		*
	FROM		XDDBatch
	WHERE		Module = 'AR'
			and FileType = 'L'
			and KeepDelete LIKE @KeepDelete
			and BatNbr LIKE @BatNbr
	ORDER BY	BatNbr DESC		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatchARLB_KeepDelete] TO [MSDSL]
    AS [dbo];


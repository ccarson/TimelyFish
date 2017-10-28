
CREATE PROCEDURE XDDDepositor_Change_VendAcct
	@OldAcct	varchar(10),
	@NewAcct 	varchar(10)

AS

	Update	XDDDepositor
	SET	VendAcct = @NewAcct
	WHERE	VendAcct = @OldAcct

	Update	XDDTxnTypeDep
	SET	VendAcct = @NewAcct
	WHERE	VendAcct = @OldAcct

	Update	APDoc
	SET eConfirm = @NewAcct
	WHERE 	eConfirm = @OldAcct
	--	and eStatus <> ''
		and ((OpenDoc = 1 and DocClass = 'N')
		    or (DocClass = 'R'))

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Change_VendAcct] TO [MSDSL]
    AS [dbo];


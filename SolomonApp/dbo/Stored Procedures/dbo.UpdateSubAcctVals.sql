Create Proc UpdateSubAcctVals
	@OldSub varchar(24), @NewSub varchar(24)
	AS
	Update ARTran Set Sub = @NewSub
		WHERE Sub = @OldSub
	Update GLTran Set Sub = @NewSub
		WHERE Sub = @OldSub AND Posted <> 'P'
	Update INTran Set Sub = @NewSub
		WHERE Sub = @OldSub
	Update APTran Set Sub = @NewSub
		WHERE Sub = @OldSub
	Update POTran Set Sub = @NewSub
		WHERE Sub = @OldSub
	Update PJProj Set gl_subacct = @NewSub
		WHERE gl_subacct = @OldSub
	Update CATran Set Sub = @NewSub
		WHERE Sub = @OldSub

GO
GRANT CONTROL
    ON OBJECT::[dbo].[UpdateSubAcctVals] TO [MSDSL]
    AS [dbo];


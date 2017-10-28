
CREATE PROCEDURE XDDBank_Update_MCB_EBNbr
	@Acct		varchar( 10 ),
	@Sub		varchar( 24 ),
	@EBNbrPrefix	varchar( 2 ),
	@NextEBNbr	varchar( 10 ),
	@EBNbrLen	smallint
AS
	UPDATE		XDDBank
	SET		MCB_EBNbrLen = @EBNbrLen,
			MCB_EBNbrPrefix = @EBNbrPrefix,
			MCB_NextEBNbr = @NextEBNbr
	WHERE		Acct = @Acct
			and Sub = @Sub

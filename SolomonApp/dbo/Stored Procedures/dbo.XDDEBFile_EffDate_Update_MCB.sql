
CREATE PROCEDURE XDDEBFile_EffDate_Update_MCB
	@BatNbr		varchar( 10 ),
	@EffDate		smalldatetime,
	@Prog		varchar( 8 ),
	@User		varchar( 10 )

AS

	Declare	@CurrDate 	smalldatetime

	SELECT	@CurrDate = cast(convert(varchar(10), getdate(), 101) as smalldatetime)

	UPDATE	APDoc
	SET		DocDate = @EffDate,
			LUpd_Prog = @Prog,
			LUpd_User = @User,
			LUpd_DateTime = @CurrDate
	WHERE 	BatNbr = @BatNbr

	UPDATE	APTran
	SET		TranDate = @EffDate,
			LUpd_Prog = @Prog,
			LUpd_User = @User,
			LUpd_DateTime = @CurrDate
	WHERE 	BatNbr = @BatNbr

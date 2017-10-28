 create procedure SCM_10400_Upd_TrnsfrDoc_Status
	@BatNbr		varchar(10),
	@CpnyID		varchar(10) as

Update TrnsfrDoc
	Set 	Status = 'P'
	Where	BatNbr = @BatNbr
		And CpnyID = @CpnyID




Create	Procedure SCM_10400_Upd_AssyDoc
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10),
	@Descr		VarChar(30),
	@InBal		SmallInt,
	@KitCntr	Float,
	@KitID		VarChar(30),
	@LotSerCntr	SmallInt,
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@NoteID		Integer,
	@PerPost	VarChar(6),
	@RefNbr		VarChar(15),
	@Rlsed		SmallInt,
	@S4Future01	VarChar(30),
	@S4Future02	VarChar(30),
	@S4Future03	Float,
	@S4Future04	Float,
	@S4Future05	Float,
	@S4Future06	Float,
	@S4Future07	SmallDateTime,
	@S4Future08	SmallDateTime,
	@S4Future09	Integer,
	@S4Future10	Integer,
	@S4Future11	VarChar(10),
	@S4Future12	VarChar(10),
	@SiteID		VarChar(10),
	@SpecificCostID	VarChar(25),
	@TranDate	SmallDateTime,
	@User1		VarChar(30),
	@User2		VarChar(30),
	@User3		Float,
	@User4		Float,
	@User5		VarChar(10),
	@User6		VarChar(10),
	@User7		SmallDateTime,
	@User8		SmallDateTime,
	@WhseLoc	VarChar(10)
AS
	Update	AssyDoc
		Set	Descr = @Descr,
			InBal = @InBal,
			KitCntr = @KitCntr,
			LotSerCntr = @LotSerCntr,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User,
			NoteID = @NoteID,
			PerPost = @PerPost,
			Rlsed = @Rlsed,
			S4Future01 = @S4Future01,
			S4Future02 = @S4Future02,
			S4Future03 = @S4Future03,
			S4Future04 = @S4Future04,
			S4Future05 = @S4Future05,
			S4Future06 = @S4Future06,
			S4Future07 = @S4Future07,
			S4Future08 = @S4Future08,
			S4Future09 = @S4Future09,
			S4Future10 = @S4Future10,
			S4Future11 = @S4Future11,
			S4Future12 = @S4Future12,
			SiteID = @SiteID,
			SpecificCostID = @SpecificCostID,
			TranDate = @TranDate,
			User1 = @User1,
			User2 = @User2,
			User3 = @User3,
			User4 = @User4,
			User5 = @User5,
			User6 = @User6,
			User7 = @User7,
			User8 = @User8,
			WhseLoc = @WhseLoc
		Where	BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And KitID = @KitID
			And RefNbr = @RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_AssyDoc] TO [MSDSL]
    AS [dbo];


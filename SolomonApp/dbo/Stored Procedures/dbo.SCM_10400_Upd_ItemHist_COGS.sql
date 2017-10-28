 Create	Procedure SCM_10400_Upd_ItemHist_COGS
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@Period		SmallInt,
	@FiscYr		Char(4),
	@Cost		Float,
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl 	SmallInt,
	@DecPlPrcCst 	SmallInt,
	@DecPlQty 	SmallInt
As
	Set	NoCount On

	Declare	@PTDCOGS00 Float, @PTDCOGS01 Float, @PTDCOGS02 Float, @PTDCOGS03 Float, @PTDCOGS04 Float,
		@PTDCOGS05 Float, @PTDCOGS06 Float, @PTDCOGS07 Float, @PTDCOGS08 Float, @PTDCOGS09 Float,
		@PTDCOGS10 Float, @PTDCOGS11 Float, @PTDCOGS12 Float
		Select	@PTDCOGS00 = 0, @PTDCOGS01 = 0, @PTDCOGS02 = 0, @PTDCOGS03 = 0, @PTDCOGS04 = 0,
		@PTDCOGS05 = 0, @PTDCOGS06 = 0, @PTDCOGS07 = 0, @PTDCOGS08 = 0, @PTDCOGS09 = 0,
		@PTDCOGS10 = 0, @PTDCOGS11 = 0, @PTDCOGS12 = 0

	If	@Period = 1
	Begin
		Set	@PTDCOGS00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDCOGS01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDCOGS02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDCOGS03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDCOGS04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDCOGS05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDCOGS06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDCOGS07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDCOGS08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDCOGS09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDCOGS10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDCOGS11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDCOGS12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemHist
		Set	PTDCOGS00 = Round(PTDCOGS00 + @PTDCOGS00, @BaseDecPl),
			PTDCOGS01 = Round(PTDCOGS01 + @PTDCOGS01, @BaseDecPl),
			PTDCOGS02 = Round(PTDCOGS02 + @PTDCOGS02, @BaseDecPl),
			PTDCOGS03 = Round(PTDCOGS03 + @PTDCOGS03, @BaseDecPl),
			PTDCOGS04 = Round(PTDCOGS04 + @PTDCOGS04, @BaseDecPl),
			PTDCOGS05 = Round(PTDCOGS05 + @PTDCOGS05, @BaseDecPl),
			PTDCOGS06 = Round(PTDCOGS06 + @PTDCOGS06, @BaseDecPl),
			PTDCOGS07 = Round(PTDCOGS07 + @PTDCOGS07, @BaseDecPl),
			PTDCOGS08 = Round(PTDCOGS08 + @PTDCOGS08, @BaseDecPl),
			PTDCOGS09 = Round(PTDCOGS09 + @PTDCOGS09, @BaseDecPl),
			PTDCOGS10 = Round(PTDCOGS10 + @PTDCOGS10, @BaseDecPl),
			PTDCOGS11 = Round(PTDCOGS11 + @PTDCOGS11, @BaseDecPl),
			PTDCOGS12 = Round(PTDCOGS12 + @PTDCOGS12, @BaseDecPl),
			YTDCOGS = Round(YTDCOGS + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_ItemHist_COGS] TO [MSDSL]
    AS [dbo];


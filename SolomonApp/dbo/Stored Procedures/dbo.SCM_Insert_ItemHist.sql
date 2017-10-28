 Create	Procedure SCM_Insert_ItemHist
	@InvtID		VarChar(30),	/*  INTran.InvtID  */
	@SiteID		VarChar(10),	/*  INTran.SiteID  */
	@MinFiscYr	Integer,
	@INPerNbr	Char(6),	/*  INSetup.PerNbr  */
	@MaxFiscYr	Integer,
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt

As

	Set	NoCount On

	Declare	@INFiscYr	Integer
	Declare @NbrPer		Integer

	Select @NbrPer = 12
	Select @NbrPer = NbrPer From GLSetup (NOLOCK)

	Set	@INFiscYr = Cast(Left(@INPerNbr, 4) As Integer)

	If	@MaxFiscYr < @INFiscYr
	Begin
		If	Exists(Select	InvtID
					From	ItemSite (NoLock)
					Where	InvtID = @InvtID
						And SiteID = @SiteID
						And Round(QtyOnHand, @DecPlQty) <> 0)
		Begin
			Set	@MaxFiscYr = @INFiscYr
		End
	End

	While	(@MinFiscYr <= @MaxFiscYr)
	Begin
		If Not Exists(Select InvtID
					From	ItemHist (NoLock)
					Where	InvtID = @InvtID
						And SiteID = @SiteID
						And FiscYr = Cast(@MinFiscYr As Char(4)))
		Begin

			Insert 	Into ItemHist
					(Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr, InvtID,
					LUpd_DateTime, LUpd_Prog, LUpd_User, PerNbr, SiteID)
				Values
					(GetDate(), @LUpd_Prog, @LUpd_User, @MinFiscYr, @InvtID,
					GetDate(),  @LUpd_Prog, @LUpd_User,
					Case	When @MinFiscYr = @INFiscYr
						Then	@INPerNbr
						Else	Right('000000' + Ltrim(Str(@MinFiscYr * 100 + @NbrPer)), 6)
					End, @SiteID)
		End

		Set	@MinFiscYr = @MinFiscYr + 1
	End



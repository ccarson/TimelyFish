 Create	Procedure SCM_UpdateAutoPOPolicy
	@CpnyID		VarChar(10),
	@InvtID		VarChar(30),
	@AutoPOPolicy	Char(2),
	@AutoPODropShip	SmallInt,
	@PrimVendID	VarChar(15),
	@SecondVendID	VarChar(15),
	@LUpd_Prog	Varchar(8),
	@LUpd_User	Varchar(10),
	@DfltSiteOnly	SmallInt
As
	Declare	@DfltSiteID	VarChar(10)
	Set	@DfltSiteID = '%'

	If	@DfltSiteOnly = 1
	Begin
		Set	@DfltSiteID = ''
/*
	vp_DfltSiteBins finds the Defaults by CpnyID & InvtID.
*/
		Select	@DfltSiteID = DfltSiteID
			From	vp_DfltSiteBins (NoLock)
			Where	CpnyID = @CpnyID
				And InvtID = @InvtID
		If	@@RowCount = 0
		Begin
/*
	In the event that nothing was found by the above view, then get the value from the company level.
*/
			Select	@DfltSiteID = DfltSiteID
				From	INCpnyDfltSites (NoLock)
				Where	CpnyID = @CpnyID
		End
	End

	Update	ItemSite
		Set	AutoPOPolicy = @AutoPOPolicy,
			AutoPODropShip = @AutoPODropShip,
			PrimVendID = @PrimVendID,
			SecondVendID = @SecondVendID,
			LUpd_DateTime = Cast(Convert(VarChar(10), GetDate(), 101) As SmallDateTime),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
			Where	InvtID = @InvtID
				And CpnyID = @CpnyID
				And SiteID Like @DfltSiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_UpdateAutoPOPolicy] TO [MSDSL]
    AS [dbo];


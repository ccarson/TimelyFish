 Create	Procedure SCM_Insert_SlsPerHist
	@CpnyID		VarChar(10),	/*  INTran.CpnyID  */
	@InvcNbr	VarChar(15),	/*  INTran.RefNbr  */
	@LineRef	VarChar(5),	/*  INTran.ARLineRef */
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@FiscYr		Char(4),	/*  Left(INTran.PerPost, 4) */
	@INPerNbr	Char(6)		/*  INSetup.PerNbr  */
As
	Set	NoCount On
	Declare	@INFiscYr	Integer,
		@MaxFiscYr	Integer

	Set	@INFiscYr = Cast(Left(@INPerNbr, 4) As Integer)
	Set	@MaxFiscYr = Cast(@FiscYr As Integer)

	While	(@INFiscYr <= @MaxFiscYr)
	Begin

	INSERT SlsPerHist (Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr, LUpd_DateTime, LUpd_Prog, LUpd_User,
	       NoteID, PerNbr, PtdCOGS00, PtdCOGS01, PtdCOGS02, PtdCOGS03, PtdCOGS04, PtdCOGS05, PtdCOGS06,
	       PtdCOGS07, PtdCOGS08, PtdCOGS09, PtdCOGS10, PtdCOGS11, PtdCOGS12, PtdRcpt00, PtdRcpt01,
	       PtdRcpt02, PtdRcpt03, PtdRcpt04, PtdRcpt05, PtdRcpt06, PtdRcpt07, PtdRcpt08, PtdRcpt09,
	       PtdRcpt10, PtdRcpt11, PtdRcpt12, PtdSls00, PtdSls01, PtdSls02, PtdSls03, PtdSls04, PtdSls05,
	       PtdSls06, PtdSls07, PtdSls08, PtdSls09, PtdSls10, PtdSls11, PtdSls12, S4Future01, S4Future02,
	       S4Future03, S4Future04, S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
	       S4Future11, S4Future12, SlsperID, User1, User2, User3, User4, User5, User6, User7, User8,
	       YtdCOGS, YtdRcpt, YtdSls)

	SELECT DISTINCT GETDATE(), @LUpd_Prog, @LUpd_User, Cast(@INFiscYr As Char(4)), GETDATE(), @LUpd_Prog, @LUpd_User,
               0, @INPerNbr, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	       0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
	       SOShipLineSplit.SlsperId, '', '', 0, 0, '', '', '', '',  0, 0, 0

         FROM  SOShipHeader (NoLock) Inner Join INTran (NoLock)
               on SOShipHeader.InvcNbr = INTran.Refnbr inner join  SOShipLineSplit (NoLock)
               on SOShipLineSplit.ShipperID = INTran.ShipperID
	 Left Join SlsPerHist On SlsPerHist.SlsPerID = SOShipLineSplit.SlsPerID
	       And SlsPerHist.FiscYr = Cast(@INFiscYr As Char(4))
	Where  SOShipHeader.CpnyID = @CpnyID
	       And SOShipHeader.InvcNbr = @InvcNbr
	       And DataLength(RTrim(SOShipLineSplit.SlsPerID)) > 0
	       And SlsPerHist.SlsPerID Is Null
               and INTran.ARLineRef = @LineRef

	  Set	@INFiscYr = @INFiscYr + 1

	End



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_Insert_SlsPerHist] TO [MSDSL]
    AS [dbo];


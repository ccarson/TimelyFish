 Create Proc DMG_10400_UpdateItemHist
            @UserAddress VARCHAR (21),    -- Computer Name
            @ProgId VARCHAR (8),          -- Prog_Name
            @UserId VARCHAR (10)         -- User_Name
AS
	SET NOCOUNT ON
	-- Error Trapping
	DECLARE	@Err_BatNbr		Varchar(10),
		@Err_BatchType		Varchar(1),
		@Err_COGSBatchCreated	Smallint,
		@Err_ComputerName	Varchar(21),
		@Err_Crtd_DateTime	SmallDateTime,
		@Err_MsgNbr		SmallInt,
		@Err_MsgType		Char(1),
		@Err_ParmCnt		SmallInt,
		@Err_Parm00		Varchar(30),
		@Err_Parm01		Varchar(30),
		@Err_Parm02		Varchar(30),
		@Err_Parm03		Varchar(30),
		@Err_Parm04		Varchar(30),
		@Err_Parm05		Varchar(30),
		@Err_S4Future01		Varchar(30),
		@Err_S4Future02		Varchar(30),
		@Err_S4Future03		Float,
		@Err_S4Future04		Float,
		@Err_S4Future05		Float,
		@Err_S4Future06		Float,
		@Err_S4Future07		SmallDateTime,
		@Err_S4Future08		SmallDateTime,
		@Err_S4Future09		Integer,
		@Err_S4Future10		Integer,
		@Err_S4Future11		Varchar(10),
		@Err_S4Future12		Varchar(10),
		@Err_SQLErrorNbr	SmallInt

	Select	@Err_BatNbr		= '',
		@Err_BatchType		= '',
		@Err_COGSBatchCreated	= 0,
		@Err_ComputerName	= @UserAddress,
		@Err_Crtd_DateTime	= GetDate(),
		@Err_MsgNbr		= 0,
		@Err_MsgType		= '',
		@Err_ParmCnt		= 0,
		@Err_Parm00		= '',
		@Err_Parm01		= '',
		@Err_Parm02		= '',
		@Err_Parm03		= '',
		@Err_Parm04		= '',
		@Err_Parm05		= '',
		@Err_S4Future01		= 'DMG_10400_UpdateItemHist',
		@Err_S4Future02		= '',
		@Err_S4Future03		= 0,
		@Err_S4Future04		= 0,
		@Err_S4Future05		= 0,
		@Err_S4Future06		= 0,
		@Err_S4Future07		= GetDate(),
		@Err_S4Future08		= GetDate(),
		@Err_S4Future09		= 0,
		@Err_S4Future10		= 0,
		@Err_S4Future11		= '',
		@Err_S4Future12		= '',
		@Err_SQLErrorNbr	= 0

    DECLARE @DecPlPrcCst     	 Int
    DECLARE @FirstFiscYr     	 CHAR(4)
    DECLARE @FiscYr     	 CHAR(4)
    DECLARE @INSetup_FiscYr  	 CHAR(4)
    DECLARE @INTran_FirstFiscYr  CHAR(4)
    DECLARE @INTran_LastFiscYr	 CHAR(4)
    DECLARE @ItemHist_LastFiscYr CHAR(4)
    DECLARE @LastFiscYr      	 CHAR(4)
    DECLARE @PerNbr          	 CHAR(6)
    DECLARE @PrevFiscYr     	 CHAR(4)
    DECLARE @P_Error 		 VARCHAR(1)

    SELECT @P_Error         = ' '

    Select @DecPlPrcCst = DecPlPrcCst,
           @PerNbr = PerNbr,
           @INSetup_FiscYr = (SUBSTRING(PerNbr, 1, 4))
           From INSetup

    Select @INTran_FirstFiscYr = Min(FiscYr),
           @INTran_LastFiscYr = Max(FiscYr)
           From vp_10400_UpdateItemHist_INTran
           Where UserAddress = @UserAddress

    Select @FirstFiscYr = @InTran_FirstFiscYr
    Select @LastFiscYr = @InTran_LastFiscYr

    If @INSetup_FiscYr > @LastFiscYr
        Select @LastFiscYr = @INSetup_FiscYr

    If @INSetup_FiscYr < @FirstFiscYr
        Select @FirstFiscYr = @INSetup_FiscYr

    Select @FiscYr = @FirstFiscYr
    While @FiscYr <= @LastFiscYr
	Begin
   	    Select @PrevFiscYr = LTRIM(STR(CONVERT(INT,@FiscYr) - 1))
            INSERT ItemHist (BegBal, Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr, InvtId,
                             LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId, PerNbr,
                             PTDCOGS00, PTDCOGS01, PTDCOGS02, PTDCOGS03, PTDCOGS04, PTDCOGS05,
                             PTDCOGS06, PTDCOGS07, PTDCOGS08, PTDCOGS09, PTDCOGS10, PTDCOGS11,
                             PTDCOGS12,
                             PTDCostAdjd00, PTDCostAdjd01, PTDCostAdjd02, PTDCostAdjd03,
                             PTDCostAdjd04, PTDCostAdjd05, PTDCostAdjd06, PTDCostAdjd07,
                             PTDCostAdjd08, PTDCostAdjd09, PTDCostAdjd10, PTDCostAdjd11,
                             PTDCostAdjd12,
                             PTDCostIssd00, PTDCostIssd01, PTDCostIssd02, PTDCostIssd03,
                             PTDCostIssd04, PTDCostIssd05, PTDCostIssd06, PTDCostIssd07,
                 PTDCostIssd08, PTDCostIssd09, PTDCostIssd10, PTDCostIssd11,
                             PTDCostIssd12,
                             PTDCostRcvd00, PTDCostRcvd01, PTDCostRcvd02, PTDCostRcvd03,
                             PTDCostRcvd04, PTDCostRcvd05, PTDCostRcvd06, PTDCostRcvd07,
                             PTDCostRcvd08, PTDCostRcvd09, PTDCostRcvd10, PTDCostRcvd11,
                             PTDCostRcvd12,
                             PTDCostTrsfrIn00, PTDCostTrsfrIn01, PTDCostTrsfrIn02,
                             PTDCostTrsfrIn03, PTDCostTrsfrIn04, PTDCostTrsfrIn05,
                             PTDCostTrsfrIn06, PTDCostTrsfrIn07, PTDCostTrsfrIn08,
                             PTDCostTrsfrIn09, PTDCostTrsfrIn10, PTDCostTrsfrIn11,
                             PTDCostTrsfrIn12,
                             PTDCostTrsfrOut00, PTDCostTrsfrOut01, PTDCostTrsfrOut02,
                             PTDCostTrsfrOut03, PTDCostTrsfrOut04, PTDCostTrsfrOut05,
                             PTDCostTrsfrOut06, PTDCostTrsfrOut07, PTDCostTrsfrOut08,
                             PTDCostTrsfrOut09, PTDCostTrsfrOut10, PTDCostTrsfrOut11,
                             PTDCostTrsfrOut12,
                             PTDSls00, PTDSls01, PTDSls02, PTDSls03, PTDSls04,
                             PTDSls05, PTDSls06, PTDSls07, PTDSls08, PTDSls09,
                             PTDSls10, PTDSls11, PTDSls12,
                             S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
                             S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
                             S4Future11, S4Future12,
                             SiteId, User1, User2, User3, User4, User5, User6, User7, User8,
                             YTDCOGS, YTDCostAdjd, YTDCostIssd, YTDCostRcvd, YTDCostTrsfrIn,
                             YTDCostTrsfrOut, YTDSls)
                   SELECT DISTINCT
                          -- BegBal
                         CASE WHEN P.BegBal Is NULL Or I.ValMthd = 'U'
                                   THEN 0
                                   ELSE (P.BegBal
                                         - P.PTDCOGS00 - P.PTDCOGS01 - P.PTDCOGS02 - P.PTDCOGS03
                                         - P.PTDCOGS04 - P.PTDCOGS05 - P.PTDCOGS06 - P.PTDCOGS07
                                         - P.PTDCOGS08 - P.PTDCOGS09 - P.PTDCOGS10 - P.PTDCOGS11
                                         - P.PTDCOGS12
                                         + P.PTDCostAdjd00 + P.PTDCostAdjd01 + P.PTDCostAdjd02
                                         + P.PTDCostAdjd03 + P.PTDCostAdjd04 + P.PTDCostAdjd05
                                         + P.PTDCostAdjd06 + P.PTDCostAdjd07 + P.PTDCostAdjd08
                                         + P.PTDCostAdjd09 + P.PTDCostAdjd10 + P.PTDCostAdjd11
                                         + P.PTDCostAdjd12
                                         - P.PTDCostIssd00 - P.PTDCostIssd01 - P.PTDCostIssd02
                                         - P.PTDCostIssd03 - P.PTDCostIssd04 - P.PTDCostIssd05
                                         - P.PTDCostIssd06 - P.PTDCostIssd07 - P.PTDCostIssd08
                                         - P.PTDCostIssd09 - P.PTDCostIssd10 - P.PTDCostIssd11
                                         - P.PTDCostIssd12
                                         + P.PTDCostRcvd00 + P.PTDCostRcvd01 + P.PTDCostRcvd02
                                         + P.PTDCostRcvd03 + P.PTDCostRcvd04 + P.PTDCostRcvd05
                                         + P.PTDCostRcvd06 + P.PTDCostRcvd07 + P.PTDCostRcvd08
                                         + P.PTDCostRcvd09 + P.PTDCostRcvd10 + P.PTDCostRcvd11
                                         + P.PTDCostRcvd12
                                         + P.PTDCostTrsfrIn00 + P.PTDCostTrsfrIn01 + P.PTDCostTrsfrIn02
                + P.PTDCostTrsfrIn03 + P.PTDCostTrsfrIn04 + P.PTDCostTrsfrIn05
                                         + P.PTDCostTrsfrIn06 + P.PTDCostTrsfrIn07 + P.PTDCostTrsfrIn08
                                         + P.PTDCostTrsfrIn09 + P.PTDCostTrsfrIn10 + P.PTDCostTrsfrIn11
                                         + P.PTDCostTrsfrIn12
                                         - P.PTDCostTrsfrOut00 - P.PTDCostTrsfrOut01 - P.PTDCostTrsfrOut02
                                         - P.PTDCostTrsfrOut03 - P.PTDCostTrsfrOut04 - P.PTDCostTrsfrOut05
                                         - P.PTDCostTrsfrOut06 - P.PTDCostTrsfrOut07 - P.PTDCostTrsfrOut08
                                         - P.PTDCostTrsfrOut09 - P.PTDCostTrsfrOut10 - P.PTDCostTrsfrOut11
                                         - P.PTDCostTrsfrOut12)
                              END,
                         GetDate(), @ProgId, @UserId, @FiscYr, v.InvtId,
                         GetDate(), @ProgId, @UserId, 0, @PerNbr,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
                         v.SiteId, '', '', 0, 0, '', '', '', '',
                         0, 0, 0, 0, 0, 0, 0
                         FROM vp_10400_UpdateItemHist V LEFT OUTER JOIN ItemHist H
                                                        ON V.InvtId = H.InvtId
                                                        AND V.SiteId = H.SiteId
                                                        AND @FiscYr = H.FiscYr
                                                        LEFT OUTER JOIN ItemHist P
                                                        ON V.InvtId = P.InvtId
                                                        AND V.SiteId = P.SiteId
                                                        AND @PrevFiscYr = P.FiscYr
                                                        JOIN Inventory I
                                                        ON V.InvtId = I.InvtId
            	         WHERE V.UserAddress = @UserAddress
                           AND H.InvtId Is NULL

	    SELECT @Err_SQLErrorNbr = @@ERROR
	    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
            PRINT 'Create ItemHist Records Complete'

            INSERT Item2Hist (BegQty, Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr, InvtId,
       	                      LUpd_DateTime, LUpd_Prog, LUpd_User,
                              PTDQtyAdjd00, PTDQtyAdjd01, PTDQtyAdjd02, PTDQtyAdjd03,
                              PTDQtyAdjd04, PTDQtyAdjd05, PTDQtyAdjd06, PTDQtyAdjd07,
                              PTDQtyAdjd08, PTDQtyAdjd09, PTDQtyAdjd10, PTDQtyAdjd11,
                              PTDQtyAdjd12,
                              PTDQtyIssd00, PTDQtyIssd01, PTDQtyIssd02, PTDQtyIssd03,
                              PTDQtyIssd04, PTDQtyIssd05, PTDQtyIssd06, PTDQtyIssd07,
                              PTDQtyIssd08, PTDQtyIssd09, PTDQtyIssd10, PTDQtyIssd11,
                              PTDQtyIssd12,
                              PTDQtyRcvd00, PTDQtyRcvd01, PTDQtyRcvd02, PTDQtyRcvd03,
                              PTDQtyRcvd04, PTDQtyRcvd05, PTDQtyRcvd06, PTDQtyRcvd07,
                              PTDQtyRcvd08, PTDQtyRcvd09, PTDQtyRcvd10, PTDQtyRcvd11,
                              PTDQtyRcvd12,
                              PTDQtySls00, PTDQtySls01, PTDQtySls02, PTDQtySls03, PTDQtySls04,
                              PTDQtySls05, PTDQtySls06, PTDQtySls07, PTDQtySls08, PTDQtySls09,
                              PTDQtySls10, PTDQtySls11, PTDQtySls12,
                              PTDQtyTrsfrIn00, PTDQtyTrsfrIn01, PTDQtyTrsfrIn02, PTDQtyTrsfrIn03,
                              PTDQtyTrsfrIn04, PTDQtyTrsfrIn05, PTDQtyTrsfrIn06, PTDQtyTrsfrIn07,
                              PTDQtyTrsfrIn08, PTDQtyTrsfrIn09, PTDQtyTrsfrIn10, PTDQtyTrsfrIn11,
                              PTDQtyTrsfrIn12,
                              PTDQtyTrsfrOut00, PTDQtyTrsfrOut01, PTDQtyTrsfrOut02, PTDQtyTrsfrOut03,
                              PTDQtyTrsfrOut04, PTDQtyTrsfrOut05, PTDQtyTrsfrOut06, PTDQtyTrsfrOut07,
                              PTDQtyTrsfrOut08, PTDQtyTrsfrOut09, PTDQtyTrsfrOut10, PTDQtyTrsfrOut11,
                              PTDQtyTrsfrOut12,
                              S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                              S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                              SiteId, User1, User2, User3, User4, User5, User6, User7, User8,
                              YTDQtyAdjd, YTDQtyIssd, YTDQtyRcvd, YTDQtySls, YTDQtyTrsfrIn,
                              YTDQtyTrsfrOut)
                   SELECT DISTINCT
--                        BegQty
                         CASE WHEN P.BegQty Is NULL
                                   THEN 0
                                   ELSE (P.BegQty
                                         - P.PTDQtySls00 - P.PTDQtySls01 - P.PTDQtySls02
                                         - P.PTDQtySls03 - P.PTDQtySls04 - P.PTDQtySls05
                                         - P.PTDQtySls06 - P.PTDQtySls07 - P.PTDQtySls08
                                         - P.PTDQtySls09 - P.PTDQtySls10 - P.PTDQtySls11
                                         - P.PTDQtySls12
                                         + P.PTDQtyAdjd00 + P.PTDQtyAdjd01 + P.PTDQtyAdjd02
                                         + P.PTDQtyAdjd03 + P.PTDQtyAdjd04 + P.PTDQtyAdjd05
                                         + P.PTDQtyAdjd06 + P.PTDQtyAdjd07 + P.PTDQtyAdjd08
                                         + P.PTDQtyAdjd09 + P.PTDQtyAdjd10 + P.PTDQtyAdjd11
                                         + P.PTDQtyAdjd12
                                         - P.PTDQtyIssd00 - P.PTDQtyIssd01 - P.PTDQtyIssd02
                                         - P.PTDQtyIssd03 - P.PTDQtyIssd04 - P.PTDQtyIssd05
                                         - P.PTDQtyIssd06 - P.PTDQtyIssd07 - P.PTDQtyIssd08
                                         - P.PTDQtyIssd09 - P.PTDQtyIssd10 - P.PTDQtyIssd11
                                         - P.PTDQtyIssd12
                                         + P.PTDQtyRcvd00 + P.PTDQtyRcvd01 + P.PTDQtyRcvd02
                                         + P.PTDQtyRcvd03 + P.PTDQtyRcvd04 + P.PTDQtyRcvd05
                                         + P.PTDQtyRcvd06 + P.PTDQtyRcvd07 + P.PTDQtyRcvd08
                                         + P.PTDQtyRcvd09 + P.PTDQtyRcvd10 + P.PTDQtyRcvd11
                                         + P.PTDQtyRcvd12
                                         + P.PTDQtyTrsfrIn00 + P.PTDQtyTrsfrIn01 + P.PTDQtyTrsfrIn02
                                         + P.PTDQtyTrsfrIn03 + P.PTDQtyTrsfrIn04 + P.PTDQtyTrsfrIn05
                                         + P.PTDQtyTrsfrIn06 + P.PTDQtyTrsfrIn07 + P.PTDQtyTrsfrIn08
                                         + P.PTDQtyTrsfrIn09 + P.PTDQtyTrsfrIn10 + P.PTDQtyTrsfrIn11
                                         + P.PTDQtyTrsfrIn12
                                         - P.PTDQtyTrsfrOut00 - P.PTDQtyTrsfrOut01 - P.PTDQtyTrsfrOut02
                                         - P.PTDQtyTrsfrOut03 - P.PTDQtyTrsfrOut04 - P.PTDQtyTrsfrOut05
                                         - P.PTDQtyTrsfrOut06 - P.PTDQtyTrsfrOut07 - P.PTDQtyTrsfrOut08
      - P.PTDQtyTrsfrOut09 - P.PTDQtyTrsfrOut10 - P.PTDQtyTrsfrOut11
                                         - P.PTDQtyTrsfrOut12)
                              END,
                         GetDate(), @ProgId, @UserId, @FiscYr, v.InvtId,
                         GetDate(), @ProgId, @UserId,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
                         v.SiteId, '', '', 0, 0, '', '', '', '',
                         0, 0, 0, 0, 0, 0
                         FROM vp_10400_UpdateItemHist V LEFT OUTER JOIN Item2Hist H
                                                        ON V.InvtId = H.InvtId
                                                        AND V.SiteId = H.SiteId
                                                        AND @FiscYr = H.FiscYr
                                                        LEFT OUTER JOIN Item2Hist P
                                                        ON V.InvtId = P.InvtId
                                                        AND V.SiteId = P.SiteId
                                                        AND @PrevFiscYr = P.FiscYr
                          WHERE V.UserAddress = @UserAddress
                            AND H.InvtId Is NULL
 	    SELECT @Err_SQLErrorNbr = @@ERROR
	    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
            PRINT 'Create Item2Hist Records Complete'

            INSERT ItemBMIHist (BMIBegBal,
                                BMIPTDCOGS00, BMIPTDCOGS01, BMIPTDCOGS02, BMIPTDCOGS03,
                                BMIPTDCOGS04, BMIPTDCOGS05, BMIPTDCOGS06, BMIPTDCOGS07,
                                BMIPTDCOGS08, BMIPTDCOGS09, BMIPTDCOGS10, BMIPTDCOGS11,
                                BMIPTDCOGS12,
                                BMIPTDCostAdjd00, BMIPTDCostAdjd01, BMIPTDCostAdjd02,
                                BMIPTDCostAdjd03, BMIPTDCostAdjd04, BMIPTDCostAdjd05,
                                BMIPTDCostAdjd06, BMIPTDCostAdjd07, BMIPTDCostAdjd08,
                                BMIPTDCostAdjd09, BMIPTDCostAdjd10, BMIPTDCostAdjd11,
                                BMIPTDCostAdjd12,
                                BMIPTDCostIssd00, BMIPTDCostIssd01, BMIPTDCostIssd02,
                                BMIPTDCostIssd03, BMIPTDCostIssd04, BMIPTDCostIssd05,
                                BMIPTDCostIssd06, BMIPTDCostIssd07, BMIPTDCostIssd08,
                                BMIPTDCostIssd09, BMIPTDCostIssd10, BMIPTDCostIssd11,
                                BMIPTDCostIssd12,
                                BMIPTDCostRcvd00, BMIPTDCostRcvd01, BMIPTDCostRcvd02,
                                BMIPTDCostRcvd03, BMIPTDCostRcvd04, BMIPTDCostRcvd05,
                                BMIPTDCostRcvd06, BMIPTDCostRcvd07, BMIPTDCostRcvd08,
                                BMIPTDCostRcvd09, BMIPTDCostRcvd10, BMIPTDCostRcvd11,
                                BMIPTDCostRcvd12,
                                BMIYTDCOGS, BMIYTDCostAdjd, BMIYTDCostIssd, BMIYTDCostRcvd,
                                Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr, InvtId,
                                LUpd_DateTime, LUpd_Prog, LUpd_User,
                                S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                                S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                                SiteId, User1, User2, User3, User4, User5, User6, User7, User8)
                   SELECT DISTINCT
--                        BMIBegBal
                          CASE WHEN P.BMIBegBal Is NULL Or I.ValMthd = 'U'
                                   THEN 0
                                   ELSE (P.BMIBegBal
                                         - P.BMIPTDCOGS00 - P.BMIPTDCOGS01 - P.BMIPTDCOGS02 - P.BMIPTDCOGS03
                                         - P.BMIPTDCOGS04 - P.BMIPTDCOGS05 - P.BMIPTDCOGS06 - P.BMIPTDCOGS07
                                         - P.BMIPTDCOGS08 - P.BMIPTDCOGS09 - P.BMIPTDCOGS10 - P.BMIPTDCOGS11
                                         - P.BMIPTDCOGS12
                                         + P.BMIPTDCostAdjd00 + P.BMIPTDCostAdjd01 + P.BMIPTDCostAdjd02
                                         + P.BMIPTDCostAdjd03 + P.BMIPTDCostAdjd04 + P.BMIPTDCostAdjd05
                                         + P.BMIPTDCostAdjd06 + P.BMIPTDCostAdjd07 + P.BMIPTDCostAdjd08
                                         + P.BMIPTDCostAdjd09 + P.BMIPTDCostAdjd10 + P.BMIPTDCostAdjd11
                                         + P.BMIPTDCostAdjd12
                                         - P.BMIPTDCostIssd00 - P.BMIPTDCostIssd01 - P.BMIPTDCostIssd02
                                         - P.BMIPTDCostIssd03 - P.BMIPTDCostIssd04 - P.BMIPTDCostIssd05
                                         - P.BMIPTDCostIssd06 - P.BMIPTDCostIssd07 - P.BMIPTDCostIssd08
                                         - P.BMIPTDCostIssd09 - P.BMIPTDCostIssd10 - P.BMIPTDCostIssd11
                                         - P.BMIPTDCostIssd12
                                         + P.BMIPTDCostRcvd00 + P.BMIPTDCostRcvd01 + P.BMIPTDCostRcvd02
                                         + P.BMIPTDCostRcvd03 + P.BMIPTDCostRcvd04 + P.BMIPTDCostRcvd05
                                         + P.BMIPTDCostRcvd06 + P.BMIPTDCostRcvd07 + P.BMIPTDCostRcvd08
                                         + P.BMIPTDCostRcvd09 + P.BMIPTDCostRcvd10 + P.BMIPTDCostRcvd11
                                         + P.BMIPTDCostRcvd12)
                              END,
                          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0,
                          GetDate(), @ProgId, @UserId, @FiscYr, v.InvtId,
                          GetDate(), @ProgId, @UserId,
                          '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
                          v.SiteId, '', '', 0, 0, '', '', '', ''
                          FROM vp_10400_BMIUpdateItemHist V LEFT OUTER JOIN ItemBMIHist H
                                                              ON V.InvtId = H.InvtId
                                                              AND V.SiteId = H.SiteId
                                                              AND @FiscYr = H.FiscYr
                                                            LEFT OUTER JOIN ItemBMIHist P
                                                              ON V.InvtId = P.InvtId
                                                              AND V.SiteId = P.SiteId
                                                              AND @PrevFiscYr = P.FiscYr
                                                            JOIN Inventory I
                                                            ON V.InvtId = I.InvtId

                          WHERE V.UserAddress = @UserAddress
                            AND H.InvtId Is NULL

	    SELECT @Err_SQLErrorNbr = @@ERROR
	    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
            PRINT 'Create ItemBMIHist Records Complete'

            Select @FiscYr = LTRIM(STR(CONVERT(INT,@FiscYr) + 1))

    END

    /***** Update ItemHist *****/
    UPDATE H
           SET LUpd_DateTime = GetDate(),
               LUpd_Prog = @ProgId,
               LUpd_User = @UserId,
               PTDCOGS00 = h.PTDCOGS00 + v.PTDCOGS00,
               PTDCOGS01 = h.PTDCOGS01 + v.PTDCOGS01,
               PTDCOGS02 = h.PTDCOGS02 + v.PTDCOGS02,
               PTDCOGS03 = h.PTDCOGS03 + v.PTDCOGS03,
               PTDCOGS04 = h.PTDCOGS04 + v.PTDCOGS04,
     	       PTDCOGS05 = h.PTDCOGS05 + v.PTDCOGS05,
     	       PTDCOGS06 = h.PTDCOGS06 + v.PTDCOGS06,
     	       PTDCOGS07 = h.PTDCOGS07 + v.PTDCOGS07,
     	       PTDCOGS08 = h.PTDCOGS08 + v.PTDCOGS08,
     	       PTDCOGS09 = h.PTDCOGS09 + v.PTDCOGS09,
     	       PTDCOGS10 = h.PTDCOGS10 + v.PTDCOGS10,
     	       PTDCOGS11 = h.PTDCOGS11 + v.PTDCOGS11,
     	       PTDCOGS12 = h.PTDCOGS12 + v.PTDCOGS12,
     	       PTDCostAdjd00 = h.PTDCostAdjd00 + v.PTDCostAdjd00,
     	       PTDCostAdjd01 = h.PTDCostAdjd01 + v.PTDCostAdjd01,
     	       PTDCostAdjd02 = h.PTDCostAdjd02 + v.PTDCostAdjd02,
       	       PTDCostAdjd03 = h.PTDCostAdjd03 + v.PTDCostAdjd03,
     	       PTDCostAdjd04 = h.PTDCostAdjd04 + v.PTDCostAdjd04,
     	       PTDCostAdjd05 = h.PTDCostAdjd05 + v.PTDCostAdjd05,
     	       PTDCostAdjd06 = h.PTDCostAdjd06 + v.PTDCostAdjd06,
     	       PTDCostAdjd07 = h.PTDCostAdjd07 + v.PTDCostAdjd07,
     	       PTDCostAdjd08 = h.PTDCostAdjd08 + v.PTDCostAdjd08,
     	       PTDCostAdjd09 = h.PTDCostAdjd09 + v.PTDCostAdjd09,
     	       PTDCostAdjd10 = h.PTDCostAdjd10 + v.PTDCostAdjd10,
     	       PTDCostAdjd11 = h.PTDCostAdjd11 + v.PTDCostAdjd11,
     	       PTDCostAdjd12 = h.PTDCostAdjd12 + v.PTDCostAdjd12,
     	       PTDCostIssd00 = h.PTDCostIssd00 + v.PTDCostIssd00,
      	       PTDCostIssd01 = h.PTDCostIssd01 + v.PTDCostIssd01,
     	       PTDCostIssd02 = h.PTDCostIssd02 + v.PTDCostIssd02,
     	       PTDCostIssd03 = h.PTDCostIssd03 + v.PTDCostIssd03,
     	       PTDCostIssd04 = h.PTDCostIssd04 + v.PTDCostIssd04,
     	       PTDCostIssd05 = h.PTDCostIssd05 + v.PTDCostIssd05,
     	       PTDCostIssd06 = h.PTDCostIssd06 + v.PTDCostIssd06,
     	       PTDCostIssd07 = h.PTDCostIssd07 + v.PTDCostIssd07,
     	       PTDCostIssd08 = h.PTDCostIssd08 + v.PTDCostIssd08,
     	       PTDCostIssd09 = h.PTDCostIssd09 + v.PTDCostIssd09,
     	       PTDCostIssd10 = h.PTDCostIssd10 + v.PTDCostIssd10,
     	       PTDCostIssd11 = h.PTDCostIssd11 + v.PTDCostIssd11,
     	       PTDCostIssd12 = h.PTDCostIssd12 + v.PTDCostIssd12,
     	       PTDCostRcvd00 = h.PTDCostRcvd00 + v.PTDCostRcvd00,
     	       PTDCostRcvd01 = h.PTDCostRcvd01 + v.PTDCostRcvd01,
     	       PTDCostRcvd02 = h.PTDCostRcvd02 + v.PTDCostRcvd02,
     	       PTDCostRcvd03 = h.PTDCostRcvd03 + v.PTDCostRcvd03,
     	       PTDCostRcvd04 = h.PTDCostRcvd04 + v.PTDCostRcvd04,
     	       PTDCostRcvd05 = h.PTDCostRcvd05 + v.PTDCostRcvd05,
     	       PTDCostRcvd06 = h.PTDCostRcvd06 + v.PTDCostRcvd06,
     	       PTDCostRcvd07 = h.PTDCostRcvd07 + v.PTDCostRcvd07,
     	       PTDCostRcvd08 = h.PTDCostRcvd08 + v.PTDCostRcvd08,
     	       PTDCostRcvd09 = h.PTDCostRcvd09 + v.PTDCostRcvd09,
     	       PTDCostRcvd10 = h.PTDCostRcvd10 + v.PTDCostRcvd10,
     	       PTDCostRcvd11 = h.PTDCostRcvd11 + v.PTDCostRcvd11,
     	       PTDCostRcvd12 = h.PTDCostRcvd12 + v.PTDCostRcvd12,
     	       PTDCostTrsfrIn00 = h.PTDCostTrsfrIn00 + v.PTDCostTrsfrIn00,
     	       PTDCostTrsfrIn01 = h.PTDCostTrsfrIn01 + v.PTDCostTrsfrIn01,
     	       PTDCostTrsfrIn02 = h.PTDCostTrsfrIn02 + v.PTDCostTrsfrIn02,
     	       PTDCostTrsfrIn03 = h.PTDCostTrsfrIn03 + v.PTDCostTrsfrIn03,
     	       PTDCostTrsfrIn04 = h.PTDCostTrsfrIn04 + v.PTDCostTrsfrIn04,
     	       PTDCostTrsfrIn05 = h.PTDCostTrsfrIn05 + v.PTDCostTrsfrIn05,
     	       PTDCostTrsfrIn06 = h.PTDCostTrsfrIn06 + v.PTDCostTrsfrIn06,
     	       PTDCostTrsfrIn07 = h.PTDCostTrsfrIn07 + v.PTDCostTrsfrIn07,
     	       PTDCostTrsfrIn08 = h.PTDCostTrsfrIn08 + v.PTDCostTrsfrIn08,
     	       PTDCostTrsfrIn09 = h.PTDCostTrsfrIn09 + v.PTDCostTrsfrIn09,
     	       PTDCostTrsfrIn10 = h.PTDCostTrsfrIn10 + v.PTDCostTrsfrIn10,
     	       PTDCostTrsfrIn11 = h.PTDCostTrsfrIn11 + v.PTDCostTrsfrIn11,
     	       PTDCostTrsfrIn12 = h.PTDCostTrsfrIn12 + v.PTDCostTrsfrIn12,
     	       PTDCostTrsfrOut00 = h.PTDCostTrsfrOut00 + v.PTDCostTrsfrOut00,
     	       PTDCostTrsfrOut01 = h.PTDCostTrsfrOut01 + v.PTDCostTrsfrOut01,
     	       PTDCostTrsfrOut02 = h.PTDCostTrsfrOut02 + v.PTDCostTrsfrOut02,
     	       PTDCostTrsfrOut03 = h.PTDCostTrsfrOut03 + v.PTDCostTrsfrOut03,
     	       PTDCostTrsfrOut04 = h.PTDCostTrsfrOut04 + v.PTDCostTrsfrOut04,
     	       PTDCostTrsfrOut05 = h.PTDCostTrsfrOut05 + v.PTDCostTrsfrOut05,
     	       PTDCostTrsfrOut06 = h.PTDCostTrsfrOut06 + v.PTDCostTrsfrOut06,
     	       PTDCostTrsfrOut07 = h.PTDCostTrsfrOut07 + v.PTDCostTrsfrOut07,
     	       PTDCostTrsfrOut08 = h.PTDCostTrsfrOut08 + v.PTDCostTrsfrOut08,
     	       PTDCostTrsfrOut09 = h.PTDCostTrsfrOut09 + v.PTDCostTrsfrOut09,
     	       PTDCostTrsfrOut10 = h.PTDCostTrsfrOut10 + v.PTDCostTrsfrOut10,
     	       PTDCostTrsfrOut11 = h.PTDCostTrsfrOut11 + v.PTDCostTrsfrOut11,
     	       PTDSls00 = h.PTDSls00 + v.PTDSls00,
     	       PTDSls01 = h.PTDSls01 + v.PTDSls01,
     	       PTDSls02 = h.PTDSls02 + v.PTDSls02,
     	       PTDSls03 = h.PTDSls03 + v.PTDSls03,
     	       PTDSls04 = h.PTDSls04 + v.PTDSls04,
     	       PTDSls05 = h.PTDSls05 + v.PTDSls05,
     	       PTDSls06 = h.PTDSls06 + v.PTDSls06,
     	       PTDSls07 = h.PTDSls07 + v.PTDSls07,
     	       PTDSls08 = h.PTDSls08 + v.PTDSls08,
     	       PTDSls09 = h.PTDSls09 + v.PTDSls09,
     	       PTDSls10 = h.PTDSls10 + v.PTDSls10,
     	       PTDSls11 = h.PTDSls11 + v.PTDSls11,
     	       PTDSls12 = h.PTDSls12 + v.PTDSls12,
               YTDCOGS = h.YTDCOGS + v.YTDCOGS,
     	       YTDCostAdjd = h.YTDCostAdjd + v.YTDCostAdjd,
     	       YTDCostIssd = h.YTDCostIssd + v.YTDCostIssd,
     	       YTDCostRcvd = h.YTDCostRcvd + v.YTDCostRcvd,
     	       YTDCostTrsfrIn = h.YTDCostTrsfrIn + v.YTDCostTrsfrIn,
               YTDCostTrsfrOut = h.YTDCostTrsfrOut + v.YTDCostTrsfrOut,
     	       YTDSls = h.YTDSls + v.YTDSls
           FROM ItemHist H, vp_10400_UpdateItemHist V
           WHERE V.UserAddress = @UserAddress
             AND H.InvtId = V.InvtId
             AND H.SiteId = V.SiteId
             AND H.FiscYr = V.FiscYr

    SELECT @Err_SQLErrorNbr = @@ERROR
    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
    PRINT 'Update ItemHist Cost Complete'

    UPDATE H
           SET LUpd_DateTime = GetDate(),
               LUpd_Prog = @ProgId,
               LUpd_User = @UserId,
     	       PTDQtyAdjd00 = h.PTDQtyAdjd00 + v.PTDQtyAdjd00,
     	       PTDQtyAdjd01 = h.PTDQtyAdjd01 + v.PTDQtyAdjd01,
     	       PTDQtyAdjd02 = h.PTDQtyAdjd02 + v.PTDQtyAdjd02,
     	       PTDQtyAdjd03 = h.PTDQtyAdjd03 + v.PTDQtyAdjd03,
     	       PTDQtyAdjd04 = h.PTDQtyAdjd04 + v.PTDQtyAdjd04,
     	       PTDQtyAdjd05 = h.PTDQtyAdjd05 + v.PTDQtyAdjd05,
     	       PTDQtyAdjd06 = h.PTDQtyAdjd06 + v.PTDQtyAdjd06,
     	       PTDQtyAdjd07 = h.PTDQtyAdjd07 + v.PTDQtyAdjd07,
     	       PTDQtyAdjd08 = h.PTDQtyAdjd08 + v.PTDQtyAdjd08,
     	       PTDQtyAdjd09 = h.PTDQtyAdjd09 + v.PTDQtyAdjd09,
     	       PTDQtyAdjd10 = h.PTDQtyAdjd10 + v.PTDQtyAdjd10,
     	       PTDQtyAdjd11 = h.PTDQtyAdjd11 + v.PTDQtyAdjd11,
     	       PTDQtyAdjd12 = h.PTDQtyAdjd12 + v.PTDQtyAdjd12,
     	       PTDQtyIssd00 = h.PTDQtyIssd00 + v.PTDQtyIssd00,
     	       PTDQtyIssd01 = h.PTDQtyIssd01 + v.PTDQtyIssd01,
     	       PTDQtyIssd02 = h.PTDQtyIssd02 + v.PTDQtyIssd02,
     	       PTDQtyIssd03 = h.PTDQtyIssd03 + v.PTDQtyIssd03,
     	       PTDQtyIssd04 = h.PTDQtyIssd04 + v.PTDQtyIssd04,
     	       PTDQtyIssd05 = h.PTDQtyIssd05 + v.PTDQtyIssd05,
     	       PTDQtyIssd06 = h.PTDQtyIssd06 + v.PTDQtyIssd06,
     	       PTDQtyIssd07 = h.PTDQtyIssd07 + v.PTDQtyIssd07,
     	       PTDQtyIssd08 = h.PTDQtyIssd08 + v.PTDQtyIssd08,
     	       PTDQtyIssd09 = h.PTDQtyIssd09 + v.PTDQtyIssd09,
     	       PTDQtyIssd10 = h.PTDQtyIssd10 + v.PTDQtyIssd10,
     	       PTDQtyIssd11 = h.PTDQtyIssd11 + v.PTDQtyIssd11,
     	       PTDQtyIssd12 = h.PTDQtyIssd12 + v.PTDQtyIssd12,
	       PTDQtyRcvd00 = h.PTDQtyRcvd00 + v.PTDQtyRcvd00,
	       PTDQtyRcvd01 = h.PTDQtyRcvd01 + v.PTDQtyRcvd01,
	       PTDQtyRcvd02 = h.PTDQtyRcvd02 + v.PTDQtyRcvd02,
	       PTDQtyRcvd03 = h.PTDQtyRcvd03 + v.PTDQtyRcvd03,
	       PTDQtyRcvd04 = h.PTDQtyRcvd04 + v.PTDQtyRcvd04,
	       PTDQtyRcvd05 = h.PTDQtyRcvd05 + v.PTDQtyRcvd05,
	       PTDQtyRcvd06 = h.PTDQtyRcvd06 + v.PTDQtyRcvd06,
	       PTDQtyRcvd07 = h.PTDQtyRcvd07 + v.PTDQtyRcvd07,
	       PTDQtyRcvd08 = h.PTDQtyRcvd08 + v.PTDQtyRcvd08,
	       PTDQtyRcvd09 = h.PTDQtyRcvd09 + v.PTDQtyRcvd09,
	       PTDQtyRcvd10 = h.PTDQtyRcvd10 + v.PTDQtyRcvd10,
	       PTDQtyRcvd11 = h.PTDQtyRcvd11 + v.PTDQtyRcvd11,
	       PTDQtyRcvd12 = h.PTDQtyRcvd12 + v.PTDQtyRcvd12,
     	       PTDQtySls00 = h.PTDQtySls00 + v.PTDQtySls00,
     	       PTDQtySls01 = h.PTDQtySls01 + v.PTDQtySls01,
     	       PTDQtySls02 = h.PTDQtySls02 + v.PTDQtySls02,
     	       PTDQtySls03 = h.PTDQtySls03 + v.PTDQtySls03,
     	       PTDQtySls04 = h.PTDQtySls04 + v.PTDQtySls04,
     	       PTDQtySls05 = h.PTDQtySls05 + v.PTDQtySls05,
     	       PTDQtySls06 = h.PTDQtySls06 + v.PTDQtySls06,
     	       PTDQtySls07 = h.PTDQtySls07 + v.PTDQtySls07,
     	       PTDQtySls08 = h.PTDQtySls08 + v.PTDQtySls08,
     	       PTDQtySls09 = h.PTDQtySls09 + v.PTDQtySls09,
     	       PTDQtySls10 = h.PTDQtySls10 + v.PTDQtySls10,
     	       PTDQtySls11 = h.PTDQtySls11 + v.PTDQtySls11,
     	       PTDQtySls12 = h.PTDQtySls12 + v.PTDQtySls12,
     	       PTDQtyTrsfrIn00 = h.PTDQtyTrsfrIn00 + v.PTDQtyTrsfrIn00,
     	       PTDQtyTrsfrIn01 = h.PTDQtyTrsfrIn01 + v.PTDQtyTrsfrIn01,
     	       PTDQtyTrsfrIn02 = h.PTDQtyTrsfrIn02 + v.PTDQtyTrsfrIn02,
     	       PTDQtyTrsfrIn03 = h.PTDQtyTrsfrIn03 + v.PTDQtyTrsfrIn03,
     	       PTDQtyTrsfrIn04 = h.PTDQtyTrsfrIn04 + v.PTDQtyTrsfrIn04,
     	       PTDQtyTrsfrIn05 = h.PTDQtyTrsfrIn05 + v.PTDQtyTrsfrIn05,
     	       PTDQtyTrsfrIn06 = h.PTDQtyTrsfrIn06 + v.PTDQtyTrsfrIn06,
     	       PTDQtyTrsfrIn07 = h.PTDQtyTrsfrIn07 + v.PTDQtyTrsfrIn07,
     	       PTDQtyTrsfrIn08 = h.PTDQtyTrsfrIn08 + v.PTDQtyTrsfrIn08,
     	       PTDQtyTrsfrIn09 = h.PTDQtyTrsfrIn09 + v.PTDQtyTrsfrIn09,
     	       PTDQtyTrsfrIn10 = h.PTDQtyTrsfrIn10 + v.PTDQtyTrsfrIn10,
     	       PTDQtyTrsfrIn11 = h.PTDQtyTrsfrIn11 + v.PTDQtyTrsfrIn11,
     	       PTDQtyTrsfrIn12 = h.PTDQtyTrsfrIn12 + v.PTDQtyTrsfrIn12,
     	       PTDQtyTrsfrOut00 = h.PTDQtyTrsfrOut00 + v.PTDQtyTrsfrOut00,
     	       PTDQtyTrsfrOut01 = h.PTDQtyTrsfrOut01 + v.PTDQtyTrsfrOut01,
     	       PTDQtyTrsfrOut02 = h.PTDQtyTrsfrOut02 + v.PTDQtyTrsfrOut02,
     	       PTDQtyTrsfrOut03 = h.PTDQtyTrsfrOut03 + v.PTDQtyTrsfrOut03,
     	       PTDQtyTrsfrOut04 = h.PTDQtyTrsfrOut04 + v.PTDQtyTrsfrOut04,
     	       PTDQtyTrsfrOut05 = h.PTDQtyTrsfrOut05 + v.PTDQtyTrsfrOut05,
     	       PTDQtyTrsfrOut06 = h.PTDQtyTrsfrOut06 + v.PTDQtyTrsfrOut06,
     	       PTDQtyTrsfrOut07 = h.PTDQtyTrsfrOut07 + v.PTDQtyTrsfrOut07,
     	       PTDQtyTrsfrOut08 = h.PTDQtyTrsfrOut08 + v.PTDQtyTrsfrOut08,
     	       PTDQtyTrsfrOut09 = h.PTDQtyTrsfrOut09 + v.PTDQtyTrsfrOut09,
     	       PTDQtyTrsfrOut10 = h.PTDQtyTrsfrOut10 + v.PTDQtyTrsfrOut10,
     	       PTDQtyTrsfrOut11 = h.PTDQtyTrsfrOut11 + v.PTDQtyTrsfrOut11,
     	       PTDQtyTrsfrOut12 = h.PTDQtyTrsfrOut12 + v.PTDQtyTrsfrOut12,
     	       YTDQtyAdjd = h.YTDQtyAdjd + v.YTDQtyAdjd,
     	       YTDQtyIssd = h.YTDQtyIssd + v.YTDQtyIssd,
	       YTDQtyRcvd = h.YTDQtyRcvd + v.YTDQtyRcvd,
     	       YTDQtySls = h.YTDQtySls + v.YTDQtySls,
     	       YTDQtyTrsfrIn = h.YTDQtyTrsfrIn + v.YTDQtyTrsfrIn,
     	       YTDQtyTrsfrOut = h.YTDQtyTrsfrOut + v.YTDQtyTrsfrOut
           FROM Item2Hist H, vp_10400_UpdateItemHist V
           WHERE V.UserAddress = @UserAddress
             AND H.InvtId = V.InvtId
             AND H.SiteId = V.SiteId
             AND H.FiscYr = V.FiscYr

    SELECT @Err_SQLErrorNbr = @@ERROR
    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
    PRINT 'Update Item2Hist Quantity Complete'

    /***** Update ItemBMIHist *****/
    UPDATE H
           SET LUpd_DateTime = GetDate(),
               LUpd_Prog = @ProgId,
               LUpd_User = @UserId,
               BMIPTDCOGS00 = h.BMIPTDCOGS00 + v.BMIPTDCOGS00,
               BMIPTDCOGS01 = h.BMIPTDCOGS01 + v.BMIPTDCOGS01,
               BMIPTDCOGS02 = h.BMIPTDCOGS02 + v.BMIPTDCOGS02,
     	       BMIPTDCOGS03 = h.BMIPTDCOGS03 + v.BMIPTDCOGS03,
     	       BMIPTDCOGS04 = h.BMIPTDCOGS04 + v.BMIPTDCOGS04,
     	       BMIPTDCOGS05 = h.BMIPTDCOGS05 + v.BMIPTDCOGS05,
     	       BMIPTDCOGS06 = h.BMIPTDCOGS06 + v.BMIPTDCOGS06,
     	       BMIPTDCOGS07 = h.BMIPTDCOGS07 + v.BMIPTDCOGS07,
     	       BMIPTDCOGS08 = h.BMIPTDCOGS08 + v.BMIPTDCOGS08,
     	       BMIPTDCOGS09 = h.BMIPTDCOGS09 + v.BMIPTDCOGS09,
     	       BMIPTDCOGS10 = h.BMIPTDCOGS10 + v.BMIPTDCOGS10,
     	       BMIPTDCOGS11 = h.BMIPTDCOGS11 + v.BMIPTDCOGS11,
     	       BMIPTDCOGS12 = h.BMIPTDCOGS12 + v.BMIPTDCOGS12,
     	       BMIPTDCostAdjd00 = h.BMIPTDCostAdjd00 + v.BMIPTDCostAdjd00,
     	       BMIPTDCostAdjd01 = h.BMIPTDCostAdjd01 + v.BMIPTDCostAdjd01,
     	       BMIPTDCostAdjd02 = h.BMIPTDCostAdjd02 + v.BMIPTDCostAdjd02,
     	       BMIPTDCostAdjd03 = h.BMIPTDCostAdjd03 + v.BMIPTDCostAdjd03,
     	       BMIPTDCostAdjd04 = h.BMIPTDCostAdjd04 + v.BMIPTDCostAdjd04,
     	       BMIPTDCostAdjd05 = h.BMIPTDCostAdjd05 + v.BMIPTDCostAdjd05,
     	       BMIPTDCostAdjd06 = h.BMIPTDCostAdjd06 + v.BMIPTDCostAdjd06,
     	       BMIPTDCostAdjd07 = h.BMIPTDCostAdjd07 + v.BMIPTDCostAdjd07,
     	       BMIPTDCostAdjd08 = h.BMIPTDCostAdjd08 + v.BMIPTDCostAdjd08,
     	       BMIPTDCostAdjd09 = h.BMIPTDCostAdjd09 + v.BMIPTDCostAdjd09,
     	       BMIPTDCostAdjd10 = h.BMIPTDCostAdjd10 + v.BMIPTDCostAdjd10,
     	       BMIPTDCostAdjd11 = h.BMIPTDCostAdjd11 + v.BMIPTDCostAdjd11,
     	       BMIPTDCostAdjd12 = h.BMIPTDCostAdjd12 + v.BMIPTDCostAdjd12,
     	       BMIPTDCostIssd00 = h.BMIPTDCostIssd00 + v.BMIPTDCostIssd00,
     	       BMIPTDCostIssd01 = h.BMIPTDCostIssd01 + v.BMIPTDCostIssd01,
     	       BMIPTDCostIssd02 = h.BMIPTDCostIssd02 + v.BMIPTDCostIssd02,
     	       BMIPTDCostIssd03 = h.BMIPTDCostIssd03 + v.BMIPTDCostIssd03,
     	       BMIPTDCostIssd04 = h.BMIPTDCostIssd04 + v.BMIPTDCostIssd04,
     	       BMIPTDCostIssd05 = h.BMIPTDCostIssd05 + v.BMIPTDCostIssd05,
     	       BMIPTDCostIssd06 = h.BMIPTDCostIssd06 + v.BMIPTDCostIssd06,
     	       BMIPTDCostIssd07 = h.BMIPTDCostIssd07 + v.BMIPTDCostIssd07,
     	       BMIPTDCostIssd08 = h.BMIPTDCostIssd08 + v.BMIPTDCostIssd08,
     	       BMIPTDCostIssd09 = h.BMIPTDCostIssd09 + v.BMIPTDCostIssd09,
     	       BMIPTDCostIssd10 = h.BMIPTDCostIssd10 + v.BMIPTDCostIssd10,
     	       BMIPTDCostIssd11 = h.BMIPTDCostIssd11 + v.BMIPTDCostIssd11,
     	       BMIPTDCostIssd12 = h.BMIPTDCostIssd12 + v.BMIPTDCostIssd12,
     	       BMIPTDCostRcvd00 = h.BMIPTDCostRcvd00 + v.BMIPTDCostRcvd00,
     	       BMIPTDCostRcvd01 = h.BMIPTDCostRcvd01 + v.BMIPTDCostRcvd01,
     	       BMIPTDCostRcvd02 = h.BMIPTDCostRcvd02 + v.BMIPTDCostRcvd02,
     	       BMIPTDCostRcvd03 = h.BMIPTDCostRcvd03 + v.BMIPTDCostRcvd03,
     	       BMIPTDCostRcvd04 = h.BMIPTDCostRcvd04 + v.BMIPTDCostRcvd04,
     	       BMIPTDCostRcvd05 = h.BMIPTDCostRcvd05 + v.BMIPTDCostRcvd05,
     	       BMIPTDCostRcvd06 = h.BMIPTDCostRcvd06 + v.BMIPTDCostRcvd06,
     	       BMIPTDCostRcvd07 = h.BMIPTDCostRcvd07 + v.BMIPTDCostRcvd07,
     	       BMIPTDCostRcvd08 = h.BMIPTDCostRcvd08 + v.BMIPTDCostRcvd08,
     	       BMIPTDCostRcvd09 = h.BMIPTDCostRcvd09 + v.BMIPTDCostRcvd09,
     	       BMIPTDCostRcvd10 = h.BMIPTDCostRcvd10 + v.BMIPTDCostRcvd10,
     	       BMIPTDCostRcvd11 = h.BMIPTDCostRcvd11 + v.BMIPTDCostRcvd11,
     	       BMIPTDCostRcvd12 = h.BMIPTDCostRcvd12 + v.BMIPTDCostRcvd12,
-- Removed Until Schema Changed for ItemBMIHist
--  	       BMIPTDCostTrsfrIn00 = h.BMIPTDCostTrsfrIn00 - v.BMIPTDCostTrsfrIn00,
--  	       BMIPTDCostTrsfrIn01 = h.BMIPTDCostTrsfrIn01 - v.BMIPTDCostTrsfrIn01,
--   	       BMIPTDCostTrsfrIn02 = h.BMIPTDCostTrsfrIn02 - v.BMIPTDCostTrsfrIn02,
--   	       BMIPTDCostTrsfrIn03 = h.BMIPTDCostTrsfrIn03 - v.BMIPTDCostTrsfrIn03,
--   	       BMIPTDCostTrsfrIn04 = h.BMIPTDCostTrsfrIn04 - v.BMIPTDCostTrsfrIn04,
--   	       BMIPTDCostTrsfrIn05 = h.BMIPTDCostTrsfrIn05 - v.BMIPTDCostTrsfrIn05,
--   	       BMIPTDCostTrsfrIn06 = h.BMIPTDCostTrsfrIn06 - v.BMIPTDCostTrsfrIn06,
--   	       BMIPTDCostTrsfrIn07 = h.BMIPTDCostTrsfrIn07 - v.BMIPTDCostTrsfrIn07,
--   	       BMIPTDCostTrsfrIn08 = h.BMIPTDCostTrsfrIn08 - v.BMIPTDCostTrsfrIn08,
--   	       BMIPTDCostTrsfrIn09 = h.BMIPTDCostTrsfrIn09 - v.BMIPTDCostTrsfrIn09,
--   	       BMIPTDCostTrsfrIn10 = h.BMIPTDCostTrsfrIn10 - v.BMIPTDCostTrsfrIn10,
--   	       BMIPTDCostTrsfrIn11 = h.BMIPTDCostTrsfrIn11 - v.BMIPTDCostTrsfrIn11,
--   	       BMIPTDCostTrsfrIn12 = h.BMIPTDCostTrsfrIn12 - v.BMIPTDCostTrsfrIn12,
--   	       BMIPTDCostTrsfrOut00 = h.BMIPTDCostTrsfrOut00 + v.BMIPTDCostTrsfrOut00,
--   	       BMIPTDCostTrsfrOut01 = h.BMIPTDCostTrsfrOut01 + v.BMIPTDCostTrsfrOut01,
--   	       BMIPTDCostTrsfrOut02 = h.BMIPTDCostTrsfrOut02 + v.BMIPTDCostTrsfrOut02,
--   	       BMIPTDCostTrsfrOut03 = h.BMIPTDCostTrsfrOut03 + v.BMIPTDCostTrsfrOut03,
--   	       BMIPTDCostTrsfrOut04 = h.BMIPTDCostTrsfrOut04 + v.BMIPTDCostTrsfrOut04,
--   	       BMIPTDCostTrsfrOut05 = h.BMIPTDCostTrsfrOut05 + v.BMIPTDCostTrsfrOut05,
--   	       BMIPTDCostTrsfrOut06 = h.BMIPTDCostTrsfrOut06 + v.BMIPTDCostTrsfrOut06,
--   	       BMIPTDCostTrsfrOut07 = h.BMIPTDCostTrsfrOut07 + v.BMIPTDCostTrsfrOut07,
--   	       BMIPTDCostTrsfrOut08 = h.BMIPTDCostTrsfrOut08 + v.BMIPTDCostTrsfrOut08,
--   	       BMIPTDCostTrsfrOut09 = h.BMIPTDCostTrsfrOut09 + v.BMIPTDCostTrsfrOut09,
--   	       BMIPTDCostTrsfrOut10 = h.BMIPTDCostTrsfrOut10 + v.BMIPTDCostTrsfrOut10,
--   	       BMIPTDCostTrsfrOut11 = h.BMIPTDCostTrsfrOut11 + v.BMIPTDCostTrsfrOut11,
--   	       BMIPTDCostTrsfrOut12 = h.BMIPTDCostTrsfrOut12 + v.BMIPTDCostTrsfrOut12,
               BMIYTDCOGS = h.BMIYTDCOGS + v.BMIYTDCOGS,
     	       BMIYTDCostAdjd = h.BMIYTDCostAdjd + v.BMIYTDCostAdjd,
     	       BMIYTDCostIssd = h.BMIYTDCostIssd + v.BMIYTDCostIssd,
     	       BMIYTDCostRcvd = h.BMIYTDCostRcvd + v.BMIYTDCostRcvd
--   	       BMIYTDCostTrsfrIn = h.BMIYTDCostTrsfrIn - v.BMIYTDCostTrsfrIn,
--   	       BMIYTDCostTrsfrOut = h.BMIYTDCostTrsfrOut + v.BMIYTDCostTrsfrOut
           FROM ItemBMIHist H, vp_10400_BMIUpdateItemHist V
           WHERE V.UserAddress = @UserAddress
             AND H.InvtId = V.InvtId
             AND H.SiteId = V.SiteId
             AND H.FiscYr = V.FiscYr

-- Update Beginning Balance for Years Greater than Posting Year

    Select @ItemHist_LastFiscYr = Max(FiscYr)
           From ItemHist

    Select @FirstFiscYr = LTRIM(STR(CONVERT(INT,@InTran_FirstFiscYr) + 1))

    Select @FiscYr = @FirstFiscYr
    While @FiscYr <= @ItemHist_LastFiscYr
	Begin
   	    Select @PrevFiscYr = LTRIM(STR(CONVERT(INT,@FiscYr) - 1))

            /***** Set Beginning Balance for ItemHist *****/

            UPDATE H
                   SET H.BegBal = CASE WHEN P.BegBal Is NULL Or I.ValMthd = 'U'
                                            THEN 0
                                            ELSE (P.BegBal
                                                - P.PTDCOGS00 - P.PTDCOGS01 - P.PTDCOGS02 - P.PTDCOGS03
                                                - P.PTDCOGS04 - P.PTDCOGS05 - P.PTDCOGS06 - P.PTDCOGS07
                                                - P.PTDCOGS08 - P.PTDCOGS09 - P.PTDCOGS10 - P.PTDCOGS11
                                                - P.PTDCOGS12
                                                + P.PTDCostAdjd00 + P.PTDCostAdjd01 + P.PTDCostAdjd02
                                                + P.PTDCostAdjd03 + P.PTDCostAdjd04 + P.PTDCostAdjd05
                                                + P.PTDCostAdjd06 + P.PTDCostAdjd07 + P.PTDCostAdjd08
                                                + P.PTDCostAdjd09 + P.PTDCostAdjd10 + P.PTDCostAdjd11
                                                + P.PTDCostAdjd12
                                                - P.PTDCostIssd00 - P.PTDCostIssd01 - P.PTDCostIssd02
                                                - P.PTDCostIssd03 - P.PTDCostIssd04 - P.PTDCostIssd05
                                                - P.PTDCostIssd06 - P.PTDCostIssd07 - P.PTDCostIssd08
                                                - P.PTDCostIssd09 - P.PTDCostIssd10 - P.PTDCostIssd11
                                                - P.PTDCostIssd12
                                                + P.PTDCostRcvd00 + P.PTDCostRcvd01 + P.PTDCostRcvd02
                                                + P.PTDCostRcvd03 + P.PTDCostRcvd04 + P.PTDCostRcvd05
                                                + P.PTDCostRcvd06 + P.PTDCostRcvd07 + P.PTDCostRcvd08
                                                + P.PTDCostRcvd09 + P.PTDCostRcvd10 + P.PTDCostRcvd11
                                                + P.PTDCostRcvd12
                                                + P.PTDCostTrsfrIn00 + P.PTDCostTrsfrIn01 + P.PTDCostTrsfrIn02
                                                + P.PTDCostTrsfrIn03 + P.PTDCostTrsfrIn04 + P.PTDCostTrsfrIn05
                                                + P.PTDCostTrsfrIn06 + P.PTDCostTrsfrIn07 + P.PTDCostTrsfrIn08
                                                + P.PTDCostTrsfrIn09 + P.PTDCostTrsfrIn10 + P.PTDCostTrsfrIn11
                                                + P.PTDCostTrsfrIn12
                                                - P.PTDCostTrsfrOut00 - P.PTDCostTrsfrOut01 - P.PTDCostTrsfrOut02
                                                - P.PTDCostTrsfrOut03 - P.PTDCostTrsfrOut04 - P.PTDCostTrsfrOut05
                                                - P.PTDCostTrsfrOut06 - P.PTDCostTrsfrOut07 - P.PTDCostTrsfrOut08
                                                - P.PTDCostTrsfrOut09 - P.PTDCostTrsfrOut10 - P.PTDCostTrsfrOut11
                                                - P.PTDCostTrsfrOut12)
                                  END
                   FROM vp_10400_UpdateItemHist V JOIN ItemHist H
                                                  ON V.InvtId = H.InvtId
                                                  AND V.SiteId = H.SiteId
                                                  AND @FiscYr = H.FiscYr
                                                  JOIN ItemHist P
                                                  ON V.InvtId = P.InvtId
                                                  AND V.SiteId = P.SiteId
                                                  AND @PrevFiscYr = P.FiscYr
                                                  JOIN Inventory I
                                                  ON V.InvtId = I.InvtId
                   WHERE V.UserAddress = @UserAddress

	    SELECT @Err_SQLErrorNbr = @@ERROR
	    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
            PRINT 'Set Beginning Balance for ItemHist Complete'

            UPDATE H
                   SET H.BegQty = CASE WHEN P.BegQty Is NULL
                                            THEN 0
                                            ELSE (P.BegQty
                     - P.PTDQtySls00 - P.PTDQtySls01 - P.PTDQtySls02
                                                - P.PTDQtySls03 - P.PTDQtySls04 - P.PTDQtySls05
                                                - P.PTDQtySls06 - P.PTDQtySls07 - P.PTDQtySls08
                                                - P.PTDQtySls09 - P.PTDQtySls10 - P.PTDQtySls11
                                                - P.PTDQtySls12
                                                + P.PTDQtyAdjd00 + P.PTDQtyAdjd01 + P.PTDQtyAdjd02
                                                + P.PTDQtyAdjd03 + P.PTDQtyAdjd04 + P.PTDQtyAdjd05
                                                + P.PTDQtyAdjd06 + P.PTDQtyAdjd07 + P.PTDQtyAdjd08
                                                + P.PTDQtyAdjd09 + P.PTDQtyAdjd10 + P.PTDQtyAdjd11
                                                + P.PTDQtyAdjd12
                                                - P.PTDQtyIssd00 - P.PTDQtyIssd01 - P.PTDQtyIssd02
                                                - P.PTDQtyIssd03 - P.PTDQtyIssd04 - P.PTDQtyIssd05
                                                - P.PTDQtyIssd06 - P.PTDQtyIssd07 - P.PTDQtyIssd08
                                                - P.PTDQtyIssd09 - P.PTDQtyIssd10 - P.PTDQtyIssd11
                                                - P.PTDQtyIssd12
                                                + P.PTDQtyRcvd00 + P.PTDQtyRcvd01 + P.PTDQtyRcvd02
                                                + P.PTDQtyRcvd03 + P.PTDQtyRcvd04 + P.PTDQtyRcvd05
                                                + P.PTDQtyRcvd06 + P.PTDQtyRcvd07 + P.PTDQtyRcvd08
                                                + P.PTDQtyRcvd09 + P.PTDQtyRcvd10 + P.PTDQtyRcvd11
                                                + P.PTDQtyRcvd12
                                                + P.PTDQtyTrsfrIn00 + P.PTDQtyTrsfrIn01 + P.PTDQtyTrsfrIn02
                                                + P.PTDQtyTrsfrIn03 + P.PTDQtyTrsfrIn04 + P.PTDQtyTrsfrIn05
                                                + P.PTDQtyTrsfrIn06 + P.PTDQtyTrsfrIn07 + P.PTDQtyTrsfrIn08
                                                + P.PTDQtyTrsfrIn09 + P.PTDQtyTrsfrIn10 + P.PTDQtyTrsfrIn11
                                                + P.PTDQtyTrsfrIn12
                                                - P.PTDQtyTrsfrOut00 - P.PTDQtyTrsfrOut01 - P.PTDQtyTrsfrOut02
                                                - P.PTDQtyTrsfrOut03 - P.PTDQtyTrsfrOut04 - P.PTDQtyTrsfrOut05
                                                - P.PTDQtyTrsfrOut06 - P.PTDQtyTrsfrOut07 - P.PTDQtyTrsfrOut08
                                                - P.PTDQtyTrsfrOut09 - P.PTDQtyTrsfrOut10 - P.PTDQtyTrsfrOut11
                                                - P.PTDQtyTrsfrOut12)
                                  END
                   FROM vp_10400_UpdateItemHist V JOIN Item2Hist H
                                                  ON V.InvtId = H.InvtId
                                                  AND V.SiteId = H.SiteId
                                                  AND @FiscYr = H.FiscYr
                                                  JOIN Item2Hist P
                                                  ON V.InvtId = P.InvtId
                                                  AND V.SiteId = P.SiteId
                                                  AND @PrevFiscYr = P.FiscYr
                   WHERE V.UserAddress = @UserAddress

	    SELECT @Err_SQLErrorNbr = @@ERROR
	    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
            PRINT 'Set Beginning Balance for Item2Hist Complete'

            PRINT 'Update ItemBMIHist Complete'

            /***** Set Beginning Balance for ItemBMIHist *****/

            UPDATE H
                   SET H.BMIBegBal = CASE WHEN P.BMIBegBal Is NULL Or I.ValMthd = 'U'
                                               THEN 0
                       ELSE (P.BMIBegBal
                                                   - P.BMIPTDCOGS00 - P.BMIPTDCOGS01 - P.BMIPTDCOGS02 - P.BMIPTDCOGS03
                                                   - P.BMIPTDCOGS04 - P.BMIPTDCOGS05 - P.BMIPTDCOGS06 - P.BMIPTDCOGS07
                                                   - P.BMIPTDCOGS08 - P.BMIPTDCOGS09 - P.BMIPTDCOGS10 - P.BMIPTDCOGS11
                                                   - P.BMIPTDCOGS12
                                                   + P.BMIPTDCostAdjd00 + P.BMIPTDCostAdjd01 + P.BMIPTDCostAdjd02
                                                   + P.BMIPTDCostAdjd03 + P.BMIPTDCostAdjd04 + P.BMIPTDCostAdjd05
                                                   + P.BMIPTDCostAdjd06 + P.BMIPTDCostAdjd07 + P.BMIPTDCostAdjd08
                                                   + P.BMIPTDCostAdjd09 + P.BMIPTDCostAdjd10 + P.BMIPTDCostAdjd11
                                                   + P.BMIPTDCostAdjd12
                                                   - P.BMIPTDCostIssd00 - P.BMIPTDCostIssd01 - P.BMIPTDCostIssd02
                                                   - P.BMIPTDCostIssd03 - P.BMIPTDCostIssd04 - P.BMIPTDCostIssd05
                                                   - P.BMIPTDCostIssd06 - P.BMIPTDCostIssd07 - P.BMIPTDCostIssd08
                                                   - P.BMIPTDCostIssd09 - P.BMIPTDCostIssd10 - P.BMIPTDCostIssd11
                                                   - P.BMIPTDCostIssd12
                                                   + P.BMIPTDCostRcvd00 + P.BMIPTDCostRcvd01 + P.BMIPTDCostRcvd02
                                                   + P.BMIPTDCostRcvd03 + P.BMIPTDCostRcvd04 + P.BMIPTDCostRcvd05
                                                   + P.BMIPTDCostRcvd06 + P.BMIPTDCostRcvd07 + P.BMIPTDCostRcvd08
                                                   + P.BMIPTDCostRcvd09 + P.BMIPTDCostRcvd10 + P.BMIPTDCostRcvd11
                                                   + P.BMIPTDCostRcvd12)
--                                                   + P.BMIPTDCostTrsfrIn00 + P.BMIPTDCostTrsfrIn01 + P.BMIPTDCostTrsfrIn02
--                                                   + P.BMIPTDCostTrsfrIn03 + P.BMIPTDCostTrsfrIn04 + P.BMIPTDCostTrsfrIn05
--                                                   + P.BMIPTDCostTrsfrIn06 + P.BMIPTDCostTrsfrIn07 + P.BMIPTDCostTrsfrIn08
--                                                   + P.BMIPTDCostTrsfrIn09 + P.BMIPTDCostTrsfrIn10 + P.BMIPTDCostTrsfrIn11
--                                                   + P.BMIPTDCostTrsfrIn12
--                                                   - P.BMIPTDCostTrsfrOut00 - P.BMIPTDCostTrsfrOut01 - P.BMIPTDCostTrsfrOut02
--                                                   - P.BMIPTDCostTrsfrOut03 - P.BMIPTDCostTrsfrOut04 - P.BMIPTDCostTrsfrOut05
--                                                   - P.BMIPTDCostTrsfrOut06 - P.BMIPTDCostTrsfrOut07 - P.BMIPTDCostTrsfrOut08
--                                                   - P.BMIPTDCostTrsfrOut09 - P.BMIPTDCostTrsfrOut10 - P.BMIPTDCostTrsfrOut11
--                                                   - P.BMIPTDCostTrsfrOut12)
                                     END
                   FROM vp_10400_BMIUpdateItemHist V JOIN ItemBMIHist H
                                                     ON V.InvtId = H.InvtId
                                                     AND V.SiteId = H.SiteId
                                                     AND @FiscYr = H.FiscYr
                                                     JOIN ItemBMIHist P
                                                     ON V.InvtId = P.InvtId
                                                     AND V.SiteId = P.SiteId
                                                     AND @PrevFiscYr = P.FiscYr
                                                     JOIN Inventory I
                                         ON V.InvtId = I.InvtId
                   WHERE V.UserAddress = @UserAddress

	    SELECT @Err_SQLErrorNbr = @@ERROR
	    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
            PRINT 'Set Beginning Balance for ItemBMIHist Complete'

            Select @FiscYr = LTRIM(STR(CONVERT(INT,@FiscYr) + 1))

    END

GOTO FINISH

ABORT:
	Insert INTO IN10400_Return
		(BatNbr, BatchType, COGSBatchCreated, ComputerName, Crtd_DateTime, MsgNbr,
		MsgType, ParmCnt, Parm00, Parm01, Parm02, Parm03, Parm04, Parm05,
		S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
		S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12, SQLErrorNbr)
	Select	@Err_BatNbr, @Err_BatchType, @Err_COGSBatchCreated, @Err_ComputerName, @Err_Crtd_DateTime, @Err_MsgNbr,
		@Err_MsgType, @Err_ParmCnt, @Err_Parm00, @Err_Parm01, @Err_Parm02, @Err_Parm03, @Err_Parm04, @Err_Parm05,
		@Err_S4Future01, @Err_S4Future02, @Err_S4Future03, @Err_S4Future04, @Err_S4Future05, @Err_S4Future06,
		@Err_S4Future07, @Err_S4Future08, @Err_S4Future09, @Err_S4Future10, @Err_S4Future11, @Err_S4Future12,
		@Err_SQLErrorNbr

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10400_UpdateItemHist] TO [MSDSL]
    AS [dbo];


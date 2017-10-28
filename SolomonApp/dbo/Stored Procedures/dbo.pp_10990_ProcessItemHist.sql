 CREATE PROC pp_10990_ProcessItemHist
            @ProgID VARCHAR (8),	-- Prog_Name
            @UserID VARCHAR (10),	-- User_Name
	    @Cpnyid VarChar (10)	-- Company ID
AS
    Set NoCount ON
    DECLARE @FiscYr     	 CHAR(4)
    DECLARE @INSetup_FiscYr  	 CHAR(4)
    DECLARE @INTran_FirstFiscYr  CHAR(4)
    DECLARE @INTran_LastFiscYr	 CHAR(4)
    DECLARE @ItemHist_LastFiscYr CHAR(4)
    DECLARE @PerNbr          	 CHAR(6)
    DECLARE @PrevFiscYr     	 CHAR(4)
    DECLARE @GLMaxPeriod         SMALLINT

    DECLARE @ErrFlag             INT,
	    @ErrChkPt            VARCHAR(255)
    SELECT  @ErrChkPt = 'pp_10990_ProcessItemHist ' + ''' + RTRIM(@ProgID) + '', '' + RTRIM(@UserID) + '''

    SELECT @GLMaxPeriod = NbrPer FROM GLSetup

    SELECT @PerNbr = PerNbr,
           @INSetup_FiscYr = (SUBSTRING(PerNbr, 1, 4))
      FROM INSetup

    SELECT @INTran_FirstFiscYr = Min(FiscYr),
           @INTran_LastFiscYr = Max(FiscYr)
    FROM   vp_10990_ItemHist_INTran
    WHERE  CpnyID = @CpnyID

	DELETE FROM ItemHist WHERE SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)
	DELETE FROM Item2Hist WHERE SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)
	DELETE FROM ItemBMIHist WHERE SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

BEGIN TRANSACTION
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
                         0, GetDate(), @ProgID, @UserID, v.FiscYr, v.InvtId,
                         GetDate(), @ProgID, @UserID, 0,
                         PerNbr = CASE WHEN v.Fiscyr = @INSetup_FiscYr THEN @PerNbr
                                       WHEN v.Fiscyr < @INSetup_FiscYr THEN (v.Fiscyr + Convert(char(2), @GLMaxPeriod))
                                       ELSE (v.Fiscyr + '01')
                                  END,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         '', '', 0, 0, 0, 0, '1900-01-01', '1900-01-01', 0, 0, '', '',
                         v.SiteId, '', '', 0, 0, '', '', '1900-01-01', '1900-01-01',
                         0, 0, 0, 0, 0, 0, 0
                         FROM 	vp_10990_SumItemHist V LEFT OUTER JOIN ItemHist H
                                                        ON V.InvtId = H.InvtId
                                                        AND V.SiteId = H.SiteId
                                                        AND V.FiscYr = H.FiscYr
            	         WHERE 	H.InvtId IS NULL
			 AND	V.SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

	    SELECT @ErrFlag = @@ERROR, @ErrChkPt = '[01] ' + @ErrChkPt
	    IF @ErrFlag <> 0 GOTO Abort

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
                         0, GetDate(), @ProgID, @UserID, v.FiscYr, v.InvtId,
                         GetDate(), @ProgID, @UserID,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         '', '', 0, 0, 0, 0, '1900-01-01', '1900-01-01', 0, 0, '', '',
                         v.SiteId, '', '', 0, 0, '', '', '1900-01-01', '1900-01-01',
                         0, 0, 0, 0, 0, 0
                         FROM vp_10990_SumItemHist V LEFT OUTER JOIN Item2Hist H
                                                        ON V.InvtId = H.InvtId
                                                        AND V.SiteId = H.SiteId
                                                        AND V.FiscYr = H.FiscYr
                          WHERE H.InvtId IS NULL
			  AND	V.SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

	    SELECT @ErrFlag = @@ERROR, @ErrChkPt = '[02] ' + @ErrChkPt
	    IF @ErrFlag <> 0 GOTO Abort

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
                          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                          0, 0, 0, 0,
                          GetDate(), @ProgID, @UserID, v.FiscYr, v.InvtId,
                          GetDate(), @ProgID, @UserID,
                          '', '', 0, 0, 0, 0, '1900-01-01', '1900-01-01', 0, 0, '', '',
                          v.SiteId, '', '', 0, 0, '', '', '1900-01-01', '1900-01-01'
                          FROM vp_10990_Sum_BMIItemHist V LEFT OUTER JOIN ItemBMIHist H
                                                        ON V.InvtId = H.InvtId
                                                        AND V.SiteId = H.SiteId
                                                        AND V.FiscYr = H.FiscYr
                          WHERE H.InvtId IS NULL
			  AND	V.SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

	    SELECT @ErrFlag = @@ERROR, @ErrChkPt = '[03] ' + @ErrChkPt
	    IF @ErrFlag <> 0 GOTO Abort

            PRINT 'Create ItemBMIHist Records Complete'

    -- Update the TranAmt field in the INTran table to always be positive for
    -- Credit Memos CM from Order Management.
    -- This is to fix data that was corrupted by a defect that created negative
    -- tranamt's for OM Credit Memos that were negative.
    UPDATE INTran
	SET 	TranAmt = ABS(TranAmt)
	FROM 	INTran
	WHERE 	S4Future09 = 1
	  AND	JrnlType = 'OM'
	  AND	TranType = 'CM'
	  AND	TranAmt < 0

    /***** Update ItemHist *****/
    UPDATE H
           SET LUpd_DateTime = GetDate(),
               LUpd_Prog = @ProgID,
               LUpd_User = @UserID,
               PTDCOGS00 =  v.PTDCOGS00,
               PTDCOGS01 =  v.PTDCOGS01,
               PTDCOGS02 =  v.PTDCOGS02,
               PTDCOGS03 =  v.PTDCOGS03,
               PTDCOGS04 =  v.PTDCOGS04,
     	       PTDCOGS05 =  v.PTDCOGS05,
     	       PTDCOGS06 =  v.PTDCOGS06,
     	       PTDCOGS07 =  v.PTDCOGS07,
     	       PTDCOGS08 =  v.PTDCOGS08,
     	       PTDCOGS09 =  v.PTDCOGS09,
     	       PTDCOGS10 =  v.PTDCOGS10,
     	       PTDCOGS11 =  v.PTDCOGS11,
     	       PTDCOGS12 =  v.PTDCOGS12,
     	       PTDCostAdjd00 =  v.PTDCostAdjd00,
     	       PTDCostAdjd01 =  v.PTDCostAdjd01,
     	       PTDCostAdjd02 =  v.PTDCostAdjd02,
       	       PTDCostAdjd03 =  v.PTDCostAdjd03,
     	       PTDCostAdjd04 =  v.PTDCostAdjd04,
     	       PTDCostAdjd05 =  v.PTDCostAdjd05,
     	       PTDCostAdjd06 =  v.PTDCostAdjd06,
     	       PTDCostAdjd07 =  v.PTDCostAdjd07,
     	       PTDCostAdjd08 =  v.PTDCostAdjd08,
     	       PTDCostAdjd09 =  v.PTDCostAdjd09,
     	       PTDCostAdjd10 =  v.PTDCostAdjd10,
     	       PTDCostAdjd11 =  v.PTDCostAdjd11,
     	       PTDCostAdjd12 =  v.PTDCostAdjd12,
     	       PTDCostIssd00 =  v.PTDCostIssd00,
      	       PTDCostIssd01 =  v.PTDCostIssd01,
     	       PTDCostIssd02 =  v.PTDCostIssd02,
     	       PTDCostIssd03 =  v.PTDCostIssd03,
     	       PTDCostIssd04 =  v.PTDCostIssd04,
     	       PTDCostIssd05 =  v.PTDCostIssd05,
     	       PTDCostIssd06 =  v.PTDCostIssd06,
     	       PTDCostIssd07 =  v.PTDCostIssd07,
     	       PTDCostIssd08 =  v.PTDCostIssd08,
     	       PTDCostIssd09 =  v.PTDCostIssd09,
     	       PTDCostIssd10 =  v.PTDCostIssd10,
     	       PTDCostIssd11 =  v.PTDCostIssd11,
     	       PTDCostIssd12 =  v.PTDCostIssd12,
     	   PTDCostRcvd00 =  v.PTDCostRcvd00,
     	       PTDCostRcvd01 =  v.PTDCostRcvd01,
     	       PTDCostRcvd02 =  v.PTDCostRcvd02,
     	       PTDCostRcvd03 =  v.PTDCostRcvd03,
     	       PTDCostRcvd04 =  v.PTDCostRcvd04,
     	       PTDCostRcvd05 =  v.PTDCostRcvd05,
     	       PTDCostRcvd06 =  v.PTDCostRcvd06,
     	       PTDCostRcvd07 =  v.PTDCostRcvd07,
     	       PTDCostRcvd08 =  v.PTDCostRcvd08,
     	       PTDCostRcvd09 =  v.PTDCostRcvd09,
     	       PTDCostRcvd10 =  v.PTDCostRcvd10,
     	       PTDCostRcvd11 =  v.PTDCostRcvd11,
     	       PTDCostRcvd12 =  v.PTDCostRcvd12,
     	       PTDCostTrsfrIn00 =  v.PTDCostTrsfrIn00,
     	       PTDCostTrsfrIn01 =  v.PTDCostTrsfrIn01,
     	       PTDCostTrsfrIn02 =  v.PTDCostTrsfrIn02,
     	       PTDCostTrsfrIn03 =  v.PTDCostTrsfrIn03,
     	       PTDCostTrsfrIn04 =  v.PTDCostTrsfrIn04,
     	       PTDCostTrsfrIn05 =  v.PTDCostTrsfrIn05,
     	       PTDCostTrsfrIn06 =  v.PTDCostTrsfrIn06,
     	       PTDCostTrsfrIn07 =  v.PTDCostTrsfrIn07,
     	       PTDCostTrsfrIn08 =  v.PTDCostTrsfrIn08,
     	       PTDCostTrsfrIn09 =  v.PTDCostTrsfrIn09,
     	       PTDCostTrsfrIn10 =  v.PTDCostTrsfrIn10,
     	       PTDCostTrsfrIn11 =  v.PTDCostTrsfrIn11,
     	       PTDCostTrsfrIn12 =  v.PTDCostTrsfrIn12,
     	       PTDCostTrsfrOut00 = v.PTDCostTrsfrOut00,
     	       PTDCostTrsfrOut01 =  v.PTDCostTrsfrOut01,
     	       PTDCostTrsfrOut02 =  v.PTDCostTrsfrOut02,
     	       PTDCostTrsfrOut03 =  v.PTDCostTrsfrOut03,
     	       PTDCostTrsfrOut04 =  v.PTDCostTrsfrOut04,
     	       PTDCostTrsfrOut05 =  v.PTDCostTrsfrOut05,
     	       PTDCostTrsfrOut06 =  v.PTDCostTrsfrOut06,
     	       PTDCostTrsfrOut07 =  v.PTDCostTrsfrOut07,
     	       PTDCostTrsfrOut08 =  v.PTDCostTrsfrOut08,
     	       PTDCostTrsfrOut09 =  v.PTDCostTrsfrOut09,
     	       PTDCostTrsfrOut10 =  v.PTDCostTrsfrOut10,
     	       PTDCostTrsfrOut11 =  v.PTDCostTrsfrOut11,
     	       PTDSls00 =  v.PTDSls00,
     	       PTDSls01 =  v.PTDSls01,
     	       PTDSls02 =  v.PTDSls02,
     	       PTDSls03 =  v.PTDSls03,
     	       PTDSls04 =  v.PTDSls04,
     	       PTDSls05 =  v.PTDSls05,
     	       PTDSls06 =  v.PTDSls06,
     	       PTDSls07 =  v.PTDSls07,
     	       PTDSls08 =  v.PTDSls08,
     	       PTDSls09 =  v.PTDSls09,
     	       PTDSls10 =  v.PTDSls10,
     	       PTDSls11 =  v.PTDSls11,
     	       PTDSls12 =  v.PTDSls12,
               YTDCOGS =  v.YTDCOGS,
     	       YTDCostAdjd =  v.YTDCostAdjd,
     	       YTDCostIssd =  v.YTDCostIssd,
     	       YTDCostRcvd =  v.YTDCostRcvd,
     	       YTDCostTrsfrIn = v.YTDCostTrsfrIn,
               YTDCostTrsfrOut =  v.YTDCostTrsfrOut,
     	       YTDSls =  v.YTDSls
           FROM ItemHist H, vp_10990_SumItemHist V
           WHERE H.InvtId = V.InvtId
             AND H.SiteId = V.SiteId
             AND H.FiscYr = V.FiscYr
	     AND V.SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

    SELECT @ErrFlag = @@ERROR, @ErrChkPt = '[04] ' + @ErrChkPt
    IF @ErrFlag <> 0 GOTO Abort

    PRINT 'Update ItemHist Cost Complete'

    UPDATE H
           SET LUpd_DateTime = GetDate(),
               LUpd_Prog = @ProgID,
               LUpd_User = @UserID,
     	       PTDQtyAdjd00 =  v.PTDQtyAdjd00,
     	       PTDQtyAdjd01 =  v.PTDQtyAdjd01,
     	       PTDQtyAdjd02 =  v.PTDQtyAdjd02,
     	       PTDQtyAdjd03 =  v.PTDQtyAdjd03,
     	       PTDQtyAdjd04 =  v.PTDQtyAdjd04,
     	       PTDQtyAdjd05 =  v.PTDQtyAdjd05,
     	       PTDQtyAdjd06 =  v.PTDQtyAdjd06,
     	       PTDQtyAdjd07 =  v.PTDQtyAdjd07,
     	       PTDQtyAdjd08 =  v.PTDQtyAdjd08,
     	       PTDQtyAdjd09 =  v.PTDQtyAdjd09,
     	       PTDQtyAdjd10 =  v.PTDQtyAdjd10,
     	       PTDQtyAdjd11 =  v.PTDQtyAdjd11,
     	       PTDQtyAdjd12 =  v.PTDQtyAdjd12,
     	       PTDQtyIssd00 =  v.PTDQtyIssd00,
     	       PTDQtyIssd01 =  v.PTDQtyIssd01,
   	       PTDQtyIssd02 =  v.PTDQtyIssd02,
     	       PTDQtyIssd03 =  v.PTDQtyIssd03,
     	       PTDQtyIssd04 =  v.PTDQtyIssd04,
     	       PTDQtyIssd05 =  v.PTDQtyIssd05,
     	       PTDQtyIssd06 =  v.PTDQtyIssd06,
     	       PTDQtyIssd07 =  v.PTDQtyIssd07,
     	       PTDQtyIssd08 =  v.PTDQtyIssd08,
     	       PTDQtyIssd09 =  v.PTDQtyIssd09,
     	       PTDQtyIssd10 =  v.PTDQtyIssd10,
     	       PTDQtyIssd11 =  v.PTDQtyIssd11,
     	       PTDQtyIssd12 =  v.PTDQtyIssd12,
	       PTDQtyRcvd00 =  v.PTDQtyRcvd00,
	       PTDQtyRcvd01 =  v.PTDQtyRcvd01,
	       PTDQtyRcvd02 =  v.PTDQtyRcvd02,
	       PTDQtyRcvd03 =  v.PTDQtyRcvd03,
	       PTDQtyRcvd04 =  v.PTDQtyRcvd04,
	       PTDQtyRcvd05 =  v.PTDQtyRcvd05,
	       PTDQtyRcvd06 =  v.PTDQtyRcvd06,
	       PTDQtyRcvd07 =  v.PTDQtyRcvd07,
	       PTDQtyRcvd08 =  v.PTDQtyRcvd08,
	       PTDQtyRcvd09 =  v.PTDQtyRcvd09,
	       PTDQtyRcvd10 =  v.PTDQtyRcvd10,
	       PTDQtyRcvd11 =  v.PTDQtyRcvd11,
	       PTDQtyRcvd12 =  v.PTDQtyRcvd12,
     	       PTDQtySls00 =  v.PTDQtySls00,
     	       PTDQtySls01 =  v.PTDQtySls01,
     	       PTDQtySls02 =  v.PTDQtySls02,
     	       PTDQtySls03 =  v.PTDQtySls03,
     	       PTDQtySls04 =  v.PTDQtySls04,
     	       PTDQtySls05 =  v.PTDQtySls05,
     	       PTDQtySls06 =  v.PTDQtySls06,
     	       PTDQtySls07 =  v.PTDQtySls07,
     	       PTDQtySls08 =  v.PTDQtySls08,
     	       PTDQtySls09 =  v.PTDQtySls09,
     	       PTDQtySls10 =  v.PTDQtySls10,
     	       PTDQtySls11 =  v.PTDQtySls11,
     	       PTDQtySls12 =  v.PTDQtySls12,
     	       PTDQtyTrsfrIn00 =  v.PTDQtyTrsfrIn00,
     	       PTDQtyTrsfrIn01 =  v.PTDQtyTrsfrIn01,
     	       PTDQtyTrsfrIn02 =  v.PTDQtyTrsfrIn02,
     	       PTDQtyTrsfrIn03 =  v.PTDQtyTrsfrIn03,
     	       PTDQtyTrsfrIn04 =  v.PTDQtyTrsfrIn04,
     	       PTDQtyTrsfrIn05 =  v.PTDQtyTrsfrIn05,
     	       PTDQtyTrsfrIn06 =  v.PTDQtyTrsfrIn06,
     	       PTDQtyTrsfrIn07 =  v.PTDQtyTrsfrIn07,
     	       PTDQtyTrsfrIn08 =  v.PTDQtyTrsfrIn08,
     	       PTDQtyTrsfrIn09 =  v.PTDQtyTrsfrIn09,
     	       PTDQtyTrsfrIn10 =  v.PTDQtyTrsfrIn10,
     	       PTDQtyTrsfrIn11 =  v.PTDQtyTrsfrIn11,
     	       PTDQtyTrsfrIn12 =  v.PTDQtyTrsfrIn12,
     	       PTDQtyTrsfrOut00 =  v.PTDQtyTrsfrOut00,
     	       PTDQtyTrsfrOut01 =  v.PTDQtyTrsfrOut01,
     	       PTDQtyTrsfrOut02 =  v.PTDQtyTrsfrOut02,
     	       PTDQtyTrsfrOut03 =  v.PTDQtyTrsfrOut03,
     	       PTDQtyTrsfrOut04 =  v.PTDQtyTrsfrOut04,
     	       PTDQtyTrsfrOut05 =  v.PTDQtyTrsfrOut05,
     	       PTDQtyTrsfrOut06 =  v.PTDQtyTrsfrOut06,
     	       PTDQtyTrsfrOut07 =  v.PTDQtyTrsfrOut07,
     	       PTDQtyTrsfrOut08 =  v.PTDQtyTrsfrOut08,
     	       PTDQtyTrsfrOut09 =  v.PTDQtyTrsfrOut09,
     	       PTDQtyTrsfrOut10 =  v.PTDQtyTrsfrOut10,
     	       PTDQtyTrsfrOut11 =  v.PTDQtyTrsfrOut11,
     	       PTDQtyTrsfrOut12 =  v.PTDQtyTrsfrOut12,
     	       YTDQtyAdjd =  v.YTDQtyAdjd,
     	       YTDQtyIssd =  v.YTDQtyIssd,
	       YTDQtyRcvd =  v.YTDQtyRcvd,
     	       YTDQtySls =  v.YTDQtySls,
     	       YTDQtyTrsfrIn =  v.YTDQtyTrsfrIn,
     	       YTDQtyTrsfrOut =  v.YTDQtyTrsfrOut
           FROM Item2Hist H, vp_10990_SumItemHist V
           WHERE H.InvtId = V.InvtId
             AND H.SiteId = V.SiteId
             AND H.FiscYr = V.FiscYr
	     AND V.SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

    SELECT @ErrFlag = @@ERROR, @ErrChkPt = '[05] ' + @ErrChkPt
    IF @ErrFlag <> 0 GOTO Abort

    PRINT 'Update Item2Hist Quantity Complete'

    /***** Update ItemBMIHist *****/
    UPDATE H
           SET LUpd_DateTime = GetDate(),
               LUpd_Prog = @ProgID,
               LUpd_User = @UserID,
               BMIPTDCOGS00 = v.BMIPTDCOGS00,
               BMIPTDCOGS01 = v.BMIPTDCOGS01,
               BMIPTDCOGS02 = v.BMIPTDCOGS02,
     	       BMIPTDCOGS03 = v.BMIPTDCOGS03,
     	       BMIPTDCOGS04 = v.BMIPTDCOGS04,
     	       BMIPTDCOGS05 = v.BMIPTDCOGS05,
     	       BMIPTDCOGS06 = v.BMIPTDCOGS06,
     	       BMIPTDCOGS07 = v.BMIPTDCOGS07,
     	       BMIPTDCOGS08 = v.BMIPTDCOGS08,
     	       BMIPTDCOGS09 = v.BMIPTDCOGS09,
     	       BMIPTDCOGS10 = v.BMIPTDCOGS10,
     	       BMIPTDCOGS11 = v.BMIPTDCOGS11,
     	       BMIPTDCOGS12 = v.BMIPTDCOGS12,
     	       BMIPTDCostAdjd00 = v.BMIPTDCostAdjd00,
     	       BMIPTDCostAdjd01 = v.BMIPTDCostAdjd01,
     	       BMIPTDCostAdjd02 = v.BMIPTDCostAdjd02,
     	       BMIPTDCostAdjd03 = v.BMIPTDCostAdjd03,
     	       BMIPTDCostAdjd04 = v.BMIPTDCostAdjd04,
     	       BMIPTDCostAdjd05 = v.BMIPTDCostAdjd05,
     	       BMIPTDCostAdjd06 = v.BMIPTDCostAdjd06,
     	       BMIPTDCostAdjd07 = v.BMIPTDCostAdjd07,
     	       BMIPTDCostAdjd08 = v.BMIPTDCostAdjd08,
     	       BMIPTDCostAdjd09 = v.BMIPTDCostAdjd09,
     	       BMIPTDCostAdjd10 = v.BMIPTDCostAdjd10,
     	       BMIPTDCostAdjd11 = v.BMIPTDCostAdjd11,
     	       BMIPTDCostAdjd12 = v.BMIPTDCostAdjd12,
     	       BMIPTDCostIssd00 = v.BMIPTDCostIssd00,
     	       BMIPTDCostIssd01 = v.BMIPTDCostIssd01,
     	       BMIPTDCostIssd02 = v.BMIPTDCostIssd02,
     	       BMIPTDCostIssd03 = v.BMIPTDCostIssd03,
     	       BMIPTDCostIssd04 = v.BMIPTDCostIssd04,
     	       BMIPTDCostIssd05 = v.BMIPTDCostIssd05,
     	       BMIPTDCostIssd06 = v.BMIPTDCostIssd06,
     	       BMIPTDCostIssd07 = v.BMIPTDCostIssd07,
     	       BMIPTDCostIssd08 = v.BMIPTDCostIssd08,
     	       BMIPTDCostIssd09 = v.BMIPTDCostIssd09,
     	       BMIPTDCostIssd10 = v.BMIPTDCostIssd10,
     	       BMIPTDCostIssd11 = v.BMIPTDCostIssd11,
     	       BMIPTDCostIssd12 = v.BMIPTDCostIssd12,
     	       BMIPTDCostRcvd00 = v.BMIPTDCostRcvd00,
     	       BMIPTDCostRcvd01 = v.BMIPTDCostRcvd01,
     	       BMIPTDCostRcvd02 = v.BMIPTDCostRcvd02,
     	       BMIPTDCostRcvd03 = v.BMIPTDCostRcvd03,
     	       BMIPTDCostRcvd04 = v.BMIPTDCostRcvd04,
     	       BMIPTDCostRcvd05 = v.BMIPTDCostRcvd05,
     	       BMIPTDCostRcvd06 = v.BMIPTDCostRcvd06,
     	       BMIPTDCostRcvd07 = v.BMIPTDCostRcvd07,
     	       BMIPTDCostRcvd08 = v.BMIPTDCostRcvd08,
     	       BMIPTDCostRcvd09 = v.BMIPTDCostRcvd09,
     	       BMIPTDCostRcvd10 = v.BMIPTDCostRcvd10,
     	       BMIPTDCostRcvd11 = v.BMIPTDCostRcvd11,
     	       BMIPTDCostRcvd12 = v.BMIPTDCostRcvd12,
               BMIYTDCOGS = v.BMIYTDCOGS,
     	       BMIYTDCostAdjd = v.BMIYTDCostAdjd,
     	       BMIYTDCostIssd = v.BMIYTDCostIssd,
     	       BMIYTDCostRcvd = v.BMIYTDCostRcvd
           FROM ItemBMIHist H, vp_10990_Sum_BMIItemHist V
           WHERE H.InvtId = V.InvtId
             AND H.SiteId = V.SiteId
             AND H.FiscYr = V.FiscYr
	     AND V.SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

    SELECT @ErrFlag = @@ERROR, @ErrChkPt = '[06] ' + @ErrChkPt
    IF @ErrFlag <> 0 GOTO Abort

    PRINT 'Update ItemBMIHist Quantity Complete'

-- Update Beginning Balance for Years Greater than Posting Year

    SELECT @ItemHist_LastFiscYr = Max(FiscYr)
           FROM ItemHist

    SELECT @FiscYr = @InTran_FirstFiscYr

    WHILE @FiscYr <= @ItemHist_LastFiscYr
	BEGIN
   	    SELECT @PrevFiscYr = LTRIM(STR(CONVERT(INT, @FiscYr) - 1))

            /***** Set Beginning Balance for ItemHist *****/

	    --Clear out the BegBal for the current fiscal year because this join
	    --will not include history tables with no previous year.
	    UPDATE ItemHist SET BegBal = 0
	    WHERE Fiscyr = @Fiscyr
	    AND SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

            UPDATE H
                   SET H.BegBal = CASE WHEN P.BegBal IS NULL Or I.ValMthd = 'U'
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
                   FROM vp_10990_SumItemHist V JOIN ItemHist H
                                                  ON V.InvtId = H.InvtId
                                                  AND V.SiteId = H.SiteId
                                                  AND V.FiscYr = @PrevFiscYr
                                                  JOIN ItemHist P
                                                  ON V.InvtId = P.InvtId
                                                  AND V.SiteId = P.SiteId
                                                  AND V.FiscYr = P.FiscYr
                                                  JOIN Inventory I
                                                  ON V.InvtId = I.InvtId
                   WHERE H.Fiscyr = @Fiscyr
                     AND P.Fiscyr = @PrevFiscYr
		     AND V.SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

            SELECT @ErrFlag = @@ERROR, @ErrChkPt = '[07] ' + @ErrChkPt
            IF @ErrFlag <> 0 GOTO Abort

            PRINT 'Set Beginning Balance for ItemHist Complete'

	    --Clear out the BegQty for the current fiscal year because this join
	    --will not include history tables with no previous year.
	    UPDATE Item2Hist SET BegQty = 0
	    WHERE Fiscyr = @Fiscyr
	    AND SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

            UPDATE H
                   SET H.BegQty = CASE WHEN P.BegQty IS NULL
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
                   FROM vp_10990_SumItemHist V JOIN Item2Hist H
                                                  ON V.InvtId = H.InvtId
                                                  AND V.SiteId = H.SiteId
                                                  AND V.FiscYr = @PrevFiscYr
                                                  JOIN Item2Hist P
                                                  ON V.InvtId = P.InvtId
                                                  AND V.SiteId = P.SiteId
                                                  AND V.FiscYr = P.FiscYr
                   WHERE H.Fiscyr = @Fiscyr
                     AND P.Fiscyr = @PrevFiscYr
		     AND V.SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

            SELECT @ErrFlag = @@ERROR, @ErrChkPt = '[08] ' + @ErrChkPt
            IF @ErrFlag <> 0 GOTO Abort

            PRINT 'Set Beginning Balance for Item2Hist Complete'

            /***** Set Beginning Balance for ItemBMIHist *****/

	    --Clear out the BegQty for the current fiscal year because this join
	    --will not include history tables with no previous year.
	    UPDATE ItemBMIHist SET BMIBegBal = 0
	    WHERE Fiscyr = @Fiscyr
	    AND SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

            UPDATE H
                   SET H.BMIBegBal = CASE WHEN P.BMIBegBal IS NULL Or I.ValMthd = 'U'
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
                                     END
                   FROM vp_10990_Sum_BMIItemHist V JOIN ItemBMIHist H
                                                  ON V.InvtId = H.InvtId
                                                  AND V.SiteId = H.SiteId
                                                  AND V.FiscYr = @PrevFiscYr
                                                  JOIN ItemBMIHist P
                                                  ON V.InvtId = P.InvtId
                                                  AND V.SiteId = P.SiteId
                                                  AND V.FiscYr = P.FiscYr
                                                  JOIN Inventory I
                                                  ON V.InvtId = I.InvtId
                   WHERE H.Fiscyr = @Fiscyr
                     AND P.Fiscyr = @PrevFiscYr
		     AND V.SiteID in (SELECT SiteID FROM SITE WHERE CpnyID = @CpnyID)

            SELECT @ErrFlag = @@ERROR, @ErrChkPt = '[09] ' + @ErrChkPt
            IF @ErrFlag <> 0 GOTO Abort

            PRINT 'Set Beginning Balance for ItemBMIHist Complete'

            SELECT @FiscYr = LTRIM(STR(CONVERT(INT, @FiscYr) + 1))
    END

Complete:
    COMMIT TRANSACTION
    GOTO Finish
Abort:
    ROLLBACK TRANSACTION
    EXEC ProcErrLog_Ins @ProgID, @UserID, @ErrChkPt, @ErrFlag
    RETURN @ErrFlag
Finish:
    EXEC ProcErrLog_Del @ProgID, @UserID
    RETURN 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_10990_ProcessItemHist] TO [MSDSL]
    AS [dbo];


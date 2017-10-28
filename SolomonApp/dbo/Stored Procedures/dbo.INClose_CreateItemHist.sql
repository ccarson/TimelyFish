 CREATE PROCEDURE INClose_CreateItemHist @FiscYr as varchar (4), @ProgID as varchar(8), @userID as varchar (10)
AS

	DECLARE @PrevFiscYr     VARCHAR (4)
    	DECLARE @PerNbr         VARCHAR (6)
		SELECT 	@PrevFiscYr = LTRIM(STR(CONVERT(INT,@FiscYr) - 1))

	-- Insert any ItemHist records for each InvtID / SiteID combination for
	-- the current fiscal year if it is missing.
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
                         CASE WHEN P.BegBal Is NULL Or I.ValMthd = 'U' Or I.StkItem = 0
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
                         GetDate(), @ProgId, @UserId, @FiscYr, S.InvtId,
                         GetDate(), @ProgId, @UserId, 0, @FiscYr+'01',
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
                         S.SiteId, '', '', 0, 0, '', '', '', '',
                         0, 0, 0, 0, 0, 0, 0

                         FROM ItemSite S LEFT OUTER JOIN ItemHist H
                                                        ON S.InvtId = H.InvtId
                                                        AND S.SiteId = H.SiteId
                                                        AND @FiscYr = H.FiscYr
                                         LEFT OUTER JOIN ItemHist P
                                                        ON S.InvtId = P.InvtId
                                                        AND S.SiteId = P.SiteId
                                                        AND @PrevFiscYr = P.FiscYr
                                         JOIN Inventory I
                                                        ON S.InvtId = I.InvtId
            	         WHERE H.InvtId Is NULL

	-- Insert any Item2Hist records for each InvtID / SiteID combination for
	-- the current fiscal year if it is missing.
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
                         CASE WHEN P.BegQty Is NULL Or I.StkItem = 0
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
                         GetDate(), @ProgId, @UserId, @FiscYr, S.InvtId,
                         GetDate(), @ProgId, @UserId,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                         '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
                         S.SiteId, '', '', 0, 0, '', '', '', '',
                         0, 0, 0, 0, 0, 0
                         FROM ItemSite S LEFT OUTER JOIN Item2Hist H
                                                        ON S.InvtId = H.InvtId
                                                        AND S.SiteId = H.SiteId
                                                        AND @FiscYr = H.FiscYr
                                         LEFT OUTER JOIN Item2Hist P
                                                        ON S.InvtId = P.InvtId
                                                        AND S.SiteId = P.SiteId
                                                        AND @PrevFiscYr = P.FiscYr
					JOIN Inventory I
                                                            ON S.InvtId = I.InvtId
                          WHERE  H.InvtId Is NULL

	-- Insert any ItemBMIHist records for each InvtID / SiteID combination for
	-- the current fiscal year if it is missing.
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
                          CASE WHEN P.BMIBegBal Is NULL Or I.ValMthd = 'U' Or I.StkItem = 0
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
                          GetDate(), @ProgId, @UserId, @FiscYr, S.InvtId,
                          GetDate(), @ProgId, @UserId,
                          '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
                          S.SiteId, '', '', 0, 0, '', '', '', ''
                          FROM ItemSite S LEFT OUTER JOIN ItemBMIHist H
                                                              ON S.InvtId = H.InvtId
                                                              AND S.SiteId = H.SiteId
                                                              AND @FiscYr = H.FiscYr
                                          LEFT OUTER JOIN ItemBMIHist P
                                                              ON S.InvtId = P.InvtId
                                                              AND S.SiteId = P.SiteId
                                                              AND @PrevFiscYr = P.FiscYr
                                          JOIN Inventory I
                                                            ON S.InvtId = I.InvtId

                          WHERE H.InvtId Is NULL



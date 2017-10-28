 Create Proc DMG_10400_UpdateARCOGS

            @UserAddress VARCHAR (21),
            @ProgId      VARCHAR (8),
            @UserId      VARCHAR (10)
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
		@Err_S4Future01		= 'DMG_10400_UpdateARCOGS',
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

    DECLARE @P_Error     	 VARCHAR(1)
    DECLARE @DecPlPrcCst         Int
    DECLARE @FirstFiscYr     	 CHAR(4)
    DECLARE @FiscYr     	 CHAR(4)
    DECLARE @INSetup_FiscYr  	 CHAR(4)
    DECLARE @INTran_FirstFiscYr  CHAR(4)
    DECLARE @INTran_LastFiscYr	 CHAR(4)
    DECLARE @ItemHist_LastFiscYr CHAR(4)
    DECLARE @LastFiscYr      	 CHAR(4)
    DECLARE @PerNbr          	 CHAR(6)
    DECLARE @PrevFiscYr     	 CHAR(4)

    SELECT @P_Error         = ' '

    Select @DecPlPrcCst = DecPlPrcCst,
           @PerNbr = PerNbr,
           @INSetup_FiscYr = (SUBSTRING(PerNbr, 1, 4))
           From INSetup (NoLock)

    Select @INTran_FirstFiscYr = Min(FiscYr),
           @INTran_LastFiscYr = Max(FiscYr)
           From vp_10400_UpdateItemHist_INTran
           Where UserAddress = @UserAddress

    Select @FirstFiscYr = @InTran_FirstFiscYr
    Select @LastFiscYr = @InTran_LastFiscYr

    Create Table #TimeRange (
                 FiscYr          Char(4),
                 PrevFiscYr      Char(4),
                 Id              Char(1))

    If @INSetup_FiscYr > @LastFiscYr
        Select @LastFiscYr = @INSetup_FiscYr

    If @INSetup_FiscYr < @FirstFiscYr
        Select @FirstFiscYr = @INSetup_FiscYr

    Select @FiscYr = @FirstFiscYr
    While @FiscYr <= @LastFiscYr
	Begin
   	    Select @PrevFiscYr = LTRIM(STR(CONVERT(INT,@FiscYr) - 1))
            Insert #TimeRange (FiscYr, PrevFiscYr, Id)
                   Values(@FiscYr, @PrevFiscYr, '')
            Select @FiscYr = LTRIM(STR(CONVERT(INT,@FiscYr) + 1))
        End

    INSERT ARHist (BegBal, CpnyId, Crtd_DateTime, Crtd_Prog, Crtd_User, CuryID, CustID,
                   FiscYr, LUpd_DateTime, LUpd_Prog, LUpd_User,
                   NbrInvcPaid00, NbrInvcPaid01, NbrInvcPaid02, NbrInvcPaid03,
                   NbrInvcPaid04, NbrInvcPaid05, NbrInvcPaid06, NbrInvcPaid07,
                   NbrInvcPaid08, NbrInvcPaid09, NbrInvcPaid10, NbrInvcPaid11,
                   NbrInvcPaid12,
                   NoteId,
                   PaidInvcDays00, PaidInvcDays01, PaidInvcDays02, PaidInvcDays03,
                   PaidInvcDays04, PaidInvcDays05, PaidInvcDays06, PaidInvcDays07,
                   PaidInvcDays08, PaidInvcDays09, PaidInvcDays10, PaidInvcDays11,
                   PaidInvcDays12,
                   PerNbr,
                   PTDCOGS00, PTDCOGS01, PTDCOGS02, PTDCOGS03, PTDCOGS04, PTDCOGS05,
                   PTDCOGS06, PTDCOGS07, PTDCOGS08, PTDCOGS09, PTDCOGS10, PTDCOGS11,
                   PTDCOGS12,
                   PTDCrMemo00, PTDCrMemo01, PTDCrMemo02, PTDCrMemo03, PTDCrMemo04,
                   PTDCrMemo05, PTDCrMemo06, PTDCrMemo07, PTDCrMemo08, PTDCrMemo09,
                   PTDCrMemo10, PTDCrMemo11, PTDCrMemo12,
                   PTDDisc00, PTDDisc01, PTDDisc02, PTDDisc03, PTDDisc04, PTDDisc05,
                   PTDDisc06, PTDDisc07, PTDDisc08, PTDDisc09, PTDDisc10, PTDDisc11,
                   PTDDisc12,
                   PTDDrMemo00, PTDDrMemo01, PTDDrMemo02, PTDDrMemo03, PTDDrMemo04,
                   PTDDrMemo05, PTDDrMemo06, PTDDrMemo07, PTDDrMemo08, PTDDrMemo09,
                   PTDDrMemo10, PTDDrMemo11, PTDDrMemo12,
                   PTDFinChrg00, PTDFinChrg01, PTDFinChrg02, PTDFinChrg03, PTDFinChrg04,
                   PTDFinChrg05, PTDFinChrg06, PTDFinChrg07, PTDFinChrg08, PTDFinChrg09,
                   PTDFinChrg10, PTDFinChrg11, PTDFinChrg12,
                   PTDRcpt00, PTDRcpt01, PTDRcpt02, PTDRcpt03, PTDRcpt04, PTDRcpt05,
                   PTDRcpt06, PTDRcpt07, PTDRcpt08, PTDRcpt09, PTDRcpt10, PTDRcpt11,
                   PTDRcpt12,
                   PTDSales00, PTDSales01, PTDSales02, PTDSales03, PTDSales04,
                   PTDSales05, PTDSales06, PTDSales07, PTDSales08, PTDSales09,
                   PTDSales10, PTDSales11, PTDSales12,
                   S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                   S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                   User1, User2, User3, User4, User5, User6, User7, User8,
                   YTDCOGS, YtdCrMemo, YtdDisc, YtdDrMemo, YtdFinChrg, YtdRcpt, YtdSales)
           SELECT DISTINCT
                  -- BegBal and CuryId Calculations
                  CASE WHEN P.BegBal Is NULL
                            THEN 0
                            ELSE (P.BegBal
                                  + P.YtdSales + P.YtdDrMemo + P.YtdFinChrg
                                  - (P.YtdRcpt + P.YtdCrMemo + P.YtdDisc))
                            END,
                  V.CpnyId, GetDate(), @ProgId, @UserId, C.CuryId,
                  V.Id, R.FiscYr, GetDate(), @ProgId, @UserId,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  @PerNbr,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                  '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
                  '', '', 0, 0, '', '', '', '',
                  0, 0, 0, 0, 0, 0, 0
                  FROM #TimeRange r Join vp_10400_UpdateARCOGS_CustId V
                                    On R.Id = ''
                                    Join Customer C (NoLock)
                                    On V.Id = C.CustId
                                    Left Outer Join ARHist H
                                    On V.Id = H.CustId
                                    And V.CpnyId = H.CpnyId
                                    And R.FiscYr = H.FiscYr
                                    Left Outer Join ARHist P
                                    On V.Id = P.CustId
                                    And V.CpnyId = H.CpnyId
                                 And R.FiscYr = P.FiscYr
                  WHERE V.UserAddress = @UserAddress
                    And H.CustId IS NULL

    SELECT @Err_SQLErrorNbr = @@ERROR
    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
    PRINT 'Create ARHist Records Complete'

 /* Remove Insert from this procedure and do in SCM_Insert_SlsPerHist.sql
    INSERT SlsPerHist (Crtd_DateTime, Crtd_Prog, Crtd_User, FiscYr,
                       LUpd_DateTime, LUpd_Prog, LUpd_User, NoteId, PerNbr,
                       PTDCOGS00, PTDCOGS01, PTDCOGS02, PTDCOGS03, PTDCOGS04, PTDCOGS05,
                       PTDCOGS06, PTDCOGS07, PTDCOGS08, PTDCOGS09, PTDCOGS10, PTDCOGS11,
                       PTDCOGS12,
                       PTDRcpt00, PTDRcpt01, PTDRcpt02, PTDRcpt03, PTDRcpt04, PTDRcpt05,
                       PTDRcpt06, PTDRcpt07, PTDRcpt08, PTDRcpt09, PTDRcpt10, PTDRcpt11,
                       PTDRcpt12,
                       PTDSls00, PTDSls01, PTDSls02, PTDSls03, PTDSls04, PTDSls05,
                       PTDSls06, PTDSls07, PTDSls08, PTDSls09, PTDSls10, PTDSls11,
                       PTDSls12,
                       S4Future01, S4Future02, S4Future03, S4Future04, S4Future05, S4Future06,
                       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, S4Future12,
                       SlsperId,
                       User1, User2, User3, User4, User5, User6, User7, User8,
                       YTDCOGS, YtdRcpt, YtdSls)
           SELECT DISTINCT GetDate(), @ProgId, @UserId, R.FiscYr,
                           GetDate(), @ProgId, @UserId, 0, @PerNbr,
                           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                           0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                           '', '', 0, 0, 0, 0, '', '', 0, 0, '', '',
                           V.SlsperId,
                           '', '', 0, 0, '', '', '', '',
                           0, 0, 0
                  FROM #TimeRange r Join vp_10400_UpdateARCOGS_SlsPerId V
                                    On R.Id = ''
                                    Left Outer Join SlsPerHist H
                                    On V.SlsPerId = H.SlsPerId
                                    And R.FiscYr = H.FiscYr
                                    Left Outer Join SlsPerHist P
                                    On V.SlsPerId = P.SlsPerId
                                    And R.FiscYr = P.FiscYr
                  WHERE V.UserAddress = @UserAddress
                    And H.SlsPerId IS NULL

    SELECT @Err_SQLErrorNbr = @@ERROR
    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
    PRINT 'Create SlsPerHist Records Complete'
*/

    DROP TABLE #TimeRange

    /***** Update ARTran *****/
    UPDATE A
           SET ExtCost = T.ExtCost,
               LUpd_DateTime = GetDate(),
               LUpd_Prog = @ProgId,
               LUpd_User = @UserId
           FROM vp_10400_UpdateARCOGS_ARTran T, ARTran A with(INDEX(ARTRAN3))
           WHERE T.UserAddress = @UserAddress
             And T.Id = A.CustId
             And T.RefNbr = A.RefNbr
             And T.ARLineId = A.LineId

    SELECT @Err_SQLErrorNbr = @@ERROR
    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
    PRINT 'Update ARTran Complete'

    /***** Update ARHist *****/
     UPDATE ARHist
           SET PTDCOGS00 = h.PTDCOGS00 + v.PTDCOGS00,
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
               YTDCOGS = h.YTDCOGS + v.YTDCOGS
           FROM ARHist h, vp_10400_UpdateARCOGS_CustId v
           WHERE h.FiscYr = v.FiscYr
             AND h.CustId = v.Id
             AND h.CpnyId = v.CpnyId

    SELECT @Err_SQLErrorNbr = @@ERROR
    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
    PRINT 'Update ARHist Complete'

 /* Remove update from this procedure and do in SCM_10400_Upd_SlsPerHist.sql
   **** Update SlsperHist ****

    UPDATE SlsperHist
           SET PTDCOGS00 = h.PTDCOGS00 + v.PTDCOGS00,
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
               YTDCOGS = h.YTDCOGS + v.YTDCOGS,
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
               YTDSls = h.YTDSls + v.YTDSls
          FROM SlsPerHist h, vp_10400_UpdateARCOGS_SlsPerId v
          WHERE h.FiscYr = v.FiscYr
            AND h.SlsPerId = v.SlsPerId

    SELECT @Err_SQLErrorNbr = @@ERROR
    IF @Err_SQLErrorNbr <> 0 GOTO ABORT
    PRINT 'Update SlsperHist Complete'
**** Update SlsperHist ****
*/

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
    ON OBJECT::[dbo].[DMG_10400_UpdateARCOGS] TO [MSDSL]
    AS [dbo];


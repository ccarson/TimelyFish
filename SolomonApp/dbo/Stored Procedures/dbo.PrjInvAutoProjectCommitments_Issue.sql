 Create PROCEDURE PrjInvAutoProjectCommitments_Issue
   @RefNbr                VARCHAR(10),    -- RefNbr Number to work on
   @IssueRefNbr           VARCHAR(15),    -- Issue Number to work on
   @RcptType              VARCHAR(14),     -- Receipt or Return
   @CurrentPJFiscalPeriod VARCHAR(6),     -- Project Current Fiscal Period
   @Prog                  CHAR(5),        -- bpes screen
   @User                  VARCHAR(10)     -- left 10 chars of bpes userid
 AS

 IF @IssueRefNbr = 'Empty'
	SET @IssueRefNbr = ''

-- =======================================================================================================
-- PrjInvAUTOPROJECTCOMMITMENTS.crp
-- Update Project commitments for project allocated inventory that's added, updated, or deleted

-- Developed to be called from 10400

-- =======================================================================================================

SET NOCOUNT ON

-- This temporary work table is used to store messages to pass back to the app
--   MsgType: P = Invalid Project
--            T = Invalid Task
--            A - Invalid Project Account
CREATE TABLE #PrjInvWrkMessages
 ( Acct        VARCHAR(16)
 , LineRef     CHAR(5)
 , MsgType     CHAR(1)
 , ProjectID   VARCHAR(16)
 , TaskID      VARCHAR(32)
 , ProjCury    CHAR(4)
 )

-- Get some gl setup info needed for calculations
DECLARE	@BaseDecimalPlaces INT
      , @BaseCuryID        CHAR(10)
SELECT  @BaseCuryID         = GLSetup.BaseCuryID,
        @BaseDecimalPlaces  = Currncy.DecPl
 FROM GLSetup WITH (NOLOCK)
  INNER JOIN Currncy WITH (NOLOCK)
   ON Currncy.CuryID = GLSetup.BaseCuryID
IF @@Error <> 0 GOTO END_PROCEDURE

-- Used for cursor data when updating summary tables
DECLARE @Project		VARCHAR(16)
      , @Task			VARCHAR(32)
      , @Acct			VARCHAR(16)
      , @Amount			FLOAT
	  , @ProjCuryAmount FLOAT
	  , @ProjCuryPrec	INT
      , @Units			FLOAT
      , @SQL			VARCHAR(2000)
      , @StmtType		CHAR(1)

-- This Temporary work table stores PJComDet records needed to do the updates
--    Work types are [I=Insert, U=Update, O=Original, D=Delete]
--    Use various SUMs of this table to update PJPTDSUM, PJPTDROL, PJCOMSUM, & PJCOMROL
--    There will be a 1:1 correspondance for U and O work types (unless validation fails for a U type)
--        we need the delta of these for the summary updates
--    For PJCOMDET:
--        I types will get inserted
--        U types will update the existing records (the source of the O types)
--        D types will get deleted
CREATE TABLE #PrjInvWrkPJComDet
 ( WrkTranType        CHAR(1)       --I=Insert, U=Update, O=Original, D=Delete
 , acct	              VARCHAR(16) NULL
 , amount             FLOAT
 , batch_type         CHAR(4)
 , cd_id05            CHAR(4)
 , CuryId             CHAR(4)
 , CuryMultDiv        CHAR(1)
 , CuryRate           FLOAT
 , CuryTranAmt        FLOAT
 , gl_acct            VARCHAR(10)
 , gl_subacct         VARCHAR(24)
 , LineRef            CHAR(5)
 , part_number        VARCHAR(24)
 , pjt_entity         VARCHAR(32)
 , ProjCury_amount	  FLOAT
 , ProjCuryEffDate	  SMALLDATETIME
 , ProjCuryId		  CHAR(4)
 , ProjCuryMultiDiv	  CHAR(1)
 , ProjCuryRate		  FLOAT
 , ProjCuryRateType	  CHAR(6)
 , project            VARCHAR(16)
 , promise_date       SMALLDATETIME
 , request_date       SMALLDATETIME
 , tr_comment         VARCHAR(30)
 , units              FLOAT
 , unit_of_measure    VARCHAR(10)
 , user1              VARCHAR(30)
 , user2              VARCHAR(30)
 , user3              FLOAT
 , user4              FLOAT
 , RcptNbr            VARCHAR(15)
 , RefNbr             VARCHAR(10)
 , RcptLineRef        VARCHAR(5)
 , SrcDate            SMALLDATETIME
 , CpnyID             VARCHAR(10)
 )

IF @RcptType = 'ReturnFromProj'   --Receipt or a purchase order
BEGIN
     -- Load the insert and update records for Project Inventory that are from Receipts of Purchase Orders
     --   Do as many conversions and formulas as possible now
     INSERT INTO #PrjInvWrkPJComDet
      ( WrkTranType, acct, amount, batch_type, cd_id05
      , CuryId, CuryMultDiv, CuryRate, CuryTranAmt
      , gl_acct, gl_subacct, LineRef, part_number
      , pjt_entity, ProjCury_amount, ProjCuryEffDate
	  , ProjCuryId, ProjCuryMultiDiv, ProjCuryRate
      , ProjCuryRateType, project, promise_date, request_date
      , tr_comment, units, unit_of_measure
      , user1, user2, user3, user4
      , RcptNbr, RefNbr, RcptLineRef, SrcDate, CpnyID
      )
      SELECT 'I', p.acct, ROUND(i.UnitCost * i.QtyRemainToIssue, @BaseDecimalPlaces), 'PI', ' ' 
           , @BaseCuryID, 'M', 1, ROUND(i.UnitCost * i.QtyRemainToIssue, @BaseDecimalPlaces)
           , i.WIP_COGS_Acct, i.WIP_COGS_Sub, i.SrcLineRef, i.InvtID
           , i.TaskID, 0, GETDATE(), SPACE(0), SPACE(0), 1, SPACE(0), i.ProjectID, ' ', ' '
           , RTrim(i.SiteId) + '-' + RTrim(i.Whseloc), i.QtyRemainToIssue, i.UnitDesc
           , i.User1, i.User2, i.User3, i.User4
           , '', i.SrcNbr, i.SrcLineRef, i.srcdate, i.CpnyID
       FROM InvProjAlloc i WITH (NOLOCK) LEFT OUTER JOIN PJ_Account p WITH (NOLOCK)
                           ON p.gl_acct = i.WIP_COGS_Acct
                          AND i.SrcType IN ('RFI','PIA')  --Scott Change this it was just RFI
                         LEFT OUTER JOIN PJCOMDET d WITH (NOLOCK)
                           ON d.projinv_referenc_num = i.SrcNbr
                          AND d.projinv_lineref = i.SrcLineRef
                          AND d.system_cd = 'IN'
                          AND d.batch_type = 'PI'
      WHERE i.SrcNbr = @RefNbr
        AND d.Batch_ID IS NULL

     IF @@Error <> 0 GOTO END_PROCEDURE


	 Update #PrjInvWrkPJComDet set
	 ProjCuryEffDate = Case when c.CuryId = @BaseCuryID Then pc.SrcDate else CuryRateTbl.EffDate end
   , ProjCuryId = p.ProjCuryId
   , ProjCuryMultiDiv = 'M'
   , ProjCuryRateType =  p.ProjCuryRateType
   , ProjCury_amount = Case when c.CuryId = @BaseCuryID then pc.amount else Case when CuryRateTbl.MultDiv = 'M' then ROUND(amount * CuryRateTbl.Rate, c.decpl)
	 ELSE ROUND(amount / CuryRateTbl.Rate, c.decpl)end end
    , ProjCuryRate = Case when c.CuryId = @BaseCuryID then 1 else Round(Amount / Case when CuryRateTbl.MultDiv = 'M' then ROUND(amount * CuryRateTbl.Rate, c.decpl)
	 ELSE ROUND(amount / CuryRateTbl.Rate, c.decpl)end, 9) END
	From #PrjInvWrkPJComDet pc
	Inner Join PJPROJ p
	ON pc.project = p.project
	Inner Join Currncy c
	ON p.ProjCuryId = c.CuryId
	OUTER Apply dbo.CuryRateTbl(@BaseCuryID, p.ProjCuryId, p.ProjCuryRateType, pc.SrcDate) CuryRateTbl
	

      -- VALIDATION
      -- Check that project exists 
      INSERT INTO #PrjInvWrkMessages (Acct, LineRef, MsgType, ProjectID, TaskID)
      SELECT #PrjInvWrkPJComDet.acct , #PrjInvWrkPJComDet.LineRef, 'P', #PrjInvWrkPJComDet.project, #PrjInvWrkPJComDet.pjt_entity
        FROM #PrjInvWrkPJComDet LEFT OUTER JOIN PJPROJ WITH (NOLOCK)
                                  ON PJPROJ.project = #PrjInvWrkPJComDet.project
       WHERE PJPROJ.project IS NULL
     
      DELETE #PrjInvWrkPJComDet
        FROM #PrjInvWrkPJComDet LEFT OUTER JOIN PJPROJ WITH (NOLOCK)
                                ON PJPROJ.project = #PrjInvWrkPJComDet.project
       WHERE PJPROJ.project IS NULL

      -- Check that Task exists 
      INSERT INTO #PrjInvWrkMessages (Acct, LineRef, MsgType, ProjectID, TaskID)
      SELECT #PrjInvWrkPJComDet.acct, #PrjInvWrkPJComDet.LineRef, 'T', #PrjInvWrkPJComDet.project, #PrjInvWrkPJComDet.pjt_entity
        FROM #PrjInvWrkPJComDet LEFT OUTER JOIN PJPENT WITH (NOLOCK)
                                  ON PJPENT.project = #PrjInvWrkPJComDet.project
                                 AND PJPENT.pjt_entity = #PrjInvWrkPJComDet.pjt_entity
       WHERE PJPENT.pjt_entity IS NULL

      DELETE #PrjInvWrkPJComDet
        FROM #PrjInvWrkPJComDet LEFT OUTER JOIN PJPENT WITH (NOLOCK)
                                  ON PJPENT.project = #PrjInvWrkPJComDet.project
                                 AND PJPENT.pjt_entity = #PrjInvWrkPJComDet.pjt_entity
       WHERE PJPENT.pjt_entity IS NULL

      -- Check that Category exists 
      INSERT INTO #PrjInvWrkMessages (Acct, LineRef, MsgType, ProjectID, TaskID)
      SELECT #PrjInvWrkPJComDet.acct, #PrjInvWrkPJComDet.LineRef, 'A', #PrjInvWrkPJComDet.project, #PrjInvWrkPJComDet.pjt_entity
        FROM #PrjInvWrkPJComDet LEFT OUTER JOIN PJACCT WITH (NOLOCK)
                                  ON PJACCT.acct = #PrjInvWrkPJComDet.acct
       WHERE PJACCT.acct IS NULL

      DELETE #PrjInvWrkPJComDet
        FROM #PrjInvWrkPJComDet LEFT OUTER JOIN PJACCT WITH (NOLOCK)
                                ON PJACCT.acct = #PrjInvWrkPJComDet.acct
       WHERE PJACCT.acct IS NULL
END 

  --Need to validate Transactions for valid currency rates
  INSERT INTO #PrjInvWrkMessages (Acct, LineRef, MsgType, ProjectID, TaskID, ProjCury)
     Select '','','C', c.project, '', c.ProjCuryId
	from #PrjInvWrkPJComDet c
	OUTER Apply dbo.CuryRateTbl(@BaseCuryID, c.ProjCuryId, c.ProjCuryRateType, c.SrcDate) 
	Where (c.ProjCuryId <> @BaseCuryID) and FromCuryId is null
	 group by c.project, c.CuryId, c.ProjCuryId

	 Delete #PrjInvWrkPJComDet 
	 	from #PrjInvWrkPJComDet c
	OUTER Apply dbo.CuryRateTbl(@BaseCuryID, c.ProjCuryId, c.ProjCuryRateType, c.SrcDate) 
	Where (c.ProjCuryId <> @BaseCuryID) and FromCuryId is null


IF @RcptType = 'IssueToProject'   --Issue Project Inventory to Project
BEGIN

     /************************************************************************************************************/
     --This handle the consumtion or unallocation of Project Inventory that was allocated in the Receipt Invoice/Entry screen
     --     for Goods for Project Inventory, or Goods for Project Sales Order
     /************************************************************************************************************/

     -- Now load the original and delete records
     INSERT INTO #PrjInvWrkPJComDet
      ( WrkTranType, acct, amount
      , batch_type, cd_id05, CuryId, CuryMultDiv, CuryRate
      , CuryTranAmt
      , gl_acct, gl_subacct, LineRef, part_number
      , pjt_entity, ProjCury_amount, ProjCuryEffDate
	  , ProjCuryId, ProjCuryMultiDiv, ProjCuryRate
      , ProjCuryRateType, project, promise_date, request_date
      , tr_comment
      , units, unit_of_measure
      , user1, user2, user3, user4
      , RcptNbr, RefNbr, RcptLineRef, CpnyID
      )
      SELECT CASE WHEN i.SrcNbr IS NULL 
                    THEN 'D' 
                  ELSE 'U' END
            , p.acct
            , CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                   ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END
            , p.batch_type, p.cd_id05, p.CuryId, p.CuryMultDiv, p.CuryRate
            , CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                  ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END
            , p.gl_acct, p.gl_subacct, p.projinv_lineref, p.part_number
            , p.pjt_entity,  
			Case when p.ProjCuryId = @BaseCuryID then (CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                   ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END) ELSE 
				   CASE when CuryRateTbl.MultDiv = 'M' Then round(CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                   ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END * curyratetbl.multdiv, c.DecPl) ELSE
				   round(CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                   ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END / curyratetbl.multdiv, c.DecPl) END END
			, Case when c.CuryId = @BaseCuryID Then i.SrcDate else CuryRateTbl.EffDate end, 
			p.ProjCuryId, 
			Case when c.CuryId = @BaseCuryID then 'M' else CuryRateTbl.MultDiv end , Case when c.CuryId = @BaseCuryID then 1 else CuryRateTbl.Rate end 
			, Case when c.CuryId = @BaseCuryID then space(0) else CuryRateTbl.RateType end,
			 p.project, p.promise_date, p.request_date, p.tr_comment
            , CASE WHEN i.SrcNbr IS NULL 
                     THEN (p.units * -1)
                   ELSE h.Quantity END, p.unit_of_measure
            , p.user1, p.user2, p.user3, p.user4 
            , p.projinv_receipt_num, p.projinv_referenc_num, projinv_lineref, p.CpnyID
       FROM PJComDet p WITH (NOLOCK) INNER JOIN Currncy r WITH (NOLOCK)
                                        ON r.CuryID = p.CuryID
                                      LEFT OUTER JOIN InvProjAlloc i WITH (NOLOCK)
                                        ON p.projinv_receipt_num = i.SrcNbr
                                       AND p.projinv_lineref = i.SrcLineRef
                                       AND i.SrcType IN ('POR','PRR','GSO')
                                      JOIN InprjAllocTranHist h WITH (NOLOCK)
                                        ON p.projinv_receipt_num = h.SrcNbr
                                       AND p.projinv_lineref = h.SrcLineRef
                                       AND h.TranSrcType IN ('ISS','UPA')
                                      JOIN InPrjAllocHistory y
                                        ON y.SrcNbr = h.SrcNbr
                                       AND y.SrcLineRef = h.SrcLineRef
                                       AND y.SrcType = h.SrcType
									   Join Currncy c
										ON p.ProjCuryId = c.CuryId
										OUTER Apply dbo.CuryRateTbl(p.CuryId, p.ProjCuryId, p.ProjCuryRateType, i.SrcDate) CuryRateTbl
      WHERE h.TranSrcNbr = @ISSUERefNbr 
        AND h.SrcNbr = @RefNbr  
        AND h.TranSrcType IN ('ISS','UPA')
        AND h.PC_Status = '1'
        AND p.System_Cd = 'IN'
     
     IF @@Error <> 0 GOTO END_PROCEDURE

     /************************************************************************************************************/
     --This handle the consumtion or unallocation of Project Inventory that was allocated in the Project Inventory
     --     screen or a return back to project inventory from the issue screen.
     /************************************************************************************************************/

     INSERT INTO #PrjInvWrkPJComDet
      ( WrkTranType, acct, amount
      , batch_type, cd_id05, CuryId, CuryMultDiv, CuryRate
      , CuryTranAmt
      , gl_acct, gl_subacct, LineRef, part_number
      , pjt_entity, ProjCury_amount, ProjCuryEffDate
	  , ProjCuryId, ProjCuryMultiDiv, ProjCuryRate
      , ProjCuryRateType, project, promise_date, request_date
      , tr_comment
      , units, unit_of_measure
      , user1, user2, user3, user4
      , RcptNbr, RefNbr, RcptLineRef, CpnyID
      )
      SELECT CASE WHEN i.SrcNbr IS NULL 
                    THEN 'D' 
                  ELSE 'U' END
            , p.acct
            , CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                   ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END
            , p.batch_type, p.cd_id05, p.CuryId, p.CuryMultDiv, p.CuryRate
            , CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                  ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END
            , p.gl_acct, p.gl_subacct, p.projinv_lineref, p.part_number
            , p.pjt_entity,  
			Case when p.ProjCuryId = @BaseCuryID then (CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                   ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END) ELSE 
				   CASE when CuryRateTbl.MultDiv = 'M' Then round(CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                   ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END * curyratetbl.multdiv, c.DecPl) ELSE
				   round(CASE WHEN i.SrcNbr IS NULL 
                     THEN ROUND((p.amount * -1), @BaseDecimalPlaces)
                   ELSE ROUND(h.Quantity * y.unitcost, @BaseDecimalPlaces) END / curyratetbl.multdiv, c.DecPl) END END

			, Case when c.CuryId = @BaseCuryID Then i.SrcDate else CuryRateTbl.EffDate end, 
			p.ProjCuryId, 
			Case when c.CuryId = @BaseCuryID then 'M' else CuryRateTbl.MultDiv end , Case when c.CuryId = @BaseCuryID then 1 else CuryRateTbl.Rate end 
			, Case when c.CuryId = @BaseCuryID then space(0) else CuryRateTbl.RateType end,
			 p.project, p.promise_date, p.request_date, p.tr_comment
            , CASE WHEN i.SrcNbr IS NULL 
                     THEN (p.units * -1)
                   ELSE h.Quantity END, p.unit_of_measure
            , p.user1, p.user2, p.user3, p.user4 
            , p.projinv_receipt_num, p.projinv_referenc_num, projinv_lineref, p.CpnyID
       FROM PJComDet p WITH (NOLOCK) INNER JOIN Currncy r WITH (NOLOCK)
                                        ON r.CuryID = p.CuryID
                                      LEFT OUTER JOIN InvProjAlloc i WITH (NOLOCK)
                                        ON p.projinv_referenc_num = i.SrcNbr
                                       AND p.projinv_lineref = i.SrcLineRef
                                       AND i.SrcType IN ('PIA','RFI')
                                      JOIN InprjAllocTranHist h WITH (NOLOCK)
                                        ON p.projinv_referenc_num = h.SrcNbr
                                       AND p.projinv_lineref = h.SrcLineRef
                                       AND h.TranSrcType IN ('ISS','UPA')
                                      JOIN InPrjAllocHistory y
                                        ON y.SrcNbr = h.SrcNbr
                                       AND y.SrcLineRef = h.SrcLineRef
                                       AND y.SrcType = h.SrcType
                                       Join Currncy c
                                       ON p.ProjCuryId = c.CuryId
                                       OUTER Apply dbo.CuryRateTbl(p.CuryId, p.ProjCuryId, p.ProjCuryRateType, i.SrcDate) CuryRateTbl
      WHERE h.TranSrcNbr = @ISSUERefNbr 
        AND h.SrcNbr = @RefNbr  
        AND h.TranSrcType IN ('ISS','UPA') 
        AND h.PC_Status = '1'
        AND p.System_Cd = 'IN'

     IF @@Error <> 0 GOTO END_PROCEDURE

END 

-- UPDATE/INSERT SUMMARY TABLES
BEGIN TRANSACTION
-- Use cursor to group & sum the work table by project, task, and account
DECLARE Wrk_Cursor CURSOR LOCAL FAST_FORWARD
 FOR SELECT project, pjt_entity, acct, ROUND(SUM(amount), @BaseDecimalPlaces), ROUND(SUM(ProjCury_amount), Currncy.DecPl), currncy.DecPl,  SUM(units)
      FROM #PrjInvWrkPJComDet
	  Inner Join Currncy
	  ON #PrjInvWrkPJComDet.ProjCuryId = Currncy.CuryId
      GROUP BY project, pjt_entity, acct, Currncy.DecPl
      HAVING ROUND(SUM(amount), @BaseDecimalPlaces) <> 0
       OR SUM(units) <> 0
OPEN Wrk_Cursor

FETCH NEXT FROM Wrk_Cursor INTO @Project, @Task, @Acct, @Amount, @ProjCuryAmount, @ProjCuryPrec, @Units
WHILE (@@FETCH_STATUS = 0)
BEGIN
    -- Update/Insert PJPTDROL
    -- If a record exist - update it
    IF EXISTS(SELECT *
               FROM PJPTDROL
               WHERE PJPTDROL.project = @Project
                 AND PJPTDROL.acct = @Acct)
        UPDATE PJPTDROL
         SET com_amount = ROUND(com_amount + @Amount, @BaseDecimalPlaces)
           , com_units = com_units + @units
		   , ProjCury_com_amount =  ROUND(ProjCury_com_amount + @ProjCuryAmount, @ProjCuryPrec)
           , lupd_datetime = GETDATE()
           , lupd_prog = @Prog
           , lupd_user = @User
         WHERE project = @Project
          AND acct = @Acct
    ELSE -- no record so insert one
        INSERT INTO PJPTDROL
         ( acct
         , act_amount, act_units
         , com_amount
         , com_units
         , crtd_datetime
         , crtd_prog
         , crtd_user
         , data1, data2, data3, data4, data5
         , eac_amount, eac_units, fac_amount, fac_units
         , lupd_datetime
         , lupd_prog
         , lupd_user
		 , ProjCury_act_amount, ProjCury_com_amount
		 , ProjCury_eac_amount, ProjCury_fac_amount, ProjCury_rate
		 , ProjCury_tot_bud_amt
         , project
         , rate, total_budget_amount, total_budget_units
         , user1, user2, user3, user4
         )
         VALUES
         ( @Acct
         , 0, 0
         , @Amount
         , @Units
         , GETDATE()
         , @Prog
         , @User
         , '', 0, 0, 0, 0
         , 0, 0, 0, 0
         , GETDATE()
         , @Prog
         , @User
		 , 0
		 , @ProjCuryAmount
		 , 0
		 , 0
		 , 0
		 , 0
         , @Project
         , 0, 0, 0
         , '', '', 0, 0
         )
    IF @@Error <> 0 GOTO ABORT_TRAN

    -- Update/Insert PJPTDSUM
    -- If a record exist - update it
    IF EXISTS(SELECT *
               FROM PJPTDSUM
               WHERE PJPTDSUM.project = @Project
                 AND PJPTDSUM.pjt_entity = @Task
                 AND PJPTDSUM.acct = @Acct)
        UPDATE PJPTDSUM
         SET com_amount = ROUND(com_amount + @Amount, @BaseDecimalPlaces)
           , com_units = com_units + @units
		   , ProjCury_com_amount =  ROUND(ProjCury_com_amount + @ProjCuryAmount, @ProjCuryPrec)
           , lupd_datetime = GETDATE()
           , lupd_prog = @Prog
           , lupd_user = @User
         WHERE project = @Project
          AND pjt_entity = @Task
          AND acct = @Acct
    ELSE -- no record so insert one
               INSERT INTO PJPTDSUM
         ( acct
         , act_amount, act_units
         , com_amount
         , com_units
         , crtd_datetime
         , crtd_prog
         , crtd_user
         , data1, data2, data3, data4, data5
         , eac_amount, eac_units, fac_amount, fac_units
         , lupd_datetime
         , lupd_prog
         , lupd_user
         , noteid
         , pjt_entity
		 , ProjCury_act_amount
		 , ProjCury_com_amount
		 , ProjCury_eac_amount
		 , ProjCury_fac_amount
		 , ProjCury_rate
		 , ProjCury_tot_bud_amt
         , project
       , rate, total_budget_amount, total_budget_units
         , user1, user2, user3, user4
         )
         VALUES
         ( @Acct
         , 0, 0
         , @Amount
         , @Units
         , GETDATE()
         , @Prog
         , @User
         , '', 0, 0, 0, 0
         , 0, 0, 0, 0
         , GETDATE()
         , @Prog
         , @User
         , 0
         , @Task
		 , 0
		 , @ProjCuryAmount
		 , 0
		 , 0
		 , 0
		 , 0
         , @Project
         , 0, 0, 0
         , '', '', 0, 0
         )
    IF @@Error <> 0 GOTO ABORT_TRAN

    -- Update/Insert PJCOMROL
    IF EXISTS(SELECT *
               FROM PJCOMROL WITH (NOLOCK)
               WHERE PJCOMROL.project = @Project
                AND PJCOMROL.acct = @Acct
                AND PJCOMROL.fsyear_num = LEFT(@CurrentPJFiscalPeriod, 4))
        SET @StmtType = 'U'
    ELSE -- no record so insert one
        SET @StmtType = 'I'
    -- Get the sql query to run
    EXEC POAutoProjectCommitments_stmt_hlpr
         'PJCOMROL'
       , @StmtType -- 'I' for INSERT, 'U' for UPDATE
       , @CurrentPJFiscalPeriod
       , @Amount
       , @BaseDecimalPlaces
       , @Units
       , @Prog
       , @User
       , @Project
       , ''
       , @Acct
	   , @ProjCuryAmount
	   , @ProjCuryPrec
       , @SQL OUTPUT
    -- Run the statement
    EXEC (@SQL)
    IF @@Error <> 0 GOTO ABORT_TRAN

    -- Update/Insert PJCOMSUM
    IF EXISTS(SELECT *
               FROM PJCOMSUM WITH (NOLOCK)
               WHERE PJCOMSUM.project = @Project
                AND PJCOMSUM.pjt_entity = @Task
                AND PJCOMSUM.acct = @Acct
                AND PJCOMSUM.fsyear_num = LEFT(@CurrentPJFiscalPeriod, 4))
        SET @StmtType = 'U'
    ELSE -- no record so insert one
        SET @StmtType = 'I'
    -- Get the sql query to run
    EXEC POAutoProjectCommitments_stmt_hlpr
         'PJCOMSUM'
       , @StmtType -- 'I' for INSERT, 'U' for UPDATE
       , @CurrentPJFiscalPeriod
       , @Amount
       , @BaseDecimalPlaces
       , @Units
       , @Prog
       , @User
       , @Project
       , @Task
       , @Acct
	   , @ProjCuryAmount
	   , @ProjCuryPrec
       , @SQL OUTPUT
    -- Run the statement
    EXEC (@SQL)
    IF @@Error <> 0 GOTO ABORT_TRAN

    FETCH NEXT FROM Wrk_Cursor INTO @Project, @Task, @Acct, @Amount, @ProjCuryAmount, @ProjCuryPrec, @Units
END
CLOSE Wrk_Cursor
DEALLOCATE Wrk_Cursor

IF @RcptType = 'IssueToProject'   --Issue Project Inventory over to Project
BEGIN

     /************************************************************************************************************/
     --This handle the consumtion or unallocation of Project Inventory that was allocated in the Project Inventory
     --     screen or a return back to project inventory from the issue screen for PJComDet.
     /************************************************************************************************************/

     UPDATE p
        SET amount = ROUND(p.amount + w.amount, @BaseDecimalPlaces),
            CuryTranamt = ROUND(p.CuryTranAmt + w.CuryTranAmt, @BaseDecimalPlaces),
            fiscalno = @CurrentPJFiscalPeriod,
            lupd_datetime = GETDATE(),
            lupd_prog = @Prog,
            lupd_user = @User,
			ProjCury_amount = ROUND(p.ProjCury_amount + w.ProjCury_amount, c.DecPl),
            units = p.Units + w.units
       FROM PJCOMDET p INNER JOIN #PrjInvWrkPJComDet w
                          ON w.RcptNbr = p.projinv_receipt_num
                         AND w.RcptLineRef = p.projinv_lineref
                         AND w.WrkTranType = 'U'
                       INNER JOIN  InprjAllocTranHist h
                          ON p.projinv_receipt_num = h.SrcNbr
                         AND p.projinv_lineref = h.SrcLineRef
                         AND h.SrcType IN ('POR','PRR','GSO') 
                         AND h.TranSrcType IN ('ISS','UPA')
						INNER JOIN Currncy c
					      ON w.ProjCuryId = c.CuryId 
      WHERE h.SrcNbr = @RefNbr 
        AND h.TranSrcNbr = @IssueRefNbr 
        AND h.PC_Status = '1'
        AND h.TranSrcType IN ('ISS','UPA')
      IF @@Error <> 0 GOTO ABORT_TRAN

     DELETE PJCOMDET
       FROM PJCOMDET p LEFT OUTER JOIN #PrjInvWrkPJComDet w
                         ON w.RcptNbr = p.projinv_receipt_num
                        AND w.RcptLineRef = p.projinv_lineref
                        AND w.WrkTranType = 'D'
                       INNER JOIN  InprjAllocTranHist h
                          ON p.projinv_receipt_num = h.SrcNbr
                         AND p.projinv_lineref = h.SrcLineRef
                         AND h.SrcType IN ('POR','PRR','GSO') 
      WHERE h.TranSrcNbr = @IssueRefNbr 
        AND h.SrcNbr = @RefNbr
        AND (w.Rcptlineref IS NOT NULL -- Found one marked for delete
             OR (p.amount = 0                 -- Or an insert or update left one with zero amount and units
            AND p.units = 0))
      IF @@Error <> 0 GOTO ABORT_TRAN

     UPDATE i
        SET PC_STATUS = '2'
       FROM InPrjAllocTranHist i JOIN #PrjInvWrkPJComDet p
                                     ON i.SrcNbr = p.RcptNbr
                                    AND i.SrcLineRef = p.RcptLineRef
                                    AND i.SrcType IN ('POR','PRR','GSO') 
      WHERE i.TranSrcNbr = @IssueRefNbr
        AND i.SrcNbr = @RefNbr
        AND i.PC_Status = '1'
        AND i.TranSrcType IN ('ISS','UPA')
      IF @@Error <> 0 GOTO ABORT_TRAN

     /************************************************************************************************************/
     --This handle the consumtion or unallocation of Project Inventory that was allocated in the Receipt Invoice/Entry screen
     --     for Goods for Project Inventory, or Goods for Project Sales Order
     /************************************************************************************************************/
     UPDATE p
        SET amount = ROUND(p.amount + w.amount, @BaseDecimalPlaces),
            CuryTranamt = ROUND(p.CuryTranAmt + w.CuryTranAmt, @BaseDecimalPlaces),
            fiscalno = @CurrentPJFiscalPeriod,
            lupd_datetime = GETDATE(),
            lupd_prog = @Prog,
            lupd_user = @User,
			ProjCury_amount = ROUND(p.ProjCury_amount + w.ProjCury_amount, c.DecPl),
            units = p.Units + w.units
       FROM PJCOMDET p INNER JOIN #PrjInvWrkPJComDet w
                          ON w.RcptNbr = p.projinv_receipt_num
                         AND w.RcptLineRef = p.projinv_lineref
                         AND w.WrkTranType = 'U'
                       INNER JOIN  InprjAllocTranHist h
                          ON p.projinv_referenc_num = h.SrcNbr
                         AND p.projinv_lineref = h.SrcLineRef
                         AND h.SrcType IN ('PIA','RFI') 
                         AND h.TranSrcType IN ('ISS','UPA')
                       INNER JOIN Currncy c 
						ON p.ProjCuryId = c.CuryId  
      WHERE h.SrcNbr = @RefNbr 
        AND h.TranSrcNbr = @IssueRefNbr 
        AND h.PC_Status = '1'
        AND h.TranSrcType IN ('ISS','UPA')
      IF @@Error <> 0 GOTO ABORT_TRAN

     DELETE PJCOMDET
       FROM PJCOMDET p LEFT OUTER JOIN #PrjInvWrkPJComDet w
                         ON w.RefNbr = p.projinv_referenc_num
                        AND w.RcptLineRef = p.projinv_lineref
                        AND w.WrkTranType = 'D'
                       INNER JOIN  InprjAllocTranHist h
                          ON p.projinv_referenc_num = h.SrcNbr
                         AND p.projinv_lineref = h.SrcLineRef
                         AND h.SrcType IN ('PIA','RFI') 
      WHERE h.TranSrcNbr = @IssueRefNbr 
        AND h.SrcNbr = @RefNbr
        AND (w.Rcptlineref IS NOT NULL -- Found one marked for delete
             OR (p.amount = 0                 -- Or an insert or update left one with zero amount and units
            AND p.units = 0))
      IF @@Error <> 0 GOTO ABORT_TRAN


     --Update all Project Inventory that was just processed and set the status to 2.
     UPDATE i
        SET PC_STATUS = '2'
       FROM InPrjAllocTranHist i JOIN #PrjInvWrkPJComDet p
                                     ON i.SrcNbr = p.RefNbr
                                    AND i.SrcLineRef = p.RcptLineRef
                                    AND i.SrcType IN ('PIA','RFI') 
      WHERE i.TranSrcNbr = @IssueRefNbr
        AND i.SrcNbr = @RefNbr
        AND i.PC_Status = '1'
        AND i.TranSrcType IN ('ISS','UPA')
      IF @@Error <> 0 GOTO ABORT_TRAN
END

IF @RcptType = 'ReturnFromProj'   --Return Inventory from Project back to Project Inventory
BEGIN
     -- Insert any new ones
     INSERT INTO PJCOMDET
      ( acct, amount, BaseCuryId, batch_id, batch_type,
        bill_batch_id, cd_id01, cd_id02, cd_id03, cd_id04,
        cd_id05, cd_id06, cd_id07, cd_id08, cd_id09, 
        cd_id10, cpnyId, crtd_datetime, crtd_prog, crtd_user,
        CuryEffDate, CuryId, CuryMultDiv, CuryRate, CuryRateType,
        CuryTranamt, data1, detail_num, fiscalno,
        gl_acct, gl_subacct, lupd_datetime, lupd_prog, lupd_user,
        part_number, pjt_entity, po_date, ProjCury_amount,
        ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, ProjCuryRate,
        ProjCuryRateType, project, projinv_lineref, projinv_receipt_num,
		projinv_referenc_num, promise_date, purchase_order_num,
        request_date, sub_line_item, system_cd, tr_comment, tr_status,
        units, unit_of_measure, user1, user2, user3,
        user4, vendor_num, voucher_line, voucher_num
      )
    SELECT acct, amount, @BaseCuryID, @RefNbr, 'PI',
           ' ', ' ', ' ', ' ', ' ',
           cd_id05, 0, 0, 0, 0, 
           0, CpnyID, GETDATE(), @Prog, @User,
           ' ', CuryId, CuryMultDiv, CuryRate, ' ',
           CuryTranAmt, '', RcptLineRef, @CurrentPJFiscalPeriod,
           gl_acct, gl_subacct, GETDATE(), @Prog, @User,
           part_number, pjt_entity, ' ',  ProjCury_amount,
		   ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, ProjCuryRate, ProjCuryRateType,
           project , RcptLineRef, ' ', RefNbr, ' ', ' ',
           request_date, ' ', 'IN', tr_comment, '',
           units, unit_of_measure, user1, user2, user3,
           user4, ' ', 0, ''
      FROM #PrjInvWrkPJComDet
     WHERE #PrjInvWrkPJComDet.WrkTranType = 'I'
     IF @@Error <> 0 GOTO ABORT_TRAN

     -- Delete where needed; those marked deleted and those where updates left qty and amount zero
     -- NOTE: This must come after the update and insert into PJCOMDET to clean up the table properly
    DELETE PJCOMDET
      FROM PJCOMDET LEFT OUTER JOIN #PrjInvWrkPJComDet
                      ON #PrjInvWrkPJComDet.RcptNbr = PJCOMDET.projinv_receipt_num
                     AND #PrjInvWrkPJComDet.RcptLineRef = PJCOMDET.projinv_lineref
                     AND #PrjInvWrkPJComDet.WrkTranType = 'D'
     WHERE PJCOMDET.projinv_receipt_num = @RefNbr
       AND (#PrjInvWrkPJComDet.Rcptlineref IS NOT NULL -- Found one marked for delete
            OR (PJCOMDET.amount = 0                 -- Or an insert or update left one with zero amount and units
           AND PJCOMDET.units = 0))
     IF @@Error <> 0 GOTO ABORT_TRAN

END 


COMMIT TRANSACTION
GOTO END_PROCEDURE

ABORT_TRAN:
ROLLBACK TRANSACTION

END_PROCEDURE:
-- Send any messages back to the app
SELECT *
 FROM #PrjInvWrkMessages


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PrjInvAutoProjectCommitments_Issue] TO [MSDSL]
    AS [dbo];


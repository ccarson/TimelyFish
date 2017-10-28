 CREATE PROCEDURE [dbo].[POAutoProjectCommitments]
  @PONbr                 CHAR(10)    -- PO to work on
 , @CurrentPJFiscalPeriod VARCHAR(6)  -- Project Current Fiscal Period
 , @Prog                  CHAR(5)     -- bpes screen
 , @User                  VARCHAR(10) -- left 10 chars of bpes userid
 AS
-- =======================================================================================================
-- POAutoProjectCommitments.crp
-- Update Project commitments for a specific PO that's added, updated, or deleted

-- Developed to be called from 0401000 & 0402500

-- Parameters:
--     @PONbr                 - PO to work on
--     @CurrentPJFiscalPeriod - Current Project Fiscal Period
--     @Prog                  - bpes screen
--     @User                  - left 10 chars of bpes userid
-- =======================================================================================================

SET NOCOUNT ON

-- This temporary work table is used to store messages to pass back to the app
--   MsgType: O = PurchOrd not found
--            P = Invalid Project
--            T = Invalid Task
--            A - Invalid Project Account
CREATE TABLE #POWrkMessages
 ( Acct        VARCHAR(16)
 , LineRef     CHAR(5)
 , MsgType     CHAR(1)
 , ProjectID   VARCHAR(16)
 , TaskID      VARCHAR(32)
 , FromCury	   CHAR(4)
 , ToCury      CHAR(4)
 )

-- The following are pulled from the PO using the PO Number parameter
DECLARE @CpnyID             VARCHAR(10)
      , @CuryEffDate        SMALLDATETIME
      , @CuryRateType       CHAR(6)
      , @PO_Date            SMALLDATETIME
      , @Vendor_Num         VARCHAR(15)
SELECT @CpnyID       = PurchOrd.CpnyID
     , @CuryEffDate  = PurchOrd.CuryEffDate
     , @CuryRateType = PurchOrd.CuryRateType
     , @PO_Date      = PurchOrd.PODate
     , @Vendor_Num   = PurchOrd.VendID
 FROM PurchOrd WITH (NOLOCK)
 WHERE PurchOrd.PONbr = @PONbr
IF @@Error <> 0 OR @@ROWCOUNT <> 1
BEGIN
    INSERT INTO #POWrkMessages (Acct, LineRef, MsgType, ProjectID, TaskID)
     VALUES ('', '', 'O', '', '')
    GOTO END_PROCEDURE -- If we did not find a unique PO record, exit (* This should NOT happen)
END

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
      , @ProjCuryDecPl	INT
      , @ProjCuryAmount FLOAT
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
--        * Note O types are not used for PJCOMDET - just for the summary udpates

CREATE TABLE #POWrkPJComDet
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
 , voucher_line       INT
 )

-- Load the insert and update records
--   Do as many conversions and formulas as possible now
INSERT INTO #POWrkPJComDet
 ( WrkTranType
 , acct
 , amount
 , batch_type
 , cd_id05
 , CuryId
 , CuryMultDiv
 , CuryRate
 , CuryTranAmt
 , gl_acct
 , gl_subacct
 , LineRef
 , part_number
 , pjt_entity
 , ProjCury_amount
 , ProjCuryEffDate
 , ProjCuryId
 , ProjCuryMultiDiv
 , ProjCuryRate
 , ProjCuryRateType
 , project
 , promise_date
 , request_date
 , tr_comment
 , units
 , unit_of_measure
 , user1
 , user2
 , user3
 , user4
 , voucher_line
 )
 SELECT (CASE PJCOMDET.purchase_order_num
          WHEN @PONbr THEN 'U'
          ELSE 'I'
         END)
      , CASE PurOrdDet.PurchaseType 
          WHEN 'PI'  
            THEN PJ_Account2.acct
          WHEN 'PS'  
            THEN PJ_Account2.acct	
          ELSE PJ_Account.acct END
      , (CASE PurOrdDet.PurchaseType
          WHEN 'SP' THEN	-- Service for a project
           (Round((PurOrdDet.ExtCost - PurOrdDet.CostReceived) - PurOrdDet.CostVouched, @BaseDecimalPlaces))
          WHEN 'GP' THEN -- Goods for project
           (Round(PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd), @BaseDecimalPlaces))
          WHEN 'PI' THEN -- Goods for Project Inventory
           (Round(PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd), @BaseDecimalPlaces))
          WHEN 'PS' THEN -- Goods for Project Sales Order
           (Round(PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd), @BaseDecimalPlaces))
          WHEN 'GN' THEN -- Goods for non-inventory
           (Round(PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd), @BaseDecimalPlaces))
          WHEN 'GD' THEN -- Goods for drop ship
           (Round(PurOrdDet.UnitCost * ((PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd) - PurOrdDet.QtyVouched), @BaseDecimalPlaces))
          ELSE	-- MI for Misc or FR for Freight (should never have DL, GI, GS, or SE)
           (Round(PurOrdDet.ExtCost - PurOrdDet.CostReceived, @BaseDecimalPlaces))
         END)
      , PurOrdDet.PurchaseType
      , PurOrdDet.Labor_Class_Cd
      , PurOrdDet.CuryID
      -- Convert currency divisor to multiplier (and set rate and tran amount appropriately)
      , (CASE
          WHEN (PurOrdDet.CuryMultDiv = 'D' AND PurOrdDet.CuryRate <> 0.00) THEN 'M'
          ELSE PurOrdDet.CuryMultDiv
         END)
      , (CASE
          WHEN (PurOrdDet.CuryMultDiv = 'D' AND PurOrdDet.CuryRate <> 0.00) THEN (1 / PurOrdDet.CuryRate)
          ELSE PurOrdDet.CuryRate
         END)
      , 0	-- CuryTranAmt will be filled in later
      , CASE PurOrdDet.PurchaseType 
          WHEN 'PI' 
            THEN PurOrdDet.WIP_COGS_Acct
          WHEN 'PS'
             THEN PurOrdDet.WIP_COGS_Acct
          ELSE PurOrdDet.PurAcct END
      , CASE PurOrdDet.PurchaseType 
         WHEN 'PI' 
           THEN PurOrdDet.WIP_COGS_Sub
         WHEN 'PS'
           THEN PurOrdDet.WIP_COGS_Sub
         ELSE PurOrdDet.PurSub END
      , PurOrdDet.LineRef
      , PurOrdDet.InvtID
      , PurOrdDet.TaskID
      , 0
      , GETDATE()
      , SPACE(0)
      , SPACE(0)
      , 0
      , SPACE(0)
      , PurOrdDet.ProjectID
      , PurOrdDet.PromDate
      , PurOrdDet.ReqdDate
      , LEFT(LTRIM(PurOrdDet.TranDesc), 30)
      , (CASE PurOrdDet.PurchaseType
          WHEN 'SP' THEN
           ((PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd) - PurOrdDet.QtyVouched)
          WHEN 'GD' THEN
           ((PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd) - PurOrdDet.QtyVouched)
          ELSE
           (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd)
         END)
      , PurOrdDet.PurchUnit
      , PurOrdDet.User1
      , PurOrdDet.User2
      , PurOrdDet.User3
      , PurOrdDet.User4
      , PurOrdDet.LineID
 FROM PurOrdDet WITH (NOLOCK)
  INNER JOIN PurchOrd WITH (NOLOCK)
   ON PurchOrd.PONbr = PurOrdDet.PONbr
    AND PurchOrd.POType IN ('OR', 'BL', 'DP')	-- Regular, Blanket, and Drop Ship
    AND PurchOrd.Status NOT IN ('Q', 'X', 'M')	-- Not (Quote, Cancelled, or Completed)
  LEFT OUTER JOIN PJ_Account WITH (NOLOCK)
   ON PJ_Account.gl_acct = PurOrdDet.PurAcct	-- to Convert PurAcct to a project acct (PJ_Account.acct)
   AND PurOrdDet.PurchaseType NOT IN ('PI','PS')
  LEFT OUTER JOIN PJ_Account PJ_Account2
    ON PJ_Account2.gl_acct = PurOrdDet.WIP_COGS_Acct
   AND PurOrdDet.PurchaseType IN ('PI','PS')
  LEFT OUTER JOIN PJCOMDET WITH (NOLOCK)
   ON PJCOMDET.purchase_order_num = PurOrdDet.PONbr
    AND PJCOMDET.voucher_line = PurOrdDet.LineID
    AND PJCOMDET.system_cd = 'PO'
 WHERE PurOrdDet.PONbr = @PONbr
   AND PurOrdDet.pc_status = '1'
   -- The following ensure we only get lines that changed or updates
   AND (PJCOMDET.purchase_order_num IS NULL
        OR PJCOMDET.po_date <> @PO_Date
        OR PJCOMDET.amount <> (CASE PurOrdDet.PurchaseType
                             WHEN 'SP' THEN	-- Service for a project
                              ((PurOrdDet.ExtCost - PurOrdDet.CostReceived) - PurOrdDet.CostVouched)
                             WHEN 'GP' THEN -- Goods for project
                              (PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd))
                             WHEN 'PI' THEN -- Goods for Project Inventory
                              (PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd))
                             WHEN 'PS' THEN -- Goods for Project Sales Order
                              (PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd))
                             WHEN 'GN' THEN -- Goods for non-inventory
                              (PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd))
                             WHEN 'GD' THEN -- Goods for drop ship
                              (PurOrdDet.UnitCost * ((PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd) - PurOrdDet.QtyVouched))
                             ELSE	-- MI for Misc or FR for Freight (should never have DL, GI, GS, or SE)
                              (PurOrdDet.ExtCost - PurOrdDet.CostReceived)
                            END)
        OR PJCOMDET.units <> (CASE PurOrdDet.PurchaseType
                               WHEN 'SP' THEN
                                ((PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd) - PurOrdDet.QtyVouched)
                               WHEN 'GD' THEN
                                ((PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd) - PurOrdDet.QtyVouched)
                               ELSE
                                (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd)
                              END)
        OR PJCOMDET.batch_type <> PurOrdDet.PurchaseType
        OR PJCOMDET.project <> PurOrdDet.ProjectID
        OR PJCOMDET.pjt_entity <> PurOrdDet.TaskID
        OR PJCOMDET.acct <> PJ_Account.acct
        OR ((PJCOMDET.gl_acct <> PurOrdDet.PurAcct AND PurOrdDet.PurchaseType NOT IN ('PI','PS')) OR
             (PJCOMDET.gl_acct <> PurOrdDet.WIP_COGS_Acct AND PurOrdDet.PurchaseType IN ('PI','PS')))
        OR ((PJCOMDET.gl_subacct <> PurOrdDet.PurSub AND PurOrdDet.PurchaseType NOT IN ('PI','PS')) OR
             (PJCOMDET.gl_subacct <> PurOrdDet.WIP_COGS_Sub AND PurOrdDet.PurchaseType IN ('PI','PS')))
        OR PJCOMDET.unit_of_measure <> PurOrdDet.PurchUnit
        OR PJCOMDET.promise_date <> PurOrdDet.PromDate
        OR PJCOMDET.request_date <> PurOrdDet.ReqdDate
        OR PJCOMDET.cd_id05 <> PurOrdDet.Labor_Class_Cd
        OR PJCOMDET.tr_comment <> LEFT(LTRIM(PurOrdDet.TranDesc), 30)
        OR PJCOMDET.user1 <> PurOrdDet.User1
        OR PJCOMDET.user2 <> PurOrdDet.User2
        OR PJCOMDET.user3 <> PurOrdDet.User3
        OR PJCOMDET.user4 <> PurOrdDet.User4
        )
IF @@Error <> 0 GOTO END_PROCEDURE

-- VALIDATION
-- Check that project exists - taken from PJPROJ_sPK0
INSERT INTO #POWrkMessages (Acct, LineRef, MsgType, ProjectID, TaskID)
 SELECT #POWrkPJComDet.acct
      , #POWrkPJComDet.LineRef
      , 'P'
      , #POWrkPJComDet.project
      , #POWrkPJComDet.pjt_entity
  FROM #POWrkPJComDet
   LEFT OUTER JOIN PJPROJ WITH (NOLOCK)
    ON PJPROJ.project = #POWrkPJComDet.project
  WHERE PJPROJ.project IS NULL

DELETE #POWrkPJComDet
 FROM #POWrkPJComDet
  LEFT OUTER JOIN PJPROJ WITH (NOLOCK)
   ON PJPROJ.project = #POWrkPJComDet.project
 WHERE PJPROJ.project IS NULL

-- Check that Task exists - taken from PJPENT_sPK0
INSERT INTO #POWrkMessages (Acct, LineRef, MsgType, ProjectID, TaskID)
 SELECT #POWrkPJComDet.acct
      , #POWrkPJComDet.LineRef
      , 'T'
      , #POWrkPJComDet.project
      , #POWrkPJComDet.pjt_entity
  FROM #POWrkPJComDet
   LEFT OUTER JOIN PJPENT WITH (NOLOCK)
    ON PJPENT.project = #POWrkPJComDet.project
     AND PJPENT.pjt_entity = #POWrkPJComDet.pjt_entity
  WHERE PJPENT.pjt_entity IS NULL

DELETE #POWrkPJComDet
 FROM #POWrkPJComDet
  LEFT OUTER JOIN PJPENT WITH (NOLOCK)
   ON PJPENT.project = #POWrkPJComDet.project
    AND PJPENT.pjt_entity = #POWrkPJComDet.pjt_entity
 WHERE PJPENT.pjt_entity IS NULL

-- Check that Category exists - taken from PJACCT_SPK0
INSERT INTO #POWrkMessages (Acct, LineRef, MsgType, ProjectID, TaskID)
 SELECT #POWrkPJComDet.acct
      , #POWrkPJComDet.LineRef
      , 'A'
      , #POWrkPJComDet.project
      , #POWrkPJComDet.pjt_entity
  FROM #POWrkPJComDet
   LEFT OUTER JOIN PJACCT WITH (NOLOCK)
    ON PJACCT.acct = #POWrkPJComDet.acct
  WHERE PJACCT.acct IS NULL

DELETE #POWrkPJComDet
 FROM #POWrkPJComDet
  LEFT OUTER JOIN PJACCT WITH (NOLOCK)
   ON PJACCT.acct = #POWrkPJComDet.acct
 WHERE PJACCT.acct IS NULL

 
-- Update the amount, units, and currency tran amount
UPDATE #POWrkPJComDet
 SET amount = (CASE WHEN amount < 0.00 THEN 0.00 ELSE ROUND(amount, @BaseDecimalPlaces) END)
   , units = (CASE WHEN amount < 0.00 THEN 0.00 ELSE units END)
   , CuryTranAmt = (CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END)

   , ProjCuryEffDate = (CASE WHEN PJPROJ.ProjCuryId = @BaseCuryID THEN PURCHORD.PODate ELSE PURCHORD.CuryEffDate END)
   , ProjCuryId = PJPROJ.ProjCuryId
   , ProjCuryMultiDiv = (CASE WHEN #POWrkPJComDet.CuryId = PJPROJ.ProjCuryId THEN #POWrkPJComDet.CuryMultDiv ELSE 'M' END)
   , ProjCuryRateType = (CASE WHEN #POWrkPJComDet.CuryId = PJPROJ.ProjCuryId THEN PURCHORD.CuryRateType WHEN PJProj.BaseCuryId = @BaseCuryID THEN '' ELSE PJPROJ.ProjCuryRateType END)
   , ProjCury_amount = (CASE WHEN #POWrkPJComDet.CuryId = PJPROJ.ProjCuryId THEN (CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END)
							 WHEN PJPROJ.ProjCuryId = @BaseCuryID THEN amount
							 ELSE (CASE WHEN CuryRateTbl.MultDiv = 'M' THEN ROUND((CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END) *  CuryRateTbl.rate, Currncy.DecPl)
										ELSE ROUND((CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END) / CuryRateTbl.rate ,Currncy.DecPl) END) 
						END)
    , ProjCuryRate = (CASE WHEN #POWrkPJComDet.CuryId = PJPROJ.ProjCuryId THEN #POWrkPJComDet.CuryRate
						  WHEN PJPROJ.ProjCuryId = @BaseCuryID THEN 1
						  ELSE (CASE WHEN 
						  /*Get ProjCury_Amount*/(CASE WHEN #POWrkPJComDet.CuryId = PJPROJ.ProjCuryId THEN (CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END)
							 WHEN PJPROJ.ProjCuryId = @BaseCuryID THEN amount
							 ELSE (CASE WHEN CuryRateTbl.MultDiv = 'M' THEN ROUND((CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END) *  CuryRateTbl.rate, Currncy.DecPl)
										ELSE ROUND((CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END) / CuryRateTbl.rate ,Currncy.DecPl) END) 
						END) <> 0
						   THEN ABS(Round((amount / 
						   /*Get ProjCury_Amount*/(CASE WHEN #POWrkPJComDet.CuryId = PJPROJ.ProjCuryId THEN (CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END)
							 WHEN PJPROJ.ProjCuryId = @BaseCuryID THEN amount
							 ELSE (CASE WHEN CuryRateTbl.MultDiv = 'M' THEN ROUND((CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END) *  CuryRateTbl.rate, Currncy.DecPl)
										ELSE ROUND((CASE WHEN #POWrkPJComDet.CuryRate = 0.00 THEN 0.00 ELSE ROUND(amount / #POWrkPJComDet.CuryRate, Currncy.DecPl) END) / CuryRateTbl.rate ,Currncy.DecPl) END) 
						END)), 9))
						   ELSE 1 END)
					END)
 FROM #POWrkPJComDet
  INNER JOIN Currncy WITH (NOLOCK)
   ON Currncy.CuryID = #POWrkPJComDet.CuryID
  INNER JOIN PJPROJ
   ON PJPROJ.project = #POWrkPJComDet.project
  INNER JOIN PURCHORD WITH (NOLOCK)
   ON PURCHORD.PONbr = @PONbr
  OUTER Apply dbo.CuryRateTbl(Currncy.CuryId, PJPROJ.ProjCuryId, PJPROJ.ProjCuryRateType, PurchOrd.PODate) CuryRateTbl

  -- Now load the original and delete records
INSERT INTO #POWrkPJComDet
 ( WrkTranType
 , acct
 , amount
 , batch_type
 , cd_id05
 , CuryId
 , CuryMultDiv
 , CuryRate
 , CuryTranAmt
 , gl_acct
 , gl_subacct
 , LineRef
 , part_number
 , pjt_entity
 , ProjCury_amount
 , ProjCuryEffDate
 , ProjCuryId
 , ProjCuryMultiDiv
 , ProjCuryRate
 , ProjCuryRateType
 , project
 , promise_date
 , request_date
 , tr_comment
 , units
 , unit_of_measure
 , user1
 , user2
 , user3
 , user4
 , voucher_line
 )
 SELECT (CASE PurOrdDet.PONbr
          WHEN @PONbr THEN 'O'
          ELSE 'D'
         END)
      , PJCOMDET.acct
      , ROUND((PJCOMDET.amount * -1), @BaseDecimalPlaces)
      , PJCOMDET.batch_type
      , PJCOMDET.cd_id05
      , PJCOMDET.CuryId
      , PJCOMDET.CuryMultDiv
      , PJCOMDET.CuryRate
      , ROUND((PJCOMDET.CuryTranamt * -1), Currncy.DecPl)
      , PJCOMDET.gl_acct
      , PJCOMDET.gl_subacct
      , (CASE PurOrdDet.PONbr
          WHEN @PONbr THEN PurOrdDet.LineRef
          ELSE ''
         END)
      , PJCOMDET.part_number
      , PJCOMDET.pjt_entity
      , ROUND((PJCOMDET.ProjCury_amount* -1), Currncy.DecPl) 
      , PJCOMDET.ProjCuryEffDate
      , PJCOMDET.ProjCuryId
      , PJCOMDET.ProjCuryMultiDiv
      , PJCOMDET.ProjCuryRate
      , PJCOMDET.ProjCuryRateType
      , PJCOMDET.project
      , PJCOMDET.promise_date
      , PJCOMDET.request_date
      , PJCOMDET.tr_comment
      , (PJCOMDET.units * -1)
      , PJCOMDET.unit_of_measure
      , PJCOMDET.user1
      , PJCOMDET.user2
      , PJCOMDET.user3
      , PJCOMDET.user4
      , PJCOMDET.voucher_line
 FROM PJCOMDET WITH (NOLOCK)
  INNER JOIN Currncy WITH (NOLOCK)
   ON Currncy.CuryID = PJCOMDET.CuryID
  LEFT OUTER JOIN PurOrdDet WITH (NOLOCK)
     INNER JOIN PurchOrd WITH (NOLOCK)
      ON PurchOrd.PONbr = PurOrdDet.PONbr
       AND PurchOrd.POType IN ('OR', 'BL', 'DP')	-- Regular, Blanket, and Drop Ship
       AND PurchOrd.Status NOT IN ('Q', 'X', 'M')	-- Not (Quote, Cancelled, or Completed)
     LEFT OUTER JOIN PJ_Account WITH (NOLOCK)
      ON PJ_Account.gl_acct = PurOrdDet.PurAcct	-- to Convert PurAcct to a project acct (PJ_Account.acct)
   ON PurOrdDet.PONbr = PJCOMDET.purchase_order_num
    AND PurOrdDet.LineID = PJCOMDET.voucher_line
    AND PurOrdDet.PC_Status = '1'
 WHERE PJCOMDET.purchase_order_num = @PONbr
   AND PJCOMDET.system_cd = 'PO'
   -- The following ensures we only get lines that changed for originals
   AND (PurOrdDet.PONbr IS NULL
        OR PJCOMDET.po_date <> PurchOrd.PODate
        OR PJCOMDET.amount <> (CASE PurOrdDet.PurchaseType
                             WHEN 'SP' THEN	-- Service for a project
                              ((PurOrdDet.ExtCost - PurOrdDet.CostReceived) - PurOrdDet.CostVouched)
                             WHEN 'GP' THEN -- Goods for project
                              (PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd))
                             WHEN 'PI' THEN -- Goods for Project Inventory
                              (PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd))
                             WHEN 'PS' THEN -- Goods for Project Sales Order
                              (PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd))
                             WHEN 'GN' THEN -- Goods for non-inventory
                              (PurOrdDet.UnitCost * (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd))
                             WHEN 'GD' THEN -- Goods for drop ship
                              (PurOrdDet.UnitCost * ((PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd) - PurOrdDet.QtyVouched))
                             ELSE	-- MI for Misc or FR for Freight (should never have DL, GI, GS, or SE)
                              (PurOrdDet.ExtCost - PurOrdDet.CostReceived)
                            END)
        OR PJCOMDET.units <> (CASE PurOrdDet.PurchaseType
                               WHEN 'SP' THEN
                                ((PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd) - PurOrdDet.QtyVouched)
                               WHEN 'GD' THEN
                                ((PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd) - PurOrdDet.QtyVouched)
                               ELSE
             (PurOrdDet.QtyOrd - PurOrdDet.QtyRcvd)
                              END)
        OR PJCOMDET.batch_type <> PurOrdDet.PurchaseType
        OR PJCOMDET.project <> PurOrdDet.ProjectID
        OR PJCOMDET.pjt_entity <> PurOrdDet.TaskID
        OR PJCOMDET.acct <> PJ_Account.acct
        OR ((PJCOMDET.gl_acct <> PurOrdDet.PurAcct AND PurOrdDet.PurchaseType NOT IN ('PI','PS')) OR
             (PJCOMDET.gl_acct <> PurOrdDet.WIP_COGS_Acct AND PurOrdDet.PurchaseType IN ('PI','PS')))
        OR ((PJCOMDET.gl_subacct <> PurOrdDet.PurSub AND PurOrdDet.PurchaseType NOT IN ('PI','PS')) OR
             (PJCOMDET.gl_subacct <> PurOrdDet.WIP_COGS_Sub AND PurOrdDet.PurchaseType IN ('PI','PS')))
        OR PJCOMDET.unit_of_measure <> PurOrdDet.PurchUnit
        OR PJCOMDET.promise_date <> PurOrdDet.PromDate
        OR PJCOMDET.request_date <> PurOrdDet.ReqdDate
        OR PJCOMDET.cd_id05 <> PurOrdDet.Labor_Class_Cd
        OR PJCOMDET.tr_comment <> LEFT(LTRIM(PurOrdDet.TranDesc), 30)
        OR PJCOMDET.user1 <> PurOrdDet.User1
        OR PJCOMDET.user2 <> PurOrdDet.User2
        OR PJCOMDET.user3 <> PurOrdDet.User3
        OR PJCOMDET.user4 <> PurOrdDet.User4
        )
IF @@Error <> 0 GOTO END_PROCEDURE

  --Need to validate Transactions for valid currency rates
  INSERT INTO #POWrkMessages (Acct, LineRef, MsgType, ProjectID, TaskID, FromCury, ToCury)
     Select '','','C', c.project, '', c.CuryId, c.ProjCuryId
 from #POWrkPJComDet c
  Inner JOIN PurchOrd p  With (NOLOCK) on p.PONbr = @PONbr
  OUTER Apply dbo.CuryRateTbl(c.CuryId, c.ProjCuryId, c.ProjCuryRateType, p.PODate ) 
  Where (c.CuryID <> c.ProjCuryId and c.ProjCuryId <> @BaseCuryID) and FromCuryId is null
  group by c.project, c.CuryId, c.ProjCuryId

  Delete #POWrkPJComDet  
   from #POWrkPJComDet c
  Inner JOIN PurchOrd p With (NOLOCK) on p.PONbr = @PONbr
  OUTER Apply dbo.CuryRateTbl(c.CuryId, c.ProjCuryId, c.ProjCuryRateType, p.PODate ) 
  Where (c.CuryID <> c.ProjCuryId and c.ProjCuryId <> @BaseCuryID) and FromCuryId is null

-- UPDATE/INSERT SUMMARY TABLES
BEGIN TRANSACTION
-- Use cursor to group & sum the work table by project, task, and account
DECLARE Wrk_Cursor CURSOR LOCAL FAST_FORWARD
 FOR SELECT project, pjt_entity, acct, ROUND(SUM(amount), @BaseDecimalPlaces), ROUND(SUM(ProjCury_amount), Currncy.DecPl), currncy.DecPl ,SUM(units)
      FROM #POWrkPJComDet 
	  Inner Join Currncy
	  ON #POWrkPJComDet.ProjCuryId = Currncy.CuryId
      GROUP BY project, pjt_entity, acct, Currncy.DecPl
      HAVING ROUND(SUM(amount), @BaseDecimalPlaces) <> 0
       OR SUM(units) <> 0
OPEN Wrk_Cursor

FETCH NEXT FROM Wrk_Cursor INTO @Project, @Task, @Acct, @Amount, @ProjCuryAmount, @ProjCuryDecPl ,@Units
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
		   , ProjCury_com_amount = ROUND(projcury_com_amount + @ProjCuryAmount, @ProjCuryDecPl)
           , com_units = com_units + @units
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
           , ProjCury_com_amount = ROUND(ProjCury_com_amount + @ProjCuryAmount, @ProjCuryDecPl)
           , com_units = com_units + @units
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
	   , @ProjCuryDecPl
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
       , @ProjCuryDecPl
       , @SQL OUTPUT
    -- Run the statement
    EXEC (@SQL)
    IF @@Error <> 0 GOTO ABORT_TRAN

	NEXTRECORD:

    FETCH NEXT FROM Wrk_Cursor INTO @Project, @Task, @Acct, @Amount, @ProjCuryAmount, @ProjCuryDecPl , @Units
END
CLOSE Wrk_Cursor
DEALLOCATE Wrk_Cursor

-- Now update pjcomdet
-- Do any needed updates next
UPDATE PJCOMDET
 SET acct = #POWrkPJComDet.acct
   , amount = #POWrkPJComDet.amount
   , BaseCuryId = @BaseCuryID
   , batch_id = @PONbr
   , batch_type = #POWrkPJComDet.batch_type
   , bill_batch_id = '', cd_id01 = '', cd_id02 = '', cd_id03 = '', cd_id04 = ''
   , cd_id05 = #POWrkPJComDet.cd_id05
   , cd_id06 = 0, cd_id07 = 0, cd_id08 = 0, cd_id09 = 0, cd_id10 = 0
   , cpnyId = @CpnyID
   , CuryEffDate = @CuryEffDate
   , CuryId = #POWrkPJComDet.CuryId
   , CuryMultDiv = #POWrkPJComDet.CuryMultDiv
   , CuryRate = #POWrkPJComDet.CuryRate
   , CuryRateType = @CuryRateType
   , CuryTranamt = #POWrkPJComDet.CuryTranAmt
   , data1 = ''
   , fiscalno = @CurrentPJFiscalPeriod
   , gl_acct = #POWrkPJComDet.gl_acct
   , gl_subacct = #POWrkPJComDet.gl_subacct
   , lupd_datetime = GETDATE()
   , lupd_prog = @Prog
   , lupd_user = @User
   , part_number = #POWrkPJComDet.part_number
   , pjt_entity = #POWrkPJComDet.pjt_entity
   , po_date = @PO_Date
   , ProjCury_amount = #POWrkPJComDet.ProjCury_amount
   , ProjCuryEffDate = #POWrkPJComDet.ProjCuryEffDate
   , ProjCuryId = #POWrkPJComDet.ProjCuryId
   , ProjCuryMultiDiv = #POWrkPJComDet.ProjCuryMultiDiv
   , ProjCuryRate = #POWrkPJComDet.ProjCuryRate
   , ProjCuryRateType = #POWrkPJComDet.ProjCuryRateType
   , project = #POWrkPJComDet.project
   , promise_date = #POWrkPJComDet.promise_date
   , request_date = #POWrkPJComDet.request_date
   , system_cd = 'PO'
   , tr_comment = #POWrkPJComDet.tr_comment
   , tr_status = ''
   , units = #POWrkPJComDet.units
   , unit_of_measure = #POWrkPJComDet.unit_of_measure
   , user1 = #POWrkPJComDet.user1
   , user2 = #POWrkPJComDet.user2
   , user3 = #POWrkPJComDet.user3
   , user4 = #POWrkPJComDet.user4
   , vendor_num = @Vendor_Num
   , voucher_num = ''
 FROM PJCOMDET
  INNER JOIN #POWrkPJComDet
   ON #POWrkPJComDet.voucher_line = PJCOMDET.voucher_line
    AND #POWrkPJComDet.WrkTranType = 'U'
 WHERE PJCOMDET.purchase_order_num = @PONbr
IF @@Error <> 0 GOTO ABORT_TRAN

-- Insert any new ones
INSERT INTO PJCOMDET
 ( acct
 , amount
 , BaseCuryId
 , batch_id
 , batch_type
 , bill_batch_id, cd_id01, cd_id02, cd_id03, cd_id04
 , cd_id05
 , cd_id06, cd_id07, cd_id08, cd_id09, cd_id10
 , cpnyId
 , crtd_datetime
 , crtd_prog
 , crtd_user
 , CuryEffDate
 , CuryId
 , CuryMultDiv
 , CuryRate
 , CuryRateType
 , CuryTranamt
 , data1
 , detail_num
 , fiscalno
 , gl_acct
 , gl_subacct
 , lupd_datetime
 , lupd_prog
 , lupd_user
 , part_number
 , pjt_entity
 , po_date
 , ProjCury_amount
 , ProjCuryEffDate
 , ProjCuryId
 , ProjCuryMultiDiv
 , ProjCuryRate
 , ProjCuryRateType
 , project
 , projinv_lineref
 , projinv_receipt_num
 , projinv_referenc_num
 , promise_date
 , purchase_order_num
 , request_date
 , sub_line_item
 , system_cd
 , tr_comment
 , tr_status
 , units
 , unit_of_measure
 , user1
 , user2
 , user3
 , user4
 , vendor_num
 , voucher_line
 , voucher_num
 )
 SELECT acct
      , amount
      , @BaseCuryID
      , @PONbr
      , batch_type
      , '', '', '', '', ''
      , cd_id05
      , 0, 0, 0, 0, 0
      , @CpnyID
      , GETDATE()
      , @Prog
      , @User
      , @CuryEffDate
      , CuryId
      , CuryMultDiv
      , CuryRate
      , @CuryRateType
      , CuryTranAmt
      , ''
      , voucher_line
      , @CurrentPJFiscalPeriod
      , gl_acct
      , gl_subacct
      , GETDATE()
      , @Prog
      , @User
      , part_number
      , pjt_entity
      , @PO_Date
      , ProjCury_amount
      , ProjCuryEffDate
      , ProjCuryId
      , ProjCuryMultiDiv
      , ProjCuryRate
      , ProjCuryRateType
      , project
      , ''
      , ''
      , ''
      , promise_date
      , @PONbr
      , request_date
      , ' '
      , 'PO'
      , tr_comment
      , ''
      , units
      , unit_of_measure
      , user1
      , user2
      , user3
      , user4
      , @Vendor_Num
      , voucher_line
      , ''
   FROM #POWrkPJComDet
  WHERE #POWrkPJComDet.WrkTranType = 'I'
IF @@Error <> 0 GOTO ABORT_TRAN

-- Delete where needed; those marked deleted and those where updates left qty and amount zero
-- NOTE: This must come after the update and insert into PJCOMDET to clean up the table properly
DELETE PJCOMDET
 FROM PJCOMDET
  LEFT OUTER JOIN #POWrkPJComDet
   ON #POWrkPJComDet.voucher_line = PJCOMDET.voucher_line
    AND #POWrkPJComDet.WrkTranType = 'D'
 WHERE PJCOMDET.purchase_order_num = @PONbr
  AND (#POWrkPJComDet.voucher_line IS NOT NULL -- Found one marked for delete
       OR (PJCOMDET.amount = 0                 -- Or an insert or update left one with zero amount and units
           AND PJCOMDET.units = 0))
IF @@Error <> 0 GOTO ABORT_TRAN

COMMIT TRANSACTION
GOTO END_PROCEDURE

ABORT_TRAN:
ROLLBACK TRANSACTION

END_PROCEDURE:
-- Send any messages back to the app
SELECT *
 FROM #POWrkMessages



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POAutoProjectCommitments] TO [MSDSL]
    AS [dbo];


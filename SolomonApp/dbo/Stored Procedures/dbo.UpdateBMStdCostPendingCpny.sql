
Create Proc [dbo].[UpdateBMStdCostPendingCpny] @KitKitID varchar (30), @KitSiteID varchar (10), @InvtIDNoKits varchar ( 30),
                                   @WorkCenter varchar(10),@LaborClass varchar(10), @ProductClass varchar(6),
                                   @UserID varchar(10), @ProgID varchar(5), @PesTodayDate smalldatetime ,
                                   @CpnyID varChar (10), @UpdtOpt varchar(1), @UserAddress varchar(21)
AS
--- UpdtOpt = 'K' - Kits, 'I' - Non Kits, 'W' - WorkCenter, 'L' - LaborClass, 'P' - ProductClass, 'A' - All of the Above
--- If UpdtOpt is A, then KitKitID, KitSiteID, InvtIDNoKits, WorkCenter, LaborClass, and ProductClass will all pass the SQLWildString '%'
--- Based on the UpdtOpt other than A, it will pass the values in the Update Standard Cost from Pending.

DECLARE @DecPlPrcCst INT, @BaseDecPl INT, @LedgerID Varchar(10), @BaseCuryID Varchar(4)
DECLARE @BatNbr Varchar(10)
DECLARE @LastBatNbr Varchar(10), @BatNbr_Len Smallint, @BatNbr_Str Varchar(10)
DECLARE @COUNT INT
DECLARE @PERIOD Varchar(6), @BMSetUpGLBSiteID Varchar(10), @BMSetUPSiteBOM int, @StdCstRevalAcct Varchar(10), @StdCstRevalSub VarChar(24)
DECLARE @SQLError Integer
DECLARE @WhseLoc VarChar(10)

SELECT @DecPlPrcCst = DecPlPrcCst
  FROM InSetup WITH(NOLOCK)

SELECT @BMSetUpGLBSiteID = GLBSiteID, @BMSetUPSiteBOM = SiteBOM, @Period = PerNbr,
       @StdCstRevalAcct = StdCstRevalAcct, @StdCstRevalSub = StdCstRevalSub
  FROM BMSetup WITH(NOLOCK)

SELECT @BaseDecPl = c.DecPl, @LedgerID   = s.LedgerID, @BaseCuryID = s.BaseCuryID
  FROM  GLSetup s WITH(NOLOCK)  INNER JOIN Currncy c WITH(NOLOCK)
                               ON s.BaseCuryID = c.CuryID

--Delete any Pending Standard Cost Batch Numbers from WrkPostBad for this User
-- The WrkPostBad is being used a table to store the Batch Number that is created in this Stored Proc.
DELETE
  FROM WrkPostBad
 WHERE Module = 'BM' AND UserAddress = @UserAddress AND Situation = 'PENDSTDCST'

--Work Table used to Update ItemSite Records and Create the Batch and IN Trans if the RevAmt is Greater than Zero.
CREATE TABLE #WrkITEMSITE
  (InvtID      VarChar(30)
   ,SiteID     VarChar(10)
   ,RevAmt     FLOAT
   ,InvtAcct   VarChar(10)
   ,InvtSub    VarChar(24)
   ,InvtAcct2  VarChar(10)
   ,InvtSub2   VarChar(24)
   ,RecordId   INT IDENTITY(-32767, 1)
 )

IF (@UpdtOpt = 'A' OR @UpdtOpt = 'W')
BEGIN
   --- Update the WorkCenter Rates that have changed.
   UPDATE WorkCenter
      SET SFLbrOvhRate = PFLbrOvhRate, SFMachOvhRate = PFMachOvhRate, SLbrOvhRate = PLbrOvhRate,
          SMachOvhRate = PMachOvhRate, SVLbrOvhRate = PVLbrOvhRate, SVMachOvhRate = PVMachOvhRate,
          PFLbrOvhRate = 0, PFMachOvhRate = 0, PLbrOvhRate = 0, PMachOvhRate = 0, PVLbrOvhRate = 0, PVMachOvhRate = 0,
          Crtd_Prog = CASE WHEN Crtd_Prog = '' THEN @ProgID ELSE Crtd_Prog END,
          Crtd_User = CASE WHEN Crtd_User = '' THEN @UserID ELSE Crtd_User END,
          Crtd_DateTime = CASE WHEN Crtd_Prog = '' THEN GETDATE() ELSE Crtd_DateTime END,
          LUpd_Prog = @ProgID, LUpd_User = @UserID, LUpd_DateTime = GETDATE()
    WHERE WorkCenterId like @WorkCenter
      AND (PFLbrOvhRate <> 0 OR PFMachOvhRate <> 0 OR PLbrOvhRate <> 0
       OR PMachOvhRate <> 0 OR PVLbrOvhRate <> 0 OR PVMachOvhRate <> 0)
END

IF (@UpdtOpt = 'A' OR @UpdtOpt = 'L')
BEGIN
   --- Update the LaborClass Rates that have changed.
   UPDATE LaborClass
      SET CPayRate = PPayRate, CStdRate = PStdRate, PPayRate = 0, PStdRate = 0,
          Crtd_Prog = CASE WHEN Crtd_Prog = '' THEN @ProgID ELSE Crtd_Prog END,
          Crtd_User = CASE WHEN Crtd_User = '' THEN @UserID ELSE Crtd_User END,
          Crtd_DateTime = CASE WHEN Crtd_Prog = '' THEN GETDATE() ELSE Crtd_DateTime END,
          LUpd_Prog = @ProgID, LUpd_User = @UserID, LUpd_DateTime = GETDATE()
    WHERE LbrClassId like @LaborClass
      AND (PPayRate <> 0 OR PStdRate <> 0)
END

IF (@UpdtOpt = 'A' OR @UpdtOpt = 'P')
BEGIN
   --- Update the Product Class Rates that have changed.
   UPDATE ProductClass
      SET CFOvhMatlRate = PFOvhMatlRate, CVOvhMatlRate = PVOvhMatlRate, PFOvhMatlRate = 0, PVOvhMatlRate = 0,
          Crtd_Prog = CASE WHEN Crtd_Prog = '' THEN @ProgID ELSE Crtd_Prog END,
          Crtd_User = CASE WHEN Crtd_User = '' THEN @UserID ELSE Crtd_User END,
          Crtd_DateTime = CASE WHEN Crtd_Prog = '' THEN GETDATE() ELSE Crtd_DateTime END,
          LUpd_Prog = @ProgID, LUpd_User = @UserID, LUpd_DateTime = GETDATE()
    WHERE ClassId like @ProductClass
      AND (PFOvhMatlRate <> 0 OR PVOvhMatlRate <> 0)
END

IF (@UpdtOpt = 'A' or @UpdtOpt = 'K')
BEGIN
   --Work Table used to determine the Kits that have pending Standard Costs.
   CREATE TABLE #WrkKitIDSiteID
    (KitID    VarChar(30)
    ,SiteID   VarChar(10)
    ,InvtType VarChar(1)
    ,InvtAcct   VarChar(10)
    ,InvtSub    VarChar(24)
    )

   INSERT INTO #WrkKitIDSiteID (KitID, SiteID, InvtType, InvtAcct,InvtSub)
   SELECT k.KitID, k.SiteID, i.InvtType, i.InvtAcct, i.InvtSub
     FROM Kit k WITH(NOLOCK)
     JOIN Inventory i WITH(NOLOCK)
          ON i.InvtId = k.KitId
	 JOIN Site s WITH(NOLOCK)
		  ON s.SiteId = k.SiteID
    WHERE k.KitId like @KitKitID
      AND k.SiteId like @KitSiteID
      AND s.CpnyID = @CpnyID
      AND k.Status = 'A'
      AND i.ValMthd = 'T'
      AND k.KitType = 'B'
      AND k.PstdCst <> 0

   if (@BMSetUPSiteBOM = 1)
     BEGIN
          -- Insert into Wrk Table All Item Site Records that need there Standard Costs updated.
          INSERT INTO #WrkITEMSITE (InvtID,SiteID,RevAmt,InvtAcct,InvtSub,InvtAcct2,InvtSub2)
          SELECT I.InvtID, I.SiteID,
                 RevAmt = CASE WHEN w.InvtType <> 'C'
                               THEN ROUND(CONVERT(DEC(28,3),I.QtyOnHand*(ROUND(I.PStdCst-I.StdCost,@DecPlPrcCst))),@BaseDecPl)
                               ELSE ROUND(CONVERT(DEC(28,3),I.QtyOnHand*(ROUND(I.PDirStdCst-I.DirStdCst,@DecPlPrcCst))),@BaseDecPl)
                               END, w.InvtAcct, w.InvtSub, I.InvtAcct, I.InvtSub
            FROM ItemSite I JOIN #WrkKitIDSiteID w
                              ON I.InvtID = w.KitID
                             AND I.SiteID = w.SiteID
          WHERE w.SiteID <> @BMSetUpGLBSiteID
            AND I.PStdCst <> 0

      --Process
          BEGIN TRAN

          --- INSERT ANY MISSING ITEM SITE RECORDS
          INSERT ItemSite (ABCCode, AllocQty, AvgCost, BMIAvgCost,
                           BMIDirStdCst, BMIFovhStdCst, BMILastCost, BMIPDirStdCst,
                           BMIPFOvhStdCst, BMIPStdCst, BMIPVOvhStdCst, BMIStdCost,
                           BMITotCost, BMIVOvhStdCst, Buyer, COGSAcct,
                           COGSSub, CountStatus, CpnyId, Crtd_DateTime,
                           Crtd_Prog, Crtd_User, CycleId, DfltPOUnit,
                           DfltSOUnit, DirStdCst, EOQ, FOvhStdCst,
                           InvtAcct, InvtId, InvtSub, LastBookQty,
                           LastCost, LastCountDate, LastPurchaseDate, LastPurchasePrice,
                           LastStdCost, LastVarAmt, LastVarPct, LastVarQty,
                           LastVendor, LeadTime, LUpd_DateTime, LUpd_Prog,
                           LUpd_User, MaxOnHand, MfgLeadTime, MoveClass,
                           NoteId, PDirStdCst, PFOvhStdCst, PrimVendID,
                           ProdMgrID, PStdCostDate, PStdCst, PVOvhStdCst,
                           QtyAlloc, QtyAvail, QtyCustOrd, QtyInTransit,
                           QtyNotAvail, QtyOnBO, QtyOnDP, QtyOnHand,
                           QtyOnKitAssyOrders, QtyOnPO, QtyOnTransferOrders, QtyShipNotInv,
                           QtyWOFirmDemand, QtyWOFirmSupply, QtyWORlsedDemand, QtyWORlsedSupply,
                           ReordInterval, ReordPt, ReordPtCalc, ReordQty,
                           ReordQtyCalc, ReplMthd, S4Future01, S4Future02,
                           S4Future03, S4Future04, S4Future05, S4Future06,
                   S4Future07, S4Future08, S4Future09, S4Future10,
                           S4Future11, S4Future12, SafetyStk, SafetyStkCalc,
                           SalesAcct, SalesSub, SecondVendID, Selected,
                           ShipNotInvAcct, ShipNotInvSub, SiteID, StdCost,
                           StdCostDate, StkItem, TotCost, Turns,
                           UsageRate, User1, User2, User3,
                           User4, User5, User6, User7,
                           User8, VOvhStdCst, YTDUsage)
          SELECT v.ABCCode, 0, 0, 0,
                 v.BMIDirStdCost, v.BMIFOvhStdCost, v.BMILastCost, v.BMIPDirStdCost,
                 v.BMIPFOvhStdCost, v.BMIPStdCost, v.BMIPVOvhStdCost, v.BMIStdCost,
                 0, v.BMIVOvhStdCost, '', v.COGSAcct,
                 v.COGSSub, 'A', @CpnyID, GetDate(),
                 @ProgID, @UserID, v.CycleID, v.DfltPOUnit,
                 v.DfltSOUnit, DirStdCost = ROUND(ROUND(k.CDirLbrCst+k.CDirMatlCst,@DecPlPrcCst) + k.CDirOthCst,@DecPlPrcCst)
                         , 0, FOvhStdCost = ROUND(ROUND(k.CFOvhLbrCst+k.CFOvhMachCst,@DecPlPrcCst) + k.CFOvhMatlCst,@DecPlPrcCst),
                 v.InvtAcct, w.KitID, v.InvtSub, 0,
                 v.LastCost, '', '', 0,
                 0, 0, 0, 0,
                 '', 999, GetDate(), @ProgID,
                 @UserID, 0, 0, v.MoveClass,
                 0, 0, 0, '',
                 '', v.PStdCostDate,0, 0,
                 0, 0, 0, 0,
                 0, 0, 0, 0,
                 0, 0, 0, 0,
                 0, 0, 0, 0,
                 0, 0, 0, 0,
                 0, '', '', '',
                 0, 0, 0, 0,
                 '', '', 0, 0,
                 '', '', 0, 0,
                 v.DfltSalesAcct, v.DfltSalesSub, '', 0,
                 v.DfltShpNotInvAcct, v.DfltShpNotInvSub, w.SiteId, StdCost = ROUND(ROUND(ROUND(ROUND(k.CDirLbrCst+k.CDirMatlCst,@DecPlPrcCst) + k.CDirOthCst,@DecPlPrcCst) +
                            ROUND(ROUND(k.CFOvhLbrCst+k.CFOvhMachCst,@DecPlPrcCst) + k.CFOvhMatlCst,@DecPlPrcCst),@DecPlPrcCst) +
                            ROUND(ROUND(k.CVOvhLbrCst+k.CVOvhMachCst,@DecPlPrcCst) + k.CVOvhMatlCst,@DecPlPrcCst),@DecPlPrcCst),
                 v.StdCostDate, v.StkItem, 0, 0,
                 v.UsageRate, '', '', 0,
                 0, '', '', '',
                 '', VOvhStdCost = ROUND(ROUND(k.CVOvhLbrCst+k.CVOvhMachCst,@DecPlPrcCst) + k.CVOvhMatlCst,@DecPlPrcCst), 0
            FROM #WrkKitIDSiteID w LEFT OUTER JOIN ItemSite I
                                     ON I.InvtID = w.KitID
                                    AND I.SiteID = w.SiteID
                                   JOIN KIT k
                                     ON k.KitID = w.KitID
                                    AND k.SiteID = w.SiteID
                                   JOIN Inventory v
                                     ON v.InvtID = w.KitID
           WHERE w.SiteID <> @BMSetUpGLBSiteID
             AND I.InvtId IS NULL

          SET @SQLError = @@ERROR
          IF @SQLError <> 0 GOTO ABORT

          -- Insert into Wrk Table All Item Site Records that need there Standard Costs updated.
          INSERT INTO #WrkITEMSITE (InvtID,SiteID,RevAmt,InvtAcct,InvtSub,InvtAcct2,InvtSub2)
          SELECT I.InvtID, I.SiteID,
                 RevAmt = CASE WHEN w.InvtType <> 'C'
                               THEN ROUND(CONVERT(DEC(28,3),I.QtyOnHand*(ROUND(I.PStdCst-I.StdCost,@DecPlPrcCst))),@BaseDecPl)
                               ELSE ROUND(CONVERT(DEC(28,3),I.QtyOnHand*(ROUND(I.PDirStdCst-I.DirStdCst,@DecPlPrcCst))),@BaseDecPl)
                               END, w.InvtAcct, w.InvtSub, I.InvtAcct, I.InvtSub
            FROM ItemSite I JOIN #WrkKitIDSiteID w
                              ON I.InvtID = w.KitID
                            LEFT OUTER JOIN Kit K
                              ON I.InvtID = K.KitID
                             AND I.SiteID = K.SiteID
                             AND K.Status = 'A'
          WHERE w.SiteID = @BMSetUpGLBSiteID AND I.PStdCst <> 0
            AND (K.KitID IS NULL OR w.SiteID = K.SiteID)

     END
   ELSE
     BEGIN
          -- Insert into Wrk Table All Item Site Records that need there Standard Costs updated.
          INSERT INTO #WrkITEMSITE (InvtID,SiteID,RevAmt,InvtAcct,InvtSub,InvtAcct2,InvtSub2)
          SELECT I.InvtID, I.SiteID,
                 RevAmt = CASE WHEN w.InvtType <> 'C'
                               THEN ROUND(CONVERT(DEC(28,3),I.QtyOnHand*(ROUND(I.PStdCst-I.StdCost,@DecPlPrcCst))),@BaseDecPl)
                               ELSE ROUND(CONVERT(DEC(28,3),I.QtyOnHand*(ROUND(I.PDirStdCst-I.DirStdCst,@DecPlPrcCst))),@BaseDecPl)
                               END, w.InvtAcct, w.InvtSub, I.InvtAcct, I.InvtSub
            FROM ItemSite I JOIN #WrkKitIDSiteID w
                              ON I.InvtID = w.KitID
          WHERE I.PStdCst <> 0
     END

   If @@TranCount = 0
      BEGIN
      --Process
          BEGIN TRAN
      END

   --Update the Standare Costs for Kits
   UPDATE K
      SET CDirLbrCst = K.PDirLbrCst, CDirMatlCst = K.PDirMatlCst, CDirOthCst = K.PDirOthCst,
          CFOvhLbrCst = K.PFOvhLbrCst, CFOvhMachCst = K.PFOvhMachCst, CFOvhMatlCst = K.PFOvhMatlCst,
          CStdCst = K.PStdCst, CVOvhLbrCst = K.PVOvhLbrCst, CVOvhMachCst = K.PVOvhMachCst, CVOvhMatlCst = K.PVOvhMatlCst,
          PDirLbrCst = 0, PDirMatlCst = 0, PDirOthCst = 0, PFOvhLbrCst = 0, PFOvhMachCst = 0, PFOvhMatlCst = 0,
          PStdCst = 0, PVOvhLbrCst = 0, PVOvhMachCst = 0, PVOvhMatlCst = 0,
          Crtd_Prog = CASE WHEN K.Crtd_Prog = '' THEN @ProgID ELSE K.Crtd_Prog END,
          Crtd_User = CASE WHEN K.Crtd_User = '' THEN @UserID ELSE K.Crtd_User END,
          Crtd_DateTime = CASE WHEN K.Crtd_Prog = '' THEN GETDATE() ELSE K.Crtd_DateTime END,
          LUpd_Prog = @ProgID, LUpd_User = @UserID, LUpd_DateTime = GETDATE()
     FROM Kit K JOIN #WrkKitIDSiteID w
                  ON k.KitId = w.KitId
                 AND k.SiteID = w.SiteID

      SET @SQLError = @@ERROR
      IF @SQLError <> 0 GOTO ABORT

   --Update the Standard Cost Inventory Items for the Kits
   UPDATE I
      SET DirStdCost = I.PDirStdCost, FOvhStdCost = I.PFOvhStdCost, StdCost = I.PStdCost, VOvhStdCost = I.PVOvhStdCost,
          PDirStdCost = 0, PFOvhStdCost = 0, PStdCost = 0, PVOvhStdCost = 0,
          Crtd_Prog = CASE WHEN I.Crtd_Prog = '' THEN @ProgID ELSE I.Crtd_Prog END,
          Crtd_User = CASE WHEN I.Crtd_User = '' THEN @UserID ELSE I.Crtd_User END,
          Crtd_DateTime = CASE WHEN I.Crtd_Prog = '' THEN GETDATE() ELSE I.Crtd_DateTime END,
          LUpd_Prog = @ProgID, LUpd_User = @UserID, LUpd_DateTime = GETDATE()
    FROM Inventory I JOIN #WrkKitIDSiteID w
                       ON i.InvtID = w.KitID
   WHERE w.SiteID = @BMSetUpGLBSiteID
     AND I.PStdCost <> 0

   SET @SQLError = @@ERROR
   IF @SQLError <> 0 GOTO ABORT

   -- Update Standard Costs for Routing of Kits.
   UPDATE R
      SET CRDirLbrCst = R.PRDirLbrCst, CRDirOthCst = R.PRDirOthCst, CRFOvhLbrCst = R.PRFOvhLbrCst,
          CRFOvhMachCst = R.PRFOvhMachCst, CRVOvhLbrCst = R.PRVOvhLbrCst, CRVOvhMachCst = R.PRVOvhMachCst,
          CSDirLbrCst = R.PSDirLbrCst, CSDirOthCst = R.PSDirOthCst, CSFOvhLbrCst = R.PSFOvhLbrCst,
          CSFOvhMachCst = R.PSFOvhMachCst, CSVOvhLbrCst = R.PSVOvhLbrCst, CSVOvhMachCst = R.PSVOvhMachCst,
          CStdCst = R.PStdCst,
          PRDirLbrCst = 0, PRDirOthCst = 0, PRFOvhLbrCst = 0,
          PRFOvhMachCst = 0, PRVOvhLbrCst = 0, PRVOvhMachCst = 0,
          PSDirLbrCst = 0, PSDirOthCst = 0, PSFOvhLbrCst = 0,
          PSFOvhMachCst = 0, PSVOvhLbrCst = 0, PSVOvhMachCst = 0, PStdCst = 0,
          Crtd_Prog = CASE WHEN R.Crtd_Prog = '' THEN @ProgID ELSE R.Crtd_Prog END,
          Crtd_User = CASE WHEN R.Crtd_User = '' THEN @UserID ELSE R.Crtd_User END,
          Crtd_DateTime = CASE WHEN R.Crtd_Prog = '' THEN GETDATE() ELSE R.Crtd_DateTime END,
          LUpd_Prog = @ProgID, LUpd_User = @UserID, LUpd_DateTime = GETDATE()
     FROM Routing R JOIN #WrkKitIDSiteID w
                      ON R.KitID = w.KitID
                     AND R.SiteID = w.SiteID
                     AND R.Status = 'A'
    WHERE R.PStdCst <> 0

    SET @SQLError = @@ERROR
    IF @SQLError <> 0 GOTO ABORT
END

--Update Inventory Based off of this Inventory, KitID
IF (@UpdtOpt = 'A' or @UpdtOpt = 'I')
BEGIN
      --Work Table used to determine the Inventory Items that have pending Standard Costs and are not Kits.
      CREATE TABLE #WrkInvtIDSiteID
       (InvtID     VarChar(30)
       ,SiteId     VarChar(10)
       ,InvtType   VarChar(1)
       ,InvtAcct   VarChar(10)
       ,InvtSub    VarChar(24)
       )

      --Insert into the WorkTable any Inventory Item that is a Standard Cost and not a KIT that have pending Standard Costs
      INSERT INTO #WrkInvtIDSiteID (InvtID, SiteID, InvtType, InvtAcct, InvtSub)
      SELECT i.InvtID, s.SiteId, i.InvtType, i.InvtAcct, i.InvtSub
        FROM Inventory i
        Inner JOIN ITEMSITE s
                    ON i.InvtID = s.InvtID
        Inner JOIN Site t
					ON t.SiteId = s.SiteID
        LEFT OUTER JOIN Kit k
                    ON i.InvtID = k.KitID

        WHERE t.CpnyID = @CpnyID
			AND i.InvtId like @InvtIDNoKits
            AND i.ValMthd = 'T'
            AND S.SiteId like @KitSiteID
            AND k.KitID IS NULL
            AND i.TranStatusCode <> 'IN'
            AND (i.PstdCost <> 0 OR EXISTS (SELECT InvtID
                                                FROM ItemSite s
                                                Inner JOIN Site t
													ON s.SiteID = t.SiteId
                                                WHERE t.CpnyID = @CpnyID
													AND s.InvtID = i.InvtID
                                                    AND s.PstdCst <> 0))

      -- Insert into Wrk Table All Item Site Records that need there Standard Costs updated.
      INSERT INTO #WrkITEMSITE (InvtID,SiteID,RevAmt,InvtAcct,InvtSub,InvtAcct2,InvtSub2)
      SELECT I.InvtID, I.SiteID,
             RevAmt = CASE WHEN w.InvtType <> 'C'
                           THEN ROUND(CONVERT(DEC(28,3),I.QtyOnHand*(ROUND(I.PStdCst-I.StdCost,@DecPlPrcCst))),@BaseDecPl)
                           ELSE ROUND(CONVERT(DEC(28,3),I.QtyOnHand*(ROUND(I.PDirStdCst-I.DirStdCst,@DecPlPrcCst))),@BaseDecPl)
                            END, w.InvtAcct, w.InvtSub, I.InvtAcct, I.InvtSub
        FROM ItemSite I JOIN #WrkInvtIDSiteID w
                          ON I.InvtID = w.InvtID
                          AND I.SiteId = w.SiteId
       WHERE I.PStdCst <> 0

      If @@TranCount = 0
         BEGIN
        --Process
            BEGIN TRAN
         END

      --Update the Standard Cost Inventory Items for the Inventory Items that are not Kits (Component Items)
      UPDATE I
        SET DirStdCost = I.PDirStdCost, FOvhStdCost = I.PFOvhStdCost, StdCost = I.PStdCost, VOvhStdCost = I.PVOvhStdCost,StdCostDate = I.PStdCostDate,
             PDirStdCost = 0, PFOvhStdCost = 0, PStdCost = 0, PVOvhStdCost = 0, PStdCostDate = '',
             Crtd_Prog = CASE WHEN I.Crtd_Prog = '' THEN @ProgID ELSE I.Crtd_Prog END,
             Crtd_User = CASE WHEN I.Crtd_User = '' THEN @UserID ELSE I.Crtd_User END,
             Crtd_DateTime = CASE WHEN I.Crtd_Prog = '' THEN GETDATE() ELSE I.Crtd_DateTime END,
             LUpd_Prog = @ProgID, LUpd_User = @UserID, LUpd_DateTime = GETDATE()
       FROM Inventory I JOIN #WrkInvtIDSiteID w
                          ON i.InvtID = w.InvtID
      WHERE I.PStdCost <> 0

      SET @SQLError = @@ERROR
      IF @SQLError <> 0 GOTO ABORT

END

--- Need to Create a Batch Record if we are updating the ItemSite Records
IF (@UpdtOpt = 'A' OR @UpdtOpt = 'I' OR @UpdtOpt = 'K')
BEGIN
   SELECT @COUNT = COUNT(*)
     FROM #WrkITEMSITE
    WHERE RevAmt <> 0

    IF @COUNT > 0
    BEGIN
        --Lock INSetup
        UPDATE INSetup
           SET [Init] = [Init]

        SELECT @LastBatNbr = LastBatNbr, @BatNbr_Len =LEN(LTRIM(LastBatNbr))
          FROM INSetup WITH(NOLOCK)

        ---Get the Whseloc from the Inventory Item being passed in.
        IF (ISNULL(@InvtIDNoKits,'') <> '' AND @InvtIDNoKits <> '%')
        BEGIN
             SELECT @WhseLoc = DfltPutAwayBin
           FROM INDfltSites WITH(NOLOCK)
          WHERE InvtID LIKE @InvtIDNoKits
            AND CpnyID LIKE @CpnyID
        END

       --- If the Inventory Item that was passed in was blank or DftlPutAwayBin was blank in INDfltSite, then set Whseloc to INCpnyDflts.
       IF ISNULL(@WhseLoc,'') = ''
       BEGIN
            SELECT @WhseLoc = DfltPutAwayBin
          FROM INCpnyDfltSites WITH(NOLOCK)
         WHERE CpnyID LIKE @CpnyID
         ORDER BY CpnyID
       END

	    -- If we still do not have a bin location get the bin of the kit since it can not be blank
        IF ISNULL(@WhseLoc,'') = ''  
        BEGIN  
			SELECT @WhseLoc = DfltPutAwayBin  
			FROM INDfltSites WITH(NOLOCK)  
			WHERE InvtID LIKE @KitKitID  
				AND CpnyID LIKE @CpnyID  
        END 

        INCR_BATNBR:
        SET @LastBatNbr = @LastBatNbr + 1
        -- Convert the Last Batch Number into a string with the length equal to defined mask and zero padded on the left.
        SET @BatNbr_Str = RIGHT(REPLICATE('0', @BatNbr_Len) + CAST(@LastBatNbr AS VARCHAR(10)), @BatNbr_Len)

        INSERT INTO Batch
         ( AutoRev, AutoRevCopy, BatNbr, BatType, Descr
         , EditScrnNbr, GlPostOpt, JrnlType, Module, PerEnt
         , PerPost, Rlsed, Status, Crtd_DateTime, Crtd_Prog
         , Crtd_User, Lupd_DateTime, Lupd_Prog, Lupd_User, NbrCycle
         , CrTot, CtrlTot, CuryCrTot
         , CuryCtrlTot, CuryDrtot, DrTot
         , CuryDepositAmt, Cycle, Acct, BalanceType
         , BankAcct, BankSub, BaseCuryID, ClearAmt, Cleared
         , CpnyID, CuryEffDate, CuryID, CuryMultDiv, CuryRate
         , CuryRateType, DateClr, DateEnt, DepositAmt
         , LedgerID, NoteID, OrigBatNbr, origCpnyID, OrigScrnNbr, Sub
         , S4Future01, S4Future02, S4Future03, S4Future04, S4Future05
         , S4Future06, S4Future07, S4Future08, S4Future09, S4Future10
         , S4Future11, S4Future12, User1, User2, User3
         , User4, User5, User6, User7, User8, VOBatNbrForPP
         )
         VALUES( 0, 0, @BatNbr_Str , 'N', ' '
              , '11530', 'D', 'BM', 'IN', @Period
              , @Period, 0, 'S', GETDATE(), @ProgID
              , @UserID, GETDATE(), @ProgID, @UserID, 0
              , 0, 0, 0
              , 0, 0, 0
              , 0, 0, '', 'A'
              , '', '', @BaseCuryID, 0,  0
              , @CpnyId, GETDATE(), @BaseCuryID, 'M', 1.00
              , SPACE(1), '', GETDATE(), 0
              , @LedgerID, 0, '', '', '', ''
              , '', '', 0, 0, 0
              , 0, '', '', 0, 0
              , '', '', '', '', 0
              , 0, '', '', '', '', '')

        SET @SQLError = @@ERROR
        -- SQL Error Number 2627:  Cannot insert duplicate key in object.
        IF  @SQLError = 2627 GOTO INCR_BATNBR
        -- If another error occured.
        IF @SQLError <> 0 GOTO ABORT

        -- Update GLSetup with the Last Batch Number
        UPDATE INSetup
         SET LastBatNbr = @BatNbr_Str
        IF @SQLError <> 0 GOTO ABORT

        --Using the WrkPostBad Table as place to Store the Batch Number, so that we can release the batch later.
        INSERT
          INTO WrkPostBad(BatNbr, Situation, Module, UserAddress)
        VALUES(@BatNbr_Str, 'PENDSTDCST','BM',@UserAddress)

   ---NOW WE NEED TO CREATE IN Transactions...
        INSERT INTRAN (Acct, AcctDist, ARLineId, ARLineRef, BatNbr, BMICuryID, BMIEffDate,
                        BMIExtCost, BMIMultDiv, BMIRate, BMIRtTp, BMITranAmt, BMIUnitPrice,
                       CmmnPct, CnvFact, COGSAcct, COGSsub, CostType, CpnyID,
                       Crtd_DateTime, Crtd_Prog, Crtd_User,
                       DrCr, Excpt, ExtCost, ExtRefNbr, FiscYr,
                       Id, InsuffQty, InvtAcct, InvtId, InvtMult, InvtSub,
                       JrnlType, KitID, LayerType, LineId, LineNbr,
                       LineRef, LotserCntr, LUpd_DateTime, LUpd_Prog, LUpd_User,
                       NoteID, OvrhdAmt, OvrhdFlag, PC_Flag, PC_ID,
    PC_Status, PerEnt, PerPost, ProjectID, Qty,
                        QtyUnCosted, RcptDate, RcptNbr, ReasonCd, RefNbr, Rlsed,
                        S4Future01, S4Future02, S4Future03, S4Future04, S4Future05,
                        S4Future06, S4Future07, S4Future08, S4Future09, S4Future10,
                        S4Future11, S4Future12, ShortQty, SiteId, SlsperId, SpecificCostID,
                        Sub, TaskID, ToSiteID, ToWhseLoc, TranAmt, TranDate, TranDesc,
                        TranType, UnitDesc, UnitMultDiv, UnitPrice, User1, User2, User3,
                        User4, User5, User6, User7, User8, WhseLoc)
        SELECT CASE WHEN ISNULL(T.InvtAcct2,' ') <> ' ' THEN T.InvtAcct2 ELSE T.InvtAcct END,
                    0, 0, '', @BatNbr_Str, '', '',
                0, 'M', 1, '', 0, 0,
               0, 0, '', '', '', @CpnyID,
               GetDate(), @ProgID, @UserID,
               CASE WHEN T.RevAmt >= 0 THEN 'D' ELSE 'C' END, 0, 0, '', SUBSTRING(@PERIOD,1,4),
               '', 0, @StdCstRevalAcct, T.InvtId, CASE WHEN T.RevAmt > 0 THEN 1 ELSE -1 END , @StdCstRevalSub,
               'BM', '', '', T.RecordID + 32768, T.RecordId,
               Right('00000' + Cast ((T.RecordId + 32768) as varchar(5)),5), 0, GetDate(), @ProgID, @UserID,
               0, 0, 0, '', '',
               '', @Period, @Period,'', 0,
                0, '', '', '', '1153UPD', 0,
                '', '', 0, 0, 0,
                 0, '', '', 0, 0,
                 '', '', 0, T.SiteId, '', '',
                CASE WHEN ISNULL(T.InvtSub2,' ') <> ' ' THEN T.InvtSub2 ELSE T.InvtSub END,
                          '', '', '', CASE WHEN T.RevAmt >= 0 THEN T.RevAmt ELSE T.RevAmt * -1 END,
                                    @PesTodayDate, RTRIM(T.InvtID) + ' REVALUATION',
                'AC', '', 'M', 0, '', '', 0,
                0, '', '', '', '', @WhseLoc
          FROM #WrkITEMSITE T
         WHERE T.RevAmt <> 0

          SET @SQLError = @@ERROR
          IF @SQLError <> 0 GOTO ABORT

          UPDATE BATCH SET CrTot = ISNULL((SELECT SUM(TranAmt)
                                     FROM INTran
                                    WHERE Batnbr = @BatNbr_Str AND DRCR = 'C'),0),
                           CuryCrTot = ISNULL((SELECT SUM(TranAmt)
                                     FROM INTran
                                    WHERE Batnbr = @BatNbr_Str AND DRCR = 'C'),0),
                           DrTot = ISNULL((SELECT SUM(TranAmt)
                                     FROM INTran
                                    WHERE Batnbr = @BatNbr_Str AND DRCR = 'D'),0),
                           CuryDrTot = ISNULL((SELECT SUM(TranAmt)
                                     FROM INTran
                                    WHERE Batnbr = @BatNbr_Str AND DRCR = 'D'),0),
                           CtrlTot = ISNULL((SELECT SUM(TranAmt)
                                     FROM INTran
                                    WHERE Batnbr = @BatNbr_Str),0),
                           CuryCtrlTot = ISNULL((SELECT SUM(TranAmt)
                                     FROM INTran
                                    WHERE Batnbr = @BatNbr_Str),0)
          WHERE Batch.BatNbr = @BatNbr_Str AND Batch.Module = 'IN'

          SET @SQLError = @@ERROR
          IF @SQLError <> 0 GOTO ABORT
   END

   UPDATE I
        SET StdCost = I.PStdCst, DirStdCst = I.PDirStdCst, FOvhStdCst = I.PFOvhStdCst, VOvhStdCst = I.PVOvhStdCst,StdCostDate = I.PStdCostDate,
          PStdCst = 0, PDirStdCst = 0, PFOvhStdCst = 0, PVOvhStdCst = 0,PStdCostDate = '',
          Crtd_Prog = CASE WHEN I.Crtd_Prog = '' THEN @ProgID ELSE I.Crtd_Prog END,
          Crtd_User = CASE WHEN I.Crtd_User = '' THEN @UserID ELSE I.Crtd_User END,
          Crtd_DateTime = CASE WHEN I.Crtd_Prog = '' THEN GETDATE() ELSE I.Crtd_DateTime END,
          LUpd_Prog = @ProgID, LUpd_User = @UserID, LUpd_DateTime = GETDATE()
     FROM #WrkITEMSITE w JOIN ItemSite I
                         ON w.InvtID = I.InvtID
                        AND w.SiteID = I.SiteID
    WHERE I.PStdCst <> 0

    SET @SQLError = @@ERROR
    IF @SQLError <> 0 GOTO ABORT
END

If @@TranCount > 0
   BEGIN
        COMMIT TRAN
   END

GOTO FINISH
 ABORT:
    ROLLBACK TRANSACTION

FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[UpdateBMStdCostPendingCpny] TO [MSDSL]
    AS [dbo];


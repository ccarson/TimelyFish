
CREATE PROCEDURE pp_BudgetPosting @Project VarChar(16), @RevId VarChar(4), @PostPeriod VarChar(6), @UserID VarChar(10), 
                                   @ProgID VarChar(8), @CNModule VarChar(1), @UserAddress VarChar(47)
AS

SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

/**
@Project    -- PJREVHDR Project
@RevID      -- PJREVHDR RevID
@PostPeriod -- Altered PJREVHDR PostPeriod
@CNModule   -- Contract Management Registered
**/
DECLARE @MsgTable VARCHAR(20)
DECLARE @MsgID INT

 /** PJREVHDR Variables **/
 Declare @RevisionType VarChar(2)
 Declare @update_type VarChar(1)
 Declare @Change_Order_Num VarChar(16)

 /** PJCONTROL Variables **/
 DECLARE @ContractValueAcct VarChar(16)
 DECLARE @HistoricalBudgeting VarChar(1)
 DECLARE @RevenueAcct VarChar(16)

 /** PJPROJ Variables **/
 Declare @budget_type VarChar(1)

 /** PJBHSSUM Variables **/
 Declare @budget_amount Float
 Declare @projcury_budget_amount Float
 Declare @budget_units Float
 Declare @eac_amount Float
 Declare @projcury_eac_amount Float
 Declare @eac_units Float
 Declare @fac_amount Float
 Declare @projcury_fac_amount Float
 Declare @fac_units Float

 /** PJPTDSUM Variables **/
 Declare @PTDSUMtotal_budget_amount Float
 Declare @PTDSUMprojcury_tot_bud_amt Float
 Declare @PTDSUMtotal_budget_units Float
 Declare @PTDSUMeac_amount Float
 Declare @PTDSUMprojcury_eac_amount Float
 Declare @PTDSUMeac_units Float
 Declare @PTDSUMfac_amount Float
 Declare @PTDSUMprojcury_fac_amount Float
 Declare @PTDSUMfac_units Float

 /** Local Variables **/
 Declare @bh_eac_amount_change Float             --Historical Budgeting
 Declare @bh_projcury_eac_amount_change Float    --Historical Budgeting
 Declare @bh_eac_units_change Float              --Historical Budgeting
 Declare @bh_budget_amount_change Float          --Historical Budgeting
 Declare @bh_projcury_budget_amount_change Float --Historical Budgeting
 Declare @bh_budget_units_change Float           --Historical Budgeting
 Declare @bh_fac_amount_change Float             --Historical Budgeting
 Declare @bh_projcury_fac_amount_change Float    --Historical Budgeting
 Declare @bh_fac_units_change Float              --Historical Budgeting

 Declare @eac_amount_change Float
 Declare @projcury_eac_amount_change Float
 Declare @eac_units_change Float
 Declare @budget_amount_change Float
 Declare @projcury_budget_amount_change Float
 Declare @budget_units_change Float
 Declare @fac_amount_change Float
 Declare @projcury_fac_amount_change Float
 Declare @fac_units_change Float

 Declare @PPResult int
 
 /** PJRevCat_Csr Cursor Variables **/
 Declare @RevCatProject VarChar(16), @RevCatRevId VarChar(4), @RevCatTaskID VarChar(32), @RevCatAcct VarChar(16), @RevCatAmount Float, @RevCatProjCuryAmount Float, @RevCatUnits Float, @RevCatRate Float, @RevCatProjCuryRate Float

 Declare @BasePrecision Int, @ProjCuryPrecision Int, @UnitPrecision Int
 Select @BasePrecision = c.decpl From Currncy c With(NoLock) INNER JOIN GLSetup s With(NoLock) On s.BaseCuryId = c.CuryId

 Select @Msgid = 0, @BasePrecision = ISNULL(@BasePrecision, 2), @UnitPrecision = 2
 
 DELETE WrkBudgetRevPostBad WHERE UserAddress = @UserAddress
  
 SELECT @ContractValueAcct = ISNULL(SUBSTRING(Control_Data, 1, 16), '') 
   FROM PJCONTRL WITH(NOLOCK)
  WHERE control_type = 'PA'  
    AND control_code = 'CONTRACT-VALUE'
 IF @@ERROR <> 0  GOTO FINISH  
   
 SELECT @RevenueAcct = ISNULL(SUBSTRING(Control_Data, 1, 16), '') 
   FROM PJCONTRL WITH(NOLOCK)
  WHERE control_type = 'PA'  
    AND control_code = 'REVENUE'
 IF @@ERROR <> 0  GOTO FINISH    
   
 SELECT @HistoricalBudgeting = ISNULL(SUBSTRING(Control_Data, 1, 1), 'N') 
   FROM PJCONTRL WITH(NOLOCK)
  WHERE control_type = 'PA'  
    AND control_code = 'BUDGET-REV-HISTORY' 
 IF @@ERROR <> 0  GOTO FINISH    
    
 SELECT @RevisionType = RevisionType, @update_type = update_type, @Change_Order_Num = Change_Order_Num
   FROM PJREVHDR WITH(NOLOCK)
  WHERE Project = @Project
    AND RevId = @RevId
 IF @@ERROR <> 0  GOTO FINISH
   
 SELECT @budget_type = PJPROJ.budget_type, @ProjCuryPrecision = COALESCE(Currncy.DecPl, 2)
   FROM PJPROJ WITH(NOLOCK)
   LEFT JOIN Currncy WITH(NOLOCK) ON Currncy.CuryId = PJPROJ.ProjCuryId
  WHERE PJPROJ.project = @Project   
 IF @@ERROR <> 0  GOTO FINISH 
 
 BEGIN TRANSACTION
   
 If @RevisionType = 'CR'
 BEGIN
    --Delete_Budget Code
    /**EAC, PJBUDSUM AND PJBUDROL**/
    If @update_type = 'E' or @update_type = 'B' or @update_type = 'A' 
    Begin 
       Exec PJBUDSUM_dpjtpln @Project, '00'
       Exec pjbudrol_dpjtpln @Project, '00'
    End
  
    /**Original budget, PJBUDSUM AND PJBUDROL**/
    If @update_type = 'O' or @update_type = 'B' or @update_type = 'A' 
    Begin 
       Exec pjbudsum_dpjtpln @Project, ' '
       Exec pjbudrol_dpjtpln @Project, ' '
    End
  
    /**EAC, PJPTDSUM AND PJPTDROL**/
    If @update_type = 'E' or @update_type = 'B' or @update_type = 'A' 
    Begin 
       Exec pjptdsum_upjteac @Project
       Exec pjptdrol_upjteac @Project
    End
  
    /**Original budget, PJPTDSUM AND PJPTDROL**/
    If @update_type = 'O' or @update_type = 'B' or @update_type = 'A' 
    Begin 
       Exec pjptdsum_upjtbud @Project
       Exec pjptdrol_upjtbud @Project
    End
  
    /**Original budget, PJPTDSUM AND PJPTDROL**/
    If @update_type = 'F' or @update_type = 'B'
    Begin 
       Exec pjptdsum_upjtfac @Project
       Exec pjptdrol_upjtfac @Project
    End
   
 END   

 DECLARE PJRevCat_Csr INSENSITIVE CURSOR FOR
    SELECT  project, RevId, pjt_entity, Acct, Amount, ProjCury_Amount, Units, Rate, ProjCury_Rate
      FROM PJREVCAT
     WHERE pjrevcat.project = @Project 
       AND pjrevcat.revid = @RevId
     ORDER BY pjrevcat.project, pjrevcat.revid, pjrevcat.pjt_entity, pjrevcat.acct

 OPEN PJRevCat_Csr
 FETCH PJRevCat_Csr INTO @RevCatProject, @RevCatRevId, @RevCatTaskID, @RevCatAcct, @RevCatAmount, @RevCatProjCuryAmount, @RevCatUnits, @RevCatRate, @RevCatProjCuryRate
  IF @@ERROR <> 0
 BEGIN
    CLOSE PJRevCat_Csr
    DEALLOCATE PJRevCat_Csr
    SET @MsgTable = 'PJREVCAT'
    SET @MsgID = 180
    GOTO ABORT
END

WHILE @@FETCH_STATUS = 0
   BEGIN
   
      --Put Logic here.
      if @CNModule = 'Y' AND @Change_Order_Num <> '' AND @RevCatAcct = @ContractValueAcct
      Begin
         CLOSE PJRevCat_Csr
         DEALLOCATE PJRevCat_Csr
         SET @MsgTable = 'AcctCat'
         SET @MsgID = 337
	     GOTO ABORT
      End
   
       /**  PJREVTSK  **/
       IF (SELECT ISNULL(pjt_entity, '')    
             FROM PJREVTSK
            WHERE project = @RevCatProject 
              AND revid = @RevCatRevId 
              AND pjt_entity = @RevCatTaskID) <> '' 
       BEGIN 
          
          /**  PJPENT  **/
          INSERT PJPENT (contract_type, crtd_datetime, crtd_prog, crtd_user, end_date, 
                  fips_num, labor_class_cd, lupd_datetime, lupd_prog, lupd_user, 
                  manager1, MSPData, MSPInterface, MSPSync, MSPTask_UID, 
                  noteid, opportunityProduct, pe_id01, pe_id02, pe_id03, 
                  pe_id04, pe_id05, pe_id06, pe_id07, pe_id08, 
                  pe_id09, pe_id10, pe_id31, pe_id32, pe_id33, 
                  pe_id34, pe_id35, pe_id36, pe_id37, pe_id38, 
                  pe_id39, pe_id40, pjt_entity, pjt_entity_desc, project, 
                  start_date, status_08, status_09, status_10, status_11, 
                  status_12, status_13, status_14, status_15, status_16, 
                  status_17, status_18, status_19, status_20, status_ap, 
                  status_ar, status_gl, status_in, status_lb, status_pa, 
                  status_po, user1, user2, user3, user4)
          SELECT p.contract_type , GETDATE(), @ProgID, @UserID, t.end_date, 
                  '', '', GETDATE(), @ProgID, @UserID, 
                  '', '', '', '', 0, 
                  0, '', '', '', '', 
                  '', '', 0, 0, '', 
                  '', 0, '', '', '', 
                  '', '', '', '', 0, 
                  '', 0, t.pjt_entity, t.pjt_entity_desc, t.project, 
                  t.start_date, p.status_08, p.status_09, p.status_10, p.status_11, 
                  p.status_12, p.status_13, p.status_14, p.status_15, p.status_16, 
                  p.status_17, p.status_18, p.status_19, p.status_20, p.status_ap, 
                  p.status_ar, p.status_gl, p.status_in, p.status_lb, p.status_pa, 
                  p.status_po, '', '', 0, 0
            FROM PJREVTSK t JOIN PJPROJ p
                              ON t.project = p.project
                            LEFT JOIN PJPENT e
                              ON t.project = e.project
                             AND t.pjt_entity = e.pjt_entity
           WHERE t.project = @RevCatProject
             AND t.revid = @RevCatRevId
             AND t.pjt_entity = @RevCatTaskID
             AND e.project is null
           IF @@ERROR <> 0
           BEGIN
              CLOSE PJRevCat_Csr
              DEALLOCATE PJRevCat_Csr
              SET @MsgTable = 'PJPENT'
              SET @MsgID = 180
              GOTO ABORT
           END
     
           INSERT PJPENTEX(COMPUTED_DATE, COMPUTED_PC, crtd_datetime, crtd_prog, crtd_user, 
                   ENTERED_PC, fee_percent, lupd_datetime, lupd_prog, lupd_user, 
                   NOTEID, PE_ID11, PE_ID12, PE_ID13, PE_ID14, 
                   PE_ID15, PE_ID16, PE_ID17, PE_ID18, PE_ID19, 
                   PE_ID20, PE_ID21, PE_ID22, PE_ID23, PE_ID24, 
                   PE_ID25, PE_ID26, PE_ID27, PE_ID28, PE_ID29, 
                   PE_ID30, PJT_ENTITY, PROJECT, REVISION_DATE)
           SELECT '', 0, GETDATE(), @ProgID, @UserID, 
                   0, 0, GETDATE(), @ProgID, @UserID, 
                   0, '', '', '', '', 
                   '', 0, 0, '', '', 
                   0, '', '', '', '', 
                   '', 0, 0, '', '', 
                   0, t.pjt_entity, t.project, ''
             FROM PJREVTSK t LEFT JOIN PJPENTEX e
                              ON t.project = e.project
                             AND t.pjt_entity = e.pjt_entity
           WHERE t.project = @RevCatProject
             AND t.revid = @RevCatRevId
             AND t.pjt_entity = @RevCatTaskID
             AND e.project is null
           IF @@ERROR <> 0
           BEGIN         
              CLOSE PJRevCat_Csr
              DEALLOCATE PJRevCat_Csr
              SET @MsgTable = 'PJPENTEX'
              SET @MsgID = 180
              GOTO ABORT
           END     
     
           UPDATE p  
              SET p.pjt_entity_desc = CASE WHEN k.pjt_entity_desc <> '' THEN k.pjt_entity_desc ELSE p.pjt_entity_desc END,
                  p.start_date = ISNULL(k.start_date, p.start_date),
                  p.end_date = ISNULL(k.end_date, p.start_date),
                  p.lupd_datetime = GETDATE(), p.lupd_prog = @ProgID, p.lupd_user = @UserID
             FROM PJPENT p JOIN PJREVTSK k
                             ON p.project = k.project
                            AND p.pjt_entity = k.pjt_entity
            WHERE k.project = @RevCatProject
             AND k.revid = @RevCatRevId
             AND k.pjt_entity = @RevCatTaskID
           IF @@ERROR <> 0
           BEGIN   
              CLOSE PJRevCat_Csr
              DEALLOCATE PJRevCat_Csr
              SET @MsgTable = 'PJPENT'
              SET @MsgID = 180
              GOTO ABORT
           END 
      END
     
     --Update Historical Budget tables if Enabled
     if @HistoricalBudgeting = 'Y' AND @budget_type = 'R' 
     BEGIN
     
        /** PJBHSSUM  **/
        INSERT PJBHSSUM (acct, crtd_datetime, crtd_prog, crtd_user, data1, 
                 data2, data3, data4, data5, eac_amount, 
                 eac_units, fac_amount, fac_units, fiscalno, lupd_datetime, 
                 lupd_prog, lupd_user, noteid, pjt_entity, 
                 ProjCury_eac_amount, ProjCury_fac_amount, ProjCury_tot_bud_amt,
                 ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, ProjCuryRate,
                 ProjCuryRateType, project, 
                 total_budget_amount, total_budget_units, user1, user2, user3, user4)               
         SELECT c.acct, GETDATE(), @ProgID, @UserID, '', 
                 0, 0, 0, 0, 0, 
                 0, 0, 0, @PostPeriod, GETDATE(), 
                 @ProgID, @UserID, 0, c.pjt_entity,
                 0, 0, 0,
                 c.ProjCuryEffDate, c.ProjCuryId, c.ProjCuryMultiDiv, c.ProjCuryRate,
                 c.ProjCuryRateType, c.project, 
                 0, 0, '', '', 0, 0
           FROM PJREVCAT c LEFT JOIN PJBHSSUM p
                             ON c.project = p.project
                            AND c.pjt_entity = p.pjt_entity
                            AND c.acct = p.acct
                            AND p.fiscalno = @PostPeriod
         WHERE c.project = @RevCatProject
           AND c.RevId = @RevCatRevId         
           AND c.pjt_entity = @RevCatTaskID
           AND c.Acct = @RevCatAcct
           AND p.project is null
         IF @@ERROR <> 0
         BEGIN
            CLOSE PJRevCat_Csr
            DEALLOCATE PJRevCat_Csr
            SET @MsgTable = 'PJBHSSUM'
            SET @MsgID = 180
            GOTO ABORT
         END
     
        /**  Calculate_Budget_History_Delta BEGIN **/
        SELECT @budget_amount = SUM(total_budget_amount), @projcury_budget_amount = SUM(ProjCury_tot_bud_amt), @budget_units = SUM(total_budget_units), 
               @eac_amount = SUM(eac_amount), @projcury_eac_amount = SUM(ProjCury_eac_amount), @eac_units = SUM(eac_units), 
               @fac_amount = SUM(fac_amount), @projcury_fac_amount = SUM(ProjCury_fac_amount), @fac_units = SUM(fac_units)
          FROM pjbhssum WITH(NOLOCK)
         WHERE project = @RevCatProject AND pjt_entity = @RevCatTaskID AND acct = @RevCatAcct AND fiscalno <= @PostPeriod
         IF @@ERROR <> 0
         BEGIN
            CLOSE PJRevCat_Csr
            DEALLOCATE PJRevCat_Csr
            SET @MsgTable = 'PJBHSSUM'
            SET @MsgID = 100
            GOTO ABORT
         END 
     
	     If @RevisionType = 'NA' 
	     BEGIN
	        If @update_type = 'E' or @update_type = 'B' or @update_type = 'A' 
	        Begin 
               SET @bh_eac_amount_change = ROUND(@RevCatAmount - @eac_amount, @BasePrecision)
               SET @bh_projcury_eac_amount_change = ROUND(@RevCatProjCuryAmount - @projcury_eac_amount, @ProjCuryPrecision)
               SET @bh_eac_units_change = ROUND(@RevCatUnits - @eac_units, @UnitPrecision)
	        End
  
	        If @update_type = 'O' or @update_type = 'B' or @update_type = 'A' 
	        Begin 
               SET @bh_budget_amount_change = ROUND(@RevCatAmount - @budget_amount, @BasePrecision)
               SET @bh_projcury_budget_amount_change = ROUND(@RevCatProjCuryAmount - @projcury_budget_amount, @ProjCuryPrecision)
               SET @bh_budget_units_change = ROUND(@RevCatUnits - @budget_units, @UnitPrecision)
	        End

	        If @update_type = 'F' or @update_type = 'B'
	        Begin 
               SET @bh_fac_amount_change = ROUND(@RevCatAmount - @fac_amount, @BasePrecision)
               SET @bh_projcury_fac_amount_change = ROUND(@RevCatProjCuryAmount - @projcury_fac_amount, @ProjCuryPrecision)
               SET @bh_fac_units_change = ROUND(@RevCatUnits - @fac_units, @UnitPrecision)
	        End
	     
	     END
	     ELSE If @RevisionType = 'NT'
	     BEGIN
	        If @update_type = 'E' or @update_type = 'B' or @update_type = 'A' 
	        Begin 
               SET @bh_eac_amount_change = @RevCatAmount
               SET @bh_projcury_eac_amount_change = @RevCatProjCuryAmount
               SET @bh_eac_units_change = @RevCatUnits
	        End
  
	        If @update_type = 'O' or @update_type = 'B' or @update_type = 'A' 
	        Begin 
               SET @bh_budget_amount_change = @RevCatAmount
               SET @bh_projcury_budget_amount_change = @RevCatProjCuryAmount
               SET @bh_budget_units_change = @RevCatUnits
	        End

	        If @update_type = 'F' or @update_type = 'B'
	        Begin 
               SET @bh_fac_amount_change = @RevCatAmount
               SET @bh_projcury_fac_amount_change = @RevCatProjCuryAmount
               SET @bh_fac_units_change = @RevCatUnits
	        End
	     END 
        /**  Calculate_Budget_History_Delta END **/	     
         
         /** PJBHSSUM  **/                   
         UPDATE PJBHSSUM
            SET eac_amount = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                                  THEN ROUND(eac_amount + @bh_eac_amount_change, @BasePrecision) Else eac_amount END,
                ProjCury_eac_amount = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                                  THEN ROUND(ProjCury_eac_amount + @bh_projcury_eac_amount_change, @ProjCuryPrecision) Else ProjCury_eac_amount END,
                eac_units = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                                 THEN ROUND(eac_units + @bh_eac_units_change, @UnitPrecision) Else eac_units END,
                total_budget_amount = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                           THEN ROUND(total_budget_amount + @bh_budget_amount_change, @BasePrecision) Else total_budget_amount END,
                ProjCury_tot_bud_amt = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                           THEN ROUND(ProjCury_tot_bud_amt + @bh_projcury_budget_amount_change, @ProjCuryPrecision) Else ProjCury_tot_bud_amt END,
                total_budget_units = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                          THEN ROUND(total_budget_units + @bh_budget_units_change, @UnitPrecision) Else total_budget_units END,
                fac_amount = CASE WHEN @update_type = 'F' or @update_type = 'B'
                                  THEN ROUND(fac_amount + @bh_fac_amount_change, @BasePrecision) Else fac_amount END,
                ProjCury_fac_amount = CASE WHEN @update_type = 'F' or @update_type = 'B'
                                  THEN ROUND(ProjCury_fac_amount + @bh_projcury_fac_amount_change, @ProjCuryPrecision) Else ProjCury_fac_amount END,
                fac_units = CASE WHEN @update_type = 'F' or @update_type = 'B'
                                  THEN ROUND(fac_units + @bh_fac_units_change, @UnitPrecision) Else fac_units END,
                lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @UserID
          WHERE project = @RevCatProject
            and pjt_entity = @RevCatTaskID
            and acct = @RevCatAcct
            and fiscalno = @PostPeriod
         IF @@ERROR <> 0
         BEGIN
            CLOSE PJRevCat_Csr
            DEALLOCATE PJRevCat_Csr
            SET @MsgTable = 'PJBHSSUM'
            SET @MsgID = 180
            GOTO ABORT
         END

         /** PJBHSROL **/
         INSERT PJBHSROL (acct, crtd_datetime, crtd_prog, crtd_user, data1,
              data2, data3, data4, data5, eac_amount,
              eac_units, fac_amount, fac_units, fiscalno, lupd_datetime,
              lupd_prog, lupd_user, ProjCury_eac_amount,
              ProjCury_fac_amount, ProjCury_tot_bud_amt,
              ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv,
              ProjCuryRate, ProjCuryRateType,
              project, total_budget_amount, total_budget_units,
              user1, user2, user3, user4)
         SELECT c.acct, GETDATE(), @ProgID, @UserID, '',
              0, 0, 0, 0, 0,
              0, 0, 0, @PostPeriod, GETDATE(),
              @ProgID, @UserID, 0,
              0, 0,
              c.ProjCuryEffDate, c.ProjCuryId, c.ProjCuryMultiDiv,
              c.ProjCuryRate, c.ProjCuryRateType,
              c.project, 0, 0,
              '', '', 0, 0
           FROM PJREVCAT c LEFT JOIN PJBHSROL p
                             ON c.project = p.project
                            AND c.acct = p.acct
                            AND p.fiscalno = @PostPeriod
         WHERE c.project = @RevCatProject
           AND c.RevId = @RevId
           AND c.pjt_entity = @RevCatTaskID
           AND c.Acct = @RevCatAcct
           AND p.project is null
         IF @@ERROR <> 0
         BEGIN
            CLOSE PJRevCat_Csr
            DEALLOCATE PJRevCat_Csr
            SET @MsgTable = 'PJBHSROL'
            SET @MsgID = 180
            GOTO ABORT
         END

         UPDATE PJBHSROL
            SET eac_amount = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                                  THEN ROUND(eac_amount + @bh_eac_amount_change, @BasePrecision) Else eac_amount END,
                ProjCury_eac_amount = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                                  THEN ROUND(ProjCury_eac_amount + @bh_projcury_eac_amount_change, @ProjCuryPrecision) Else ProjCury_eac_amount END,
                eac_units = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                                 THEN ROUND(eac_units + @bh_eac_units_change, @UnitPrecision) Else eac_units END,
                total_budget_amount = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                           THEN ROUND(total_budget_amount + @bh_budget_amount_change, @BasePrecision) Else total_budget_amount END,
                ProjCury_tot_bud_amt = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                           THEN ROUND(ProjCury_tot_bud_amt + @bh_projcury_budget_amount_change, @ProjCuryPrecision) Else ProjCury_tot_bud_amt END,
                total_budget_units = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                          THEN ROUND(total_budget_units + @bh_budget_units_change, @UnitPrecision) Else total_budget_units END,
                fac_amount = CASE WHEN @update_type = 'F' or @update_type = 'B'
                                  THEN ROUND(fac_amount + @bh_fac_amount_change, @BasePrecision) Else fac_amount END,
                ProjCury_fac_amount = CASE WHEN @update_type = 'F' or @update_type = 'B'
                                  THEN ROUND(ProjCury_fac_amount + @bh_projcury_fac_amount_change, @ProjCuryPrecision) Else ProjCury_fac_amount END,
                fac_units = CASE WHEN @update_type = 'F' or @update_type = 'B'
                                  THEN ROUND(fac_units + @bh_fac_units_change, @UnitPrecision) Else fac_units END,
                lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @UserID
          WHERE project = @RevCatProject
            and acct = @RevCatAcct
            and fiscalno = @PostPeriod
         IF @@ERROR <> 0
         BEGIN
            CLOSE PJRevCat_Csr
            DEALLOCATE PJRevCat_Csr
            SET @MsgTable = 'PJBHSROL'
            SET @MsgID = 180
            GOTO ABORT
         END

     END  --@HistoricalBudgeting = 'Y' AND @budget_type = 'R'

     /**  PJPTDSUM    **/
     INSERT PJPTDSUM (acct, act_amount, act_units, com_amount, com_units,
             crtd_datetime, crtd_prog, crtd_user, data1, data2,
             data3, data4, data5, eac_amount, eac_units,
             fac_amount, fac_units, lupd_datetime, lupd_prog, lupd_user,
             noteid, pjt_entity, ProjCury_act_amount, ProjCury_com_amount,
             ProjCury_eac_amount, ProjCury_fac_amount, ProjCury_rate,
             ProjCury_tot_bud_amt, project, rate, total_budget_amount,
             total_budget_units, user1, user2, user3, user4)
      SELECT c.acct, 0, 0, 0, 0,
              GETDATE(), @ProgID, @UserID, '', 0,
              0, 0, 0, 0, 0,
              0, 0, GETDATE(), @ProgID, @UserID,
              0, c.pjt_entity, 0, 0,
              0, 0, c.ProjCury_Rate,
              0, c.project, c.rate, 0,
              0, '', '', 0, 0
        FROM PJREVCAT c LEFT JOIN PJPTDSUM p
                             ON c.project = p.project
                            AND c.pjt_entity = p.pjt_entity
                            AND c.acct = p.acct
         WHERE c.project = @RevCatProject
           AND c.RevId = @RevCatRevId
           AND c.pjt_entity = @RevCatTaskID
           AND c.Acct = @RevCatAcct
           AND p.project is null
     IF @@ERROR <> 0
     BEGIN
        CLOSE PJRevCat_Csr
        DEALLOCATE PJRevCat_Csr
        SET @MsgTable = 'PJPTDSUM'
         SET @MsgID = 180
         GOTO ABORT
     END

     /**  Calculate_Budget_Delta BEGIN **/
     SELECT @PTDSUMeac_amount = eac_amount, @PTDSUMprojcury_eac_amount = ProjCury_eac_amount, @PTDSUMeac_units = eac_units,
            @PTDSUMfac_amount = fac_amount, @PTDSUMprojcury_fac_amount = ProjCury_fac_amount, @PTDSUMfac_units = fac_units,
            @PTDSUMtotal_budget_amount = total_budget_amount, @PTDSUMprojcury_tot_bud_amt = ProjCury_tot_bud_amt, @PTDSUMtotal_budget_units = total_budget_units
       FROM PJPTDSUM
      WHERE project = @RevCatProject
        AND pjt_entity = @RevCatTaskID
        AND acct = @RevCatAcct
      IF @@ERROR <> 0
      BEGIN
         CLOSE PJRevCat_Csr
         DEALLOCATE PJRevCat_Csr
         SET @MsgTable = 'PJPTDSUM'
         SET @MsgID = 180
         GOTO ABORT
      END

     --Historical Budget tables if Enabled
     if @HistoricalBudgeting = 'Y' AND @budget_type = 'R'
     BEGIN
         If @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
         Begin
           SET @eac_amount_change = @bh_eac_amount_change
           SET @projcury_eac_amount_change = @bh_projcury_eac_amount_change
           SET @eac_units_change = @bh_eac_units_change
         End

         If @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
         Begin
           SET @budget_amount_change = @bh_budget_amount_change
           SET @projcury_budget_amount_change = @bh_projcury_budget_amount_change
           SET @budget_units_change = @bh_budget_units_change
         End

         If @update_type = 'F' or @update_type = 'B'
         Begin
           SET @fac_amount_change = @bh_fac_amount_change
           SET @projcury_fac_amount_change = @bh_projcury_fac_amount_change
           SET @fac_units_change = @bh_fac_units_change
         End

     END
     ELSE
     BEGIN
     	 If @RevisionType = 'NA'
	     BEGIN
	        If @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
	        Begin
               SET @eac_amount_change = ROUND(@RevCatAmount - @PTDSUMeac_amount, @BasePrecision)
               SET @projcury_eac_amount_change = ROUND(@RevCatProjCuryAmount - @PTDSUMprojcury_eac_amount, @ProjCuryPrecision)
               SET @eac_units_change = ROUND(@RevCatUnits - @PTDSUMeac_units, @UnitPrecision)
	        End
  
	        If @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
	        Begin
               SET @budget_amount_change = ROUND(@RevCatAmount - @PTDSUMtotal_budget_amount, @BasePrecision)
               SET @projcury_budget_amount_change = ROUND(@RevCatProjCuryAmount - @PTDSUMprojcury_tot_bud_amt, @ProjCuryPrecision)
               SET @budget_units_change = ROUND(@RevCatUnits - @PTDSUMtotal_budget_units, @UnitPrecision)
	        End

	        If @update_type = 'F' or @update_type = 'B'
	        Begin
               SET @fac_amount_change = ROUND(@RevCatAmount - @PTDSUMfac_amount, @BasePrecision)
               SET @projcury_fac_amount_change = ROUND(@RevCatProjCuryAmount - @PTDSUMprojcury_fac_amount, @ProjCuryPrecision)
               SET @fac_units_change = ROUND(@RevCatUnits - @PTDSUMfac_units, @UnitPrecision)
	        End

	     END
	     ELSE If @RevisionType = 'NT' or @RevisionType = 'CR'
	     BEGIN
	        If @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
	        Begin
               SET @eac_amount_change = @RevCatAmount
               SET @projcury_eac_amount_change = @RevCatProjCuryAmount
               SET @eac_units_change = @RevCatUnits
	        End
 
	        If @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
	        Begin
               SET @budget_amount_change = @RevCatAmount
               SET @projcury_budget_amount_change = @RevCatProjCuryAmount
               SET @budget_units_change = @RevCatUnits
	        End

	        If @update_type = 'F' or @update_type = 'B'
	        Begin
               SET @fac_amount_change = @RevCatAmount
               SET @projcury_fac_amount_change = @RevCatProjCuryAmount
               SET @fac_units_change = @RevCatUnits
	        End
	     END
     END    --if @HistoricalBudgeting = 'Y' AND @budget_type = 'R'
     /**  Calculate_Budget_Delta END **/

     /**  PJPTDSUM    **/
     UPDATE PJPTDSUM
        SET eac_amount = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                              THEN ROUND(eac_amount + @eac_amount_change, @BasePrecision) Else eac_amount END,
            ProjCury_eac_amount = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                              THEN ROUND(ProjCury_eac_amount + @projcury_eac_amount_change, @ProjCuryPrecision) Else ProjCury_eac_amount END,
            eac_units = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                             THEN ROUND(eac_units + @eac_units_change, @UnitPrecision) Else eac_units END,
            total_budget_amount = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                       THEN ROUND(total_budget_amount + @budget_amount_change, @BasePrecision) Else total_budget_amount END,
            ProjCury_tot_bud_amt = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                       THEN ROUND(ProjCury_tot_bud_amt + @projcury_budget_amount_change, @ProjCuryPrecision) Else ProjCury_tot_bud_amt END,
            total_budget_units = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                      THEN ROUND(total_budget_units + @budget_units_change, @UnitPrecision) Else total_budget_units END,
            fac_amount = CASE WHEN @update_type = 'F' or @update_type = 'B'
                              THEN ROUND(fac_amount + @fac_amount_change, @BasePrecision) Else fac_amount END,
            ProjCury_fac_amount = CASE WHEN @update_type = 'F' or @update_type = 'B'
                              THEN ROUND(ProjCury_fac_amount + @projcury_fac_amount_change, @ProjCuryPrecision) Else ProjCury_fac_amount END,
            fac_units = CASE WHEN @update_type = 'F' or @update_type = 'B'
                             THEN ROUND(fac_units + @fac_units_change, @UnitPrecision) Else fac_units END,
            rate = @RevCatRate,
            ProjCury_rate = @RevCatProjCuryRate,
            lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @UserID
      WHERE project = @RevCatProject
        AND pjt_entity = @RevCatTaskID
        AND acct = @RevCatAcct
      IF @@ERROR <> 0
      BEGIN
         CLOSE PJRevCat_Csr
         DEALLOCATE PJRevCat_Csr
         SET @MsgTable = 'PJPTDSUM'
         SET @MsgID = 180
         GOTO ABORT
      END

      /**  PJPTDROL    **/
      INSERT PJPTDROL (acct, act_amount, act_units, com_amount, com_units,
                  crtd_datetime, crtd_prog, crtd_user, data1, data2,
                  data3, data4, data5, eac_amount, eac_units,
                  fac_amount, fac_units, lupd_datetime, lupd_prog, lupd_user,
                  ProjCury_act_amount, ProjCury_com_amount, ProjCury_eac_amount,
                  ProjCury_fac_amount, ProjCury_rate, ProjCury_tot_bud_amt,
                  project, rate, total_budget_amount, total_budget_units, user1,
                  user2, user3, user4)
      SELECT c.acct, 0, 0, 0, 0,
              GETDATE(), @ProgID, @UserID, '', 0,
              0, 0, 0, 0, 0,
              0, 0, GETDATE(), @ProgID, @UserID,
              0, 0, 0,
              0, c.ProjCury_Rate, 0,
              c.project, c.rate, 0, 0, '',
              '', 0, 0
        FROM PJREVCAT c LEFT JOIN PJPTDROL p
                          ON c.project = p.project
                         AND c.acct = p.acct
       WHERE c.project = @RevCatProject
         AND c.pjt_entity = @RevCatTaskID
         AND c.RevId = @RevCatRevId
         AND c.Acct = @RevCatAcct
         AND p.project is null
      IF @@ERROR <> 0
      BEGIN
         CLOSE PJRevCat_Csr
         DEALLOCATE PJRevCat_Csr
         SET @MsgTable = 'PJPTDROL'
         SET @MsgID = 180
         GOTO ABORT
      END

      UPDATE PJPTDROL
        SET eac_amount = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                              THEN ROUND(eac_amount + @eac_amount_change, @BasePrecision) Else eac_amount END,
            ProjCury_eac_amount = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                              THEN ROUND(ProjCury_eac_amount + @projcury_eac_amount_change, @ProjCuryPrecision) Else ProjCury_eac_amount END,
            eac_units = CASE WHEN @update_type = 'E' or @update_type = 'B' or @update_type = 'A'
                             THEN ROUND(eac_units + @eac_units_change, @UnitPrecision) Else eac_units END,
            total_budget_amount = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                       THEN ROUND(total_budget_amount + @budget_amount_change, @BasePrecision) Else total_budget_amount END,
            ProjCury_tot_bud_amt = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                       THEN ROUND(ProjCury_tot_bud_amt + @projcury_budget_amount_change, @ProjCuryPrecision) Else ProjCury_tot_bud_amt END,
            total_budget_units = CASE WHEN @update_type = 'B' or @update_type = 'O' or @update_type = 'A'
                                      THEN ROUND(total_budget_units + @budget_units_change, @UnitPrecision) Else total_budget_units END,
            fac_amount = CASE WHEN @update_type = 'F' or @update_type = 'B'
                              THEN ROUND(fac_amount + @fac_amount_change, @BasePrecision) Else fac_amount END,
            ProjCury_fac_amount = CASE WHEN @update_type = 'F' or @update_type = 'B'
                              THEN ROUND(ProjCury_fac_amount + @projcury_fac_amount_change, @ProjCuryPrecision) Else ProjCury_fac_amount END,
            fac_units = CASE WHEN @update_type = 'F' or @update_type = 'B'
                             THEN ROUND(fac_units + @fac_units_change, @UnitPrecision) Else fac_units END,
            lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @UserID
       WHERE project = @RevCatProject
         AND acct = @RevCatAcct
       IF @@ERROR <> 0
       BEGIN
          CLOSE PJRevCat_Csr
          DEALLOCATE PJRevCat_Csr
          SET @MsgTable = 'PJPTDROL'
          SET @MsgID = 180
          GOTO ABORT
       END

      /**  PJCOPROJ    **/
         --Update Pjt Change Order table if this revision has a Change Order.
      if @CNModule = 'Y' AND @Change_Order_Num <> ''
      BEGIN
          UPDATE PJCOPROJ
             SET amt_funded = CASE WHEN @RevCatAcct = @ContractValueAcct THEN ROUND(amt_funded + @RevCatAmount, @BasePrecision) ELSE amt_funded END,
                 ProjCury_amt_funded = CASE WHEN @RevCatAcct = @ContractValueAcct THEN ROUND(ProjCury_amt_funded + @RevCatProjCuryAmount, @ProjCuryPrecision) ELSE ProjCury_amt_funded END,
                 amt_revenue = CASE WHEN @RevCatAcct = @RevenueAcct THEN ROUND(amt_revenue + @RevCatAmount, @BasePrecision) ELSE amt_revenue END,
                 ProjCury_amt_revenue = CASE WHEN @RevCatAcct = @RevenueAcct THEN ROUND(ProjCury_amt_revenue + @RevCatProjCuryAmount, @ProjCuryPrecision) ELSE ProjCury_amt_revenue END,
                 lupd_datetime = GETDATE(), lupd_prog = @ProgID, lupd_user = @UserID   
           WHERE project = @Project
             AND change_order_num = @Change_Order_Num
          IF @@ERROR <> 0
          BEGIN
             CLOSE PJRevCat_Csr
             DEALLOCATE PJRevCat_Csr
             SET @MsgTable = 'PJCOPROJ'
             SET @MsgID = 180
             GOTO ABORT
          END
      END

      /**  PJREVTIM   **/
      EXEC pp_BudgetRevisionBudSumRol @RevCatProject, @RevCatRevId, @RevCatTaskID, @RevCatAcct, @UserID, @ProgID, @update_type, @RevisionType, @BasePrecision, @ProjCuryPrecision, @UnitPrecision, @PPResult OUTPUT
      IF @PPResult <> 0
      BEGIN
         CLOSE PJRevCat_Csr
         DEALLOCATE PJRevCat_Csr
         /**
            @PPResult Values
            200 - PJREVTIM
            300 - PJBUDROL Backout

            2000 - PJBUDSUM
            3000 - PJBUDROL
            4000 - PJBUDSUM Future Summary
            5000 - PJBUDROL Future Summary
         **/
         SET @MsgTable = CASE @PPResult WHEN 200 THEN 'PJREVTIM'
                                        WHEN 300 THEN 'PJBUDROL'
                                        WHEN 2000 THEN 'PJBUDSUM'
                                        WHEN 3000 THEN 'PJBUDROL'
                                        WHEN 4000 THEN 'PJBUDSUM'
                                        WHEN 5000 THEN 'PJBUDROL'                                                                                                                                                                
                         END
         SET @MsgID = 180
         GOTO ABORT
      END

      -- get next record, if any, and loop.
      FETCH PJRevCat_Csr INTO @RevCatProject, @RevCatRevId, @RevCatTaskID, @RevCatAcct, @RevCatAmount, @RevCatProjCuryAmount, @RevCatUnits, @RevCatRate, @RevCatProjCuryRate
      IF @@ERROR <> 0
      BEGIN
         CLOSE PJRevCat_Csr
         DEALLOCATE PJRevCat_Csr
         SET @MsgTable = 'PJREVCAT'
         SET @MsgID = 100
         GOTO ABORT
      END
   END   -- END of WHILE @@FETCH_STATUS = 0 for PJREVCAT

CLOSE PJRevCat_Csr
DEALLOCATE PJRevCat_Csr

UPDATE PJREVHDR
   SET status = 'P', Post_Date = GETDATE(), lupd_datetime = GETDATE(),
   Post_Period = @PostPeriod, lupd_prog = @ProgID, lupd_user = @UserID
 WHERE Project = @Project
   AND RevId = @RevId
 IF @@ERROR <> 0
 BEGIN
   SET @MsgTable = 'PJREVHDR'
   SET @MsgID = 100
   GOTO ABORT
 END

COMMIT TRANSACTION

GOTO FINISH

ABORT:
ROLLBACK TRANSACTION

INSERT WrkBudgetRevPostBad (Project, MsgId, MsgTable, RevId, UserAddress)
VALUES (@Project, @MsgID, @MsgTable, @RevId, @UserAddress)

FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_BudgetPosting] TO [MSDSL]
    AS [dbo];


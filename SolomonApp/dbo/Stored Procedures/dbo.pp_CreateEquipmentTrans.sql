
 CREATE PROCEDURE pp_CreateEquipmentTrans @Project VARCHAR(16), @Task VARCHAR(32), @Acct VARCHAR(16), 
                                          @GL_Acct VARCHAR(10), @GL_Subacct VARCHAR(24),
                                          @DocNbr VARCHAR(10), @LineNbr SmallInt, @Detail_Num INT, @UZPeriod VARCHAR(10),
                                          @gAllocOption VARCHAR(2), @gPostPeriod VARCHAR(6), @PostEquipToGL VARCHAR(1),
                                          @ProgID VARCHAR(8), @SolUser Varchar(10), 
                                          @ProjCury_amount FLOAT, @ProjCurrencyRate FLOAT, @ProjCuryID VARCHAR(4), 
                                          @ProjCuryEffDate SMALLDATETIME, @PPTranResult INT OUTPUT
AS
 
 DECLARE @ERRORNBR INT
                                       
 INSERT PJTran (acct, alloc_flag, amount, BaseCuryId, batch_id, 
                batch_type, bill_batch_id, CpnyId, crtd_datetime, crtd_prog, 
                crtd_user, CuryEffDate, CuryId, CuryMultDiv, CuryRate, 
                CuryRateType, CuryTranamt, data1, 
                detail_num, employee, 
                fiscalno, gl_acct, gl_subacct, lupd_datetime, lupd_prog, 
                lupd_user, noteid, pjt_entity, post_date, project, 
                Subcontract, SubTask_Name, system_cd, trans_date, tr_comment, 
                tr_id01, tr_id02, tr_id03, tr_id04, tr_id05, 
                tr_id06, tr_id07, tr_id08, tr_id09, tr_id10, 
                tr_id23, tr_id24, tr_id25, tr_id26, tr_id27, 
                tr_id28, tr_id29, tr_id30, tr_id31, tr_id32, 
                tr_status, unit_of_measure, units, user1, user2, 
                user3, user4, vendor_num, voucher_line, voucher_num,
                ProjCury_amount, ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, ProjCuryRate,
                ProjCuryRateType, TranProjCuryEffDate, TranProjCuryId, TranProjCuryMultiDiv, 
                TranProjCuryRate, TranProjCuryRateType)       
  SELECT @Acct, CASE SUBSTRING(@gAllocOption,1,1) WHEN 'Y' THEN 'A' ELSE '' END, t.equip_amt, h.BaseCuryId, h.docnbr, 
         'EQ', h.docnbr, t.CpnyId_chrg, GETDATE(), @ProgID, 
         @SolUser, CAST(0x00000000 AS SmallDateTime), h.BaseCuryId, 'M', 1, 
         '', 0, '', 
         @Detail_Num, CASE t.employee WHEN 'NONE' THEN '' ELSE t.employee END, 
         @gPostPeriod, CASE @PostEquipToGL WHEN 'Y' THEN @GL_Acct ELSE '' END, CASE @PostEquipToGL WHEN 'Y' THEN @GL_Subacct ELSE '' END, GETDATE(), @ProgID, 
         @SolUser, 0, @Task, CAST(0x00000000 AS SmallDateTime), @Project, 
         '', t.SubTask_Name, 'TM', t.tl_date, h.th_comment, 
         t.tl_id01, t.tl_id02, t.tl_id03, t.tl_id04, t.tl_id05, 
         t.tl_id06, 0, CAST(0x00000000 AS SmallDateTime), t.tl_id09, t.tl_id10, 
         '', '', '', @UZPeriod, '',       
         0, CAST(0x00000000 AS SmallDateTime), 0, 0, 0, 
         CASE t.tl_id20 WHEN 0 THEN '' ELSE 'N' END, t.equip_uom, t.equip_units, t.user1, t.user2, 
         t.user3, t.user4, '', 0, '',
         @ProjCury_amount, @ProjCuryEffDate, @ProjCuryID , 'M', @ProjCurrencyRate, 
         '', CAST(0x00000000 AS SmallDateTime), '', '', 
         0, ''      
    FROM PJTIMDET t JOIN PJTIMHDR h
                      ON t.docnbr = h.docnbr
   WHERE t.docnbr = @DocNbr
     AND t.linenbr = @LineNbr 
  IF @@ERROR <> 0
     BEGIN
        SET @ERRORNBR = 3000
        GOTO ABORT
     END            

  INSERT PJTRANEX (batch_id, crtd_datetime, crtd_prog, crtd_user, detail_num, 
         equip_id, fiscalno, invtid, lotsernbr, lupd_datetime, 
         lupd_prog, lupd_user, orderlineref, ordnbr, shipperid, 
         shipperlineref, siteid, system_cd, tr_id11, tr_id12, 
         tr_id13, tr_id14, tr_id15, tr_id16, tr_id17, 
         tr_id18, tr_id19, tr_id20, tr_id21, tr_id22, 
         tr_status2, tr_status3, whseloc)

  SELECT t.docnbr, GETDATE(), @ProgID, @SolUser, @Detail_Num, 
         t.equip_id, @gPostPeriod, '', '', GETDATE(), 
         @ProgID, @SolUser, '', '', '', 
         '', '', 'TM', @gPostPeriod + 'TM' + t.docnbr + RIGHT('0000000000' + CAST(@Detail_Num AS VARCHAR(10)), 10), '', 
         '', '', '', '', '', 
         '', '', '', '', CAST(0x00000000 AS SmallDateTime), 
         '', '', ''
    FROM PJTIMDET t 
   WHERE t.docnbr = @DocNbr
     AND t.linenbr = @LineNbr 
  IF @@ERROR <> 0
     BEGIN
        SET @ERRORNBR = 3100
        GOTO ABORT
     END     
  
  IF SUBSTRING(@gAllocOption,1,1) = 'Y'
     BEGIN
        INSERT PJTRANWK (acct, alloc_flag, amount, BaseCuryId, batch_id, 
                         batch_type, bill_batch_id, CpnyId, crtd_datetime, crtd_prog, 
                         crtd_user, CuryEffDate, CuryId, CuryMultDiv, CuryRate, 
                         CuryRateType, CuryTranamt, data1, detail_num, employee, 
                         fiscalno, gl_acct, gl_subacct, lupd_datetime, lupd_prog, 
                         lupd_user, noteid, pjt_entity, post_date, project, 
                         Subcontract, SubTask_Name, system_cd, trans_date, tr_comment, 
                         tr_id01, tr_id02, tr_id03, tr_id04, tr_id05, 
                         tr_id06, tr_id07, tr_id08, tr_id09, tr_id10, 
                         tr_id23, tr_id24, tr_id25, tr_id26, tr_id27, 
                         tr_id28, tr_id29, tr_id30, tr_id31, tr_id32, 
                         tr_status, unit_of_measure, units, user1, user2, 
                         user3, user4, vendor_num, voucher_line, voucher_num, alloc_batch,
                         ProjCury_amount, ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, ProjCuryRate, 
                         ProjCuryRateType, TranProjCuryEffDate, TranProjCuryId, TranProjCuryMultiDiv, 
                         TranProjCuryRate, TranProjCuryRateType)       
        SELECT p.acct, p.alloc_flag, p.amount, p.BaseCuryId, p.batch_id, 
               p.batch_type, p.bill_batch_id, p.CpnyId, p.crtd_datetime, p.crtd_prog, 
               p.crtd_user, p.CuryEffDate, p.CuryId, p.CuryMultDiv, p.CuryRate, 
               p.CuryRateType, p.CuryTranamt, p.data1, p.detail_num, p.employee, 
               p.fiscalno, p.gl_acct, p.gl_subacct, p.lupd_datetime, p.lupd_prog, 
               p.lupd_user, p.noteid, p.pjt_entity, p.post_date, p.project, 
               p.Subcontract, p.SubTask_Name, p.system_cd, p.trans_date, p.tr_comment, 
               p.tr_id01, p.tr_id02, p.tr_id03, p.tr_id04, p.tr_id05, 
               p.tr_id06, p.tr_id07, p.tr_id08, p.tr_id09, p.tr_id10, 
               p.tr_id23, p.tr_id24, p.tr_id25, p.tr_id26, p.tr_id27, 
               p.tr_id28, p.tr_id29, p.tr_id30, p.tr_id31, p.tr_id32, 
               p.tr_status, p.unit_of_measure, p.units, p.user1, p.user2, 
               p.user3, p.user4, p.vendor_num, p.voucher_line, p.voucher_num, ' ',
               p.ProjCury_amount, p.ProjCuryEffDate, p.ProjCuryId, p.ProjCuryMultiDiv, p.ProjCuryRate, 
               p.ProjCuryRateType, p.TranProjCuryEffDate, p.TranProjCuryId, p.TranProjCuryMultiDiv, 
               p.TranProjCuryRate, p.TranProjCuryRateType
          FROM PJTran p WITH(NOLOCK)
         WHERE p.fiscalno = @gPostPeriod
           AND p.system_cd = 'TM'
           AND p.batch_id = @DocNbr
           AND p.detail_num = @Detail_Num
        IF @@ERROR <> 0
           BEGIN
              SET @ERRORNBR = 3200
              GOTO ABORT
           END         
     END
     
 SELECT @PPTranResult = 0
 GOTO FINISH

 ABORT:
 /**
    @ERRORNBR Meanings.
    3000 - PJTran
    4000 - PJTRANEX
    5000 - PJTRANWK 
 **/
 SELECT @PPTranResult = @ERRORNBR

 FINISH:     


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_CreateEquipmentTrans] TO [MSDSL]
    AS [dbo];


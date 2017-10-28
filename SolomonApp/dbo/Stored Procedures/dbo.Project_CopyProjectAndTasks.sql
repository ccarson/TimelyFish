
 CREATE PROCEDURE Project_CopyProjectAndTasks @NewProjectID VARCHAR(16), @CopyProject VARCHAR(16), 
                                   @SolUser Varchar(10), @ProgID VARCHAR(8), @UserAddress VARCHAR(47),
								   @IncludeBudgets Integer, @IncludeProjectTeam Integer,
								   @IncludeProjectMaximums Integer, @IncludeAddress Integer,
								   @IncludeBillingInformation Integer, @IncludeQuickSend Integer,
								   @UserID VARCHAR(47)
AS

SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

DECLARE @MsgTableID    VARCHAR(20)

 DELETE FROM CopyProjectAndTasksBad
 WHERE UserAddress = @UserAddress
 IF @@ERROR <> 0  GOTO FINISH

 BEGIN TRANSACTION

 INSERT PJPROJ (alloc_method_cd, alloc_method2_cd, BaseCuryId, bf_values_switch, billcuryfixedrate, 
     billcuryid, billing_setup, billratetypeid, budget_type, budget_version, 
     contract, contract_type, CpnyId, crtd_datetime, crtd_prog, 
     crtd_user, CuryId, CuryRateType, customer, end_date, 
     gl_subacct, labor_gl_acct, lupd_datetime, lupd_prog, lupd_user, 
     manager1, manager2, MSPData, MSPInterface, MSPProj_ID, 
     noteid, opportunityID, pm_id01, pm_id02, pm_id03, 
     pm_id04, pm_id05, pm_id06, pm_id07, pm_id08, 
     pm_id09, pm_id10, pm_id31, pm_id32, pm_id33, 
     pm_id34, pm_id35, pm_id36, pm_id37, pm_id38, 
     pm_id39, pm_id40, probability, ProjCuryId, ProjCuryRateType, 
     ProjCuryBudEffDate, ProjCuryBudMultiDiv, ProjCuryBudRate, ProjCuryRevenueRec, project, 
     project_desc, purchase_order_num, rate_table_id, shiptoid, slsperid, 
     start_date, status_08, status_09, status_10, status_11, 
     status_12, status_13, status_14, status_15, status_16, 
     status_17, status_18, status_19, status_20, status_ap, 
     status_ar, status_gl, status_in, status_lb, status_pa, 
     status_po, user1, user2, user3, user4)
SELECT alloc_method_cd, alloc_method2_cd, BaseCuryId, bf_values_switch, billcuryfixedrate, 
       billcuryid, billing_setup, billratetypeid, budget_type, budget_version, 
     contract, contract_type, CpnyId, GETDATE(), @ProgID, 
     @SolUser, CuryId, CuryRateType, customer, end_date, 
     gl_subacct, labor_gl_acct, GETDATE(), @ProgID, @SolUser, 
     manager1, manager2, MSPData, MSPInterface, MSPProj_ID, 
     noteid, opportunityID, pm_id01, pm_id02, pm_id03, 
     pm_id04, pm_id05, pm_id06, pm_id07, pm_id08, 
     pm_id09, pm_id10, pm_id31, pm_id32, pm_id33, 
     pm_id34, pm_id35, pm_id36, pm_id37, pm_id38, 
     pm_id39, pm_id40, probability, ProjCuryId, ProjCuryRateType, 
     ProjCuryBudEffDate, ProjCuryBudMultiDiv, ProjCuryBudRate, ProjCuryRevenueRec, @NewProjectID, 
     project_desc, purchase_order_num, rate_table_id, shiptoid, slsperid, 
     start_date, status_08, status_09, status_10, status_11, 
     status_12, status_13, status_14, status_15, status_16, 
     status_17, status_18, status_19, status_20, status_ap, 
     status_ar, status_gl, status_in, status_lb, status_pa, 
     status_po, user1, user2, user3, user4
 FROM PJPROJ 
WHERE PJPROJ.project = @CopyProject
IF @@ERROR <> 0
    BEGIN
	SET @MsgTableID   = 'PJPROJ'
      GOTO ABORT
    END

  INSERT PJPROJEX (computed_date, computed_pc, crtd_datetime, crtd_prog, crtd_user, 
       entered_pc, fee_percent, lupd_datetime, lupd_prog, lupd_user, 
       noteid, PM_ID11, PM_ID12, PM_ID13, PM_ID14, 
       PM_ID15, PM_ID16, PM_ID17, PM_ID18, PM_ID19, 
       PM_ID20, PM_ID21, PM_ID22, PM_ID23, PM_ID24, 
       PM_ID25, PM_ID26, PM_ID27, PM_ID28, PM_ID29, 
       PM_ID30, proj_date1, proj_date2, proj_date3, proj_date4, 
       project, rate_table_labor, revision_date, rev_flag, rev_type, 
       work_comp_cd, work_location)
	   SELECT computed_date, 0, GETDATE(), @ProgID, @SolUser, 
       0, fee_percent, GETDATE(), @ProgID, @SolUser, 
       noteid, PM_ID11, PM_ID12, PM_ID13, PM_ID14, 
       PM_ID15, PM_ID16, PM_ID17, PM_ID18, PM_ID19, 
       0, PM_ID21, PM_ID22, PM_ID23, PM_ID24, 
       PM_ID25, PM_ID26, PM_ID27, PM_ID28, PM_ID29, 
       PM_ID30, proj_date1, proj_date2, proj_date3, proj_date4, 
       @NewProjectID, rate_table_labor, revision_date, rev_flag, rev_type, 
       work_comp_cd, work_location
	     FROM PJPROJEX
	   WHERE PJPROJEX.project = @CopyProject

	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJPROJEX'
         GOTO ABORT
       END

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
	   SELECT   contract_type, GETDATE(), @ProgID, @SolUser, end_date, 
       fips_num, labor_class_cd, GETDATE(), @ProgID, @SolUser, 
       manager1, SPACE(0), MSPInterface, SPACE(0), 0, 
       0, opportunityProduct, pe_id01, pe_id02, pe_id03, 
       pe_id04, pe_id05, pe_id06, pe_id07, pe_id08, 
       pe_id09, pe_id10, SPACE(0), SPACE(0), SPACE(0), 
       SPACE(0), pe_id35, pe_id36, SPACE(0), 0, 
       pe_id39, pe_id40, pjt_entity, pjt_entity_desc, @NewProjectID, 
       start_date, status_08, SPACE(0), SPACE(0), SPACE(0), 
       SPACE(0), SPACE(0), SPACE(0), SPACE(0), SPACE(0), 
       SPACE(0), SPACE(0), SPACE(0), SPACE(0), status_ap, 
       status_ar, status_gl, status_in, status_lb, status_pa, 
       status_po, SPACE(0), SPACE(0), 0, 0
         FROM PJPENT
	   WHERE PJPENT.project = @CopyProject

	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJPENT'
         GOTO ABORT
       END

  INSERT PJPENTEX (COMPUTED_DATE, COMPUTED_PC, crtd_datetime, crtd_prog, crtd_user, 
       ENTERED_PC, fee_percent, lupd_datetime, lupd_prog, lupd_user, 
       NOTEID, PE_ID11, PE_ID12, PE_ID13, PE_ID14, 
       PE_ID15, PE_ID16, PE_ID17, PE_ID18, PE_ID19, 
       PE_ID20, PE_ID21, PE_ID22, PE_ID23, PE_ID24, 
       PE_ID25, PE_ID26, PE_ID27, PE_ID28, PE_ID29, 
       PE_ID30, PJT_ENTITY, PROJECT, REVISION_DATE)
	   SELECT COMPUTED_DATE, 0, GETDATE(), @ProgID, @SolUser, 
       0, fee_percent, GETDATE(), @ProgID, @SolUser, 
       0, SPACE(0), PE_ID12, PE_ID13, PE_ID14, 
       SPACE(0), 0, 0, PE_ID18, PE_ID19, 
       0, PE_ID21, PE_ID22, PE_ID23, SPACE(0), 
       PE_ID25, 0, 0, PE_ID28, PE_ID29, 
       0, PJT_ENTITY, @NewProjectID, REVISION_DATE
         FROM PJPENTEX
	   WHERE PJPENTEX.PROJECT = @CopyProject

	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJPENTEX'
         GOTO ABORT
       END

IF @IncludeBudgets = 1
   BEGIN
      INSERT PJPTDROL (acct, act_amount, act_units, com_amount, com_units, 
       crtd_datetime, crtd_prog, crtd_user, data1, data2, 
        data3, data4, data5, eac_amount, eac_units, 
       fac_amount, fac_units, lupd_datetime, lupd_prog, lupd_user, 
       ProjCury_act_amount, ProjCury_com_amount, ProjCury_eac_amount, ProjCury_fac_amount, ProjCury_rate, 
       ProjCury_tot_bud_amt, project, rate, total_budget_amount, total_budget_units, 
       user1, user2, user3, user4)
	  SELECT acct, 0, 0, 0, 0, 
       GETDATE(), @ProgID, @SolUser, data1, data2, 
       data3, data4, data5, eac_amount, eac_units, 
       fac_amount, fac_units, GETDATE(), @ProgID, @SolUser, 
       ProjCury_act_amount, ProjCury_com_amount, ProjCury_eac_amount, ProjCury_fac_amount, ProjCury_rate, 
       ProjCury_tot_bud_amt, @NewProjectID, rate, total_budget_amount, total_budget_units, 
       SPACE(0), SPACE(0), 0, 0
	    FROM PJPTDROL
	  WHERE PJPTDROL.project = @CopyProject
      IF @@ERROR <> 0
      BEGIN
	  	  SET @MsgTableID   = 'PJPTDROL'
         GOTO ABORT
       END
    INSERT PJPTDSUM (acct, act_amount, act_units, com_amount, com_units, 
       crtd_datetime, crtd_prog, crtd_user, data1, data2, 
       data3, data4, data5, eac_amount, eac_units, 
       fac_amount, fac_units, lupd_datetime, lupd_prog, lupd_user, 
       noteid, pjt_entity, ProjCury_act_amount, ProjCury_com_amount, ProjCury_eac_amount, 
       ProjCury_fac_amount, ProjCury_rate, ProjCury_tot_bud_amt, project, rate, 
       total_budget_amount, total_budget_units, user1, user2, user3, 
       user4)
	   SELECT acct, 0, 0, 0, 0, 
       GETDATE(), @ProgID, @SolUser, data1, data2, 
       data3, data4, data5, eac_amount, eac_units, 
       fac_amount, fac_units, GETDATE(), @ProgID, @SolUser, 
       noteid, pjt_entity, ProjCury_act_amount, ProjCury_com_amount, ProjCury_eac_amount, 
       ProjCury_fac_amount, ProjCury_rate, ProjCury_tot_bud_amt, @NewProjectID, rate, 
       total_budget_amount, total_budget_units, SPACE(0), SPACE(0), 0, 
       0
	     FROM PJPTDSUM 
	   WHERE PJPTDSUM.project = @CopyProject
	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJPTDSUM'
         GOTO ABORT
       END
   END

IF @IncludeProjectTeam = 1
   BEGIN
     INSERT PJPROJEM (access_data1, access_data2, access_insert, access_update, access_view, 
       crtd_datetime, crtd_prog, crtd_user, employee, labor_class_cd, 
       lupd_datetime, lupd_prog, lupd_user, noteid, project, 
       pv_id01, pv_id02, pv_id03, pv_id04, pv_id05, 
       pv_id06, pv_id07, pv_id08, pv_id09, pv_id10, 
       user1, user2, user3, user4)
	   SELECT access_data1, access_data2, access_insert, access_update, access_view, 
       GETDATE(), @ProgID, @SolUser, employee, labor_class_cd, 
       GETDATE(), @ProgID, @SolUser, noteid, @NewProjectID, 
       pv_id01, pv_id02, pv_id03, pv_id04, pv_id05, 
       pv_id06, pv_id07, pv_id08, pv_id09, pv_id10, 
       user1, user2, user3, user4
	     FROM PJPROJEM
	   WHERE PJPROJEM.project = @CopyProject

	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJPROJEM'
         GOTO ABORT
       END
    END

IF @IncludeProjectMaximums = 1
   BEGIN
     INSERT PJPROJMX (acct, acct_billing, acct_overmax, acct_overmax_offset, crtd_datetime, 
       crtd_prog, crtd_user, gl_acct_overmax, gl_acct_offset, lupd_datetime, 
       lupd_prog, lupd_user, noteid, Max_amount, Max_units, 
       mx_id01, mx_id02, mx_id03, mx_id04, mx_id05, 
       mx_id06, mx_id07, mx_id08, mx_id09, mx_id10, 
       pjt_entity, ProjCury_Max_amount, ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, 
       ProjCuryRate, ProjCuryRateType, project, user1, user2, 
       user3, user4)
	   SELECT acct, acct_billing, acct_overmax, acct_overmax_offset, GETDATE(), 
       @ProgID, @SolUser, gl_acct_overmax, gl_acct_offset, GETDATE(), 
       @ProgID, @SolUser, noteid, Max_amount, Max_units, 
       mx_id01, mx_id02, mx_id03, mx_id04, mx_id05, 
       mx_id06, mx_id07, mx_id08, mx_id09, mx_id10, 
       pjt_entity, ProjCury_Max_amount, ProjCuryEffDate, ProjCuryId, ProjCuryMultiDiv, 
       ProjCuryRate, ProjCuryRateType, @NewProjectID, user1, user2, 
       user3, user4
	     FROM PJPROJMX
	   WHERE PJPROJMX.project = @CopyProject
	 
	 IF @@ERROR <> 0
      BEGIN
	  	  SET @MsgTableID   = 'PJPROJMX'
         GOTO ABORT
       END
   END

IF @IncludeBillingInformation = 1
   BEGIN
     INSERT PJBILL (approval_sw, approver, BillCuryId, biller, billings_cycle_cd, 
       billings_level, bill_type_cd, copy_num, crtd_datetime, crtd_prog, 
       crtd_user, curyratetype, date_print_cd, fips_num, inv_attach_cd, 
       inv_format_cd, last_bill_date, lupd_datetime, lupd_prog, lupd_user, 
       noteid, pb_id01, pb_id02, pb_id03, pb_id04, 
       pb_id05, pb_id06, pb_id07, pb_id08, pb_id09, 
       pb_id10, pb_id11, pb_id12, pb_id13, pb_id14, 
       pb_id15, pb_id16, pb_id17, pb_id18, pb_id19, 
       pb_id20, project, project_billwith, retention_method, retention_percent, 
       user1, user2, user3, user4)
	   SELECT approval_sw, approver, BillCuryId, biller, billings_cycle_cd, 
       billings_level, bill_type_cd, copy_num, GETDATE(), @ProgID, 
       @SolUser, curyratetype, date_print_cd, fips_num, inv_attach_cd, 
       inv_format_cd, last_bill_date, GETDATE(), @ProgID, @SolUser, 
       noteid, pb_id01, pb_id02, pb_id03, pb_id04, 
       pb_id05, pb_id06, pb_id07, pb_id08, pb_id09, 
       pb_id10, pb_id11, pb_id12, pb_id13, pb_id14, 
       pb_id15, pb_id16, pb_id17, pb_id18, pb_id19, 
       pb_id20, @NewProjectID, project_billwith, retention_method, retention_percent, 
       user1, user2, user3, user4
	     FROM PJBILL
	   WHERE PJBILL.project = @CopyProject

	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJBILL'
         GOTO ABORT
       END

   END

IF @IncludeAddress = 1
   BEGIN
     INSERT PJADDR (ad_id01, ad_id02, ad_id03, ad_id04, ad_id05, 
       ad_id06, ad_id07, ad_id08, addr_key, addr_key_cd, 
       addr_type_cd, addr1, addr2, city, comp_name, 
       country, crtd_datetime, crtd_prog, crtd_user, email, 
       fax, individual, lupd_datetime, lupd_prog, lupd_user, 
       phone, state, title, zip, user1, 
       user2, user3, user4)
	   SELECT ad_id01, ad_id02, ad_id03, ad_id04, ad_id05, 
       ad_id06, ad_id07, ad_id08, @NewProjectID, addr_key_cd, 
       addr_type_cd, addr1, addr2, city, comp_name, 
       country, GETDATE(), @ProgID, @SolUser, email, 
       fax, individual, GETDATE(), @ProgID, @SolUser, 
       phone, state, title, zip, user1, 
       user2, user3, user4
	     FROM PJADDR
	   WHERE PJADDR.addr_key = @CopyProject
	 
	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJADDR'
         GOTO ABORT
       END
   END

IF @IncludeQuickSend = 1
   BEGIN
     INSERT PJPROJEDD (BodyText, Crtd_DateTime, Crtd_Prog, Crtd_User, DeliveryMethod, 
       DocsDeliveredNbr, DocType, EDD, EDDEmail, EDDFax, 
       EDDFaxPrefix, EDDFaxUseAreaCode, EmailFileType, FaxComment, FaxCover, 
       FaxReceiverName, FaxRecycle, FaxReply, FaxReview, FaxSenderName, 
       FaxSenderNbr, FaxUrgent, LUpd_DateTime, LUpd_Prog, LUpd_User, 
       NoteId, NotifyOptions, PrintOption, Priority, Project, 
       RequestorsEmail, S4Future01, S4Future02, S4Future03, S4Future04, 
       S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, 
       S4Future10, S4Future11, S4Future12, SendersEmail, ShipToID, 
       SubjectText, User1, User2, User3, User4, 
       User5, User6, User7, User8)
	   SELECT BodyText, GETDATE(), @ProgID, @SolUser, DeliveryMethod, 
       DocsDeliveredNbr, DocType, EDD, EDDEmail, EDDFax, 
       EDDFaxPrefix, EDDFaxUseAreaCode, EmailFileType, FaxComment, FaxCover, 
       FaxReceiverName, FaxRecycle, FaxReply, FaxReview, FaxSenderName, 
       FaxSenderNbr, FaxUrgent, GETDATE(), @ProgID, @SolUser, 
       NoteId, NotifyOptions, PrintOption, Priority, @NewProjectID, 
       RequestorsEmail, S4Future01, S4Future02, S4Future03, S4Future04, 
       S4Future05, S4Future06, S4Future07, S4Future08, S4Future09, 
       S4Future10, S4Future11, S4Future12, SendersEmail, ShipToID, 
       SubjectText, User1, User2, User3, User4, 
       User5, User6, User7, User8
         FROM PJPROJEDD
	   WHERE PJPROJEDD.Project = @CopyProject

	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJPROJEDD'
         GOTO ABORT
       END


	  INSERT PJProjEDDReceiver (BodyText, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_user, 
       DeliveryMethod, DocType, EDDEmail, EDDFax, EDDFaxPrefix, 
       EDDFaxUseAreaCode, EmailFileType, FaxComment, FaxCover, FaxReceiverName, 
       FaxRecycle, FaxReply, FaxReview, FaxSenderName, FaxSenderNbr, 
       FaxUrgent, LineNbr, Lupd_DateTime, Lupd_Prog, Lupd_User, 
       NoteID, Priority, PrjMgr, Project, S4Future01, 
       S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, 
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, 
       S4Future12, SendersEmail, SubjectText, UsePrimaryPref, User1, 
       User2, User3, User4, User5, User6, 
       User7, User8)
	   SELECT BodyText, CpnyID, GETDATE(), @ProgID, @SolUser, 
       DeliveryMethod, DocType, EDDEmail, EDDFax, EDDFaxPrefix, 
       EDDFaxUseAreaCode, EmailFileType, FaxComment, FaxCover, FaxReceiverName, 
       FaxRecycle, FaxReply, FaxReview, FaxSenderName, FaxSenderNbr, 
       FaxUrgent, LineNbr, GETDATE(), @ProgID, @SolUser, 
       NoteID, Priority, PrjMgr, @NewProjectID, S4Future01, 
       S4Future02, S4Future03, S4Future04, S4Future05, S4Future06, 
       S4Future07, S4Future08, S4Future09, S4Future10, S4Future11, 
       S4Future12, SendersEmail, SubjectText, UsePrimaryPref, User1, 
       User2, User3, User4, User5, User6, 
       User7, User8
	     FROM PJProjEDDReceiver
	   WHERE PJProjEDDReceiver.Project = @CopyProject

	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJProjEDDReceiver'
         GOTO ABORT
       END

   END

 COMMIT TRANSACTION

 GOTO FINISH

 ABORT:
 ROLLBACK TRANSACTION

 INSERT CopyProjectAndTasksBad (CopyProj, NewProj, TableID,  UserID, UserAddress)
 VALUES (@CopyProject, @NewProjectID,  @MsgTableID, @UserID , @UserAddress)

 FINISH:

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Project_CopyProjectAndTasks] TO [MSDSL]
    AS [dbo];



 CREATE PROCEDURE Project_CopyProjectTasks @NewProjectID VARCHAR(16), @CopyProject VARCHAR(16), 
                                   @SolUser Varchar(10), @ProgID VARCHAR(8), @UserAddress VARCHAR(47),
								   @UserID VARCHAR(47)
AS

SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

DECLARE @MsgTableID    VARCHAR(20)

 DELETE FROM CopyProjectAndTasksBad
 WHERE UserAddress = @UserAddress
 IF @@ERROR <> 0  GOTO FINISH

 BEGIN TRANSACTION
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
	   SELECT i.contract_type, GETDATE(), @ProgID, @SolUser, i.end_date, 
       i.fips_num, i.labor_class_cd, GETDATE(), @ProgID, @SolUser, 
       i.manager1, i.MSPData, i.MSPInterface, i.MSPSync, i.MSPTask_UID, 
       0, i.opportunityProduct, i.pe_id01, i.pe_id02, i.pe_id03, 
       i.pe_id04, i.pe_id05, i.pe_id06, i.pe_id07, i.pe_id08, 
       i.pe_id09, i.pe_id10, SPACE(0), SPACE(0), SPACE(0), 
       SPACE(0), i.pe_id35, i.pe_id36, SPACE(0), 0, 
       CAST(0x00000000 AS SmallDateTime), i.pe_id40, i.pjt_entity, i.pjt_entity_desc, @NewProjectID, 
       i.start_date, i.status_08, i.status_09, i.status_10, i.status_11, 
       i.status_12, i.status_13, i.status_14, i.status_15, i.status_16, 
       i.status_17, i.status_18, i.status_19, i.status_20, i.status_ap, 
       i.status_ar, i.status_gl, i.status_in, i.status_lb, i.status_pa, 
       i.status_po, i.user1, i.user2, i.user3, i.user4
         FROM PJPENT i 
	   WHERE i.project = @CopyProject
	     AND i.pjt_entity NOT IN (Select pjt_entity FROM PJPENT e WHERE e.project = @NewProjectID)
		
	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJPENT'
         GOTO ABORT
       END

	INSERT PJPENTEX(COMPUTED_DATE, COMPUTED_PC, crtd_datetime, crtd_prog, crtd_user, 
       ENTERED_PC, fee_percent, lupd_datetime, lupd_prog, lupd_user, 
       NOTEID, PE_ID11, PE_ID12, PE_ID13, PE_ID14, 
       PE_ID15, PE_ID16, PE_ID17, PE_ID18, PE_ID19, 
       PE_ID20, PE_ID21, PE_ID22, PE_ID23, PE_ID24, 
       PE_ID25, PE_ID26, PE_ID27, PE_ID28, PE_ID29, 
       PE_ID30, PJT_ENTITY, PROJECT, REVISION_DATE)
	   SELECT CAST(0x00000000 AS SmallDateTime), 0, GETDATE(), @ProgID, @SolUser, 
       0, 0, GETDATE(), @ProgID, @SolUser, 
       0, SPACE(0), i.PE_ID12, i.PE_ID13, i.PE_ID14, 
       SPACE(0), 0, 0, CAST(0x00000000 AS SmallDateTime), CAST(0x00000000 AS SmallDateTime), 
       0, i.PE_ID21, i.PE_ID22, i.PE_ID23, SPACE(0), 
       i.PE_ID25, 0, 0, CAST(0x00000000 AS SmallDateTime), CAST(0x00000000 AS SmallDateTime), 
       0, i.PJT_ENTITY, @NewProjectID, i.REVISION_DATE
	     FROM PJPENTEX i 
	   WHERE i.project = @CopyProject
	     AND i.pjt_entity NOT IN (Select pjt_entity FROM PJPENTEX e WHERE e.project = @NewProjectID)				     

	 IF @@ERROR <> 0
      BEGIN
	  SET @MsgTableID   = 'PJPENTEX'
         GOTO ABORT
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
    ON OBJECT::[dbo].[Project_CopyProjectTasks] TO [MSDSL]
    AS [dbo];




CREATE VIEW [dbo].[PJvTask]
AS
SELECT     dbo.PJPENTEX.COMPUTED_DATE, dbo.PJPENT.contract_type, dbo.PJPENT.crtd_datetime, dbo.PJPENTEX.crtd_datetime AS CreatedDateTimeEx, 
                      dbo.PJPENT.crtd_prog, dbo.PJPENTEX.crtd_prog AS CreatedProgramEx, dbo.PJPENT.crtd_user, dbo.PJPENTEX.crtd_user AS CreatedUserEx, dbo.PJPENT.end_date, 
                      dbo.PJPENTEX.ENTERED_PC, dbo.PJPENTEX.fee_percent, dbo.PJPENT.fips_num, dbo.PJPENT.labor_class_cd, dbo.PJPENT.lupd_datetime, 
                      dbo.PJPENTEX.lupd_datetime AS LastUpdatedDateTimeEx, dbo.PJPENT.lupd_prog, dbo.PJPENTEX.lupd_prog AS LastUpdatedProgramEx, dbo.PJPENT.lupd_user, 
                      dbo.PJPENTEX.lupd_user AS LastUpdatedUserEx, dbo.PJPENT.manager1, dbo.PJPENT.MSPInterface, dbo.PJPENT.MSPTask_UID, dbo.PJPENT.noteid, 
                      dbo.PJPENT.opportunityProduct, dbo.PJPENT.pe_id01, dbo.PJPENT.pe_id02, dbo.PJPENT.pe_id03, dbo.PJPENT.pe_id04, dbo.PJPENT.pe_id05, dbo.PJPENT.pe_id06, 
                      dbo.PJPENT.pe_id07, dbo.PJPENT.pe_id08, dbo.PJPENT.pe_id09, dbo.PJPENT.pe_id10, dbo.PJPENTEX.PE_ID12, dbo.PJPENTEX.PE_ID13, dbo.PJPENTEX.PE_ID14, 
                      dbo.PJPENTEX.PE_ID17, dbo.PJPENTEX.PE_ID18, dbo.PJPENTEX.PE_ID19, dbo.PJPENTEX.PE_ID20, dbo.PJPENTEX.PE_ID21, dbo.PJPENTEX.PE_ID23, 
                      dbo.PJPENTEX.PE_ID24, dbo.PJPENTEX.PE_ID25, dbo.PJPENTEX.PE_ID26, dbo.PJPENTEX.PE_ID27, dbo.PJPENTEX.PE_ID28, dbo.PJPENTEX.PE_ID29, 
                      dbo.PJPENTEX.PE_ID30, dbo.PJPENT.pe_id32, dbo.PJPENT.pe_id34, dbo.PJPENT.pe_id35, dbo.PJPENT.pe_id36, dbo.PJPENT.pe_id39, dbo.PJPENT.pe_id40, 
                      dbo.PJPENT.pjt_entity, dbo.PJPENT.pjt_entity_desc, dbo.PJPENT.project, dbo.PJPENTEX.REVISION_DATE, dbo.PJPENT.start_date, dbo.PJPENT.status_08, 
                      dbo.PJPENT.status_ap, dbo.PJPENT.status_ar, dbo.PJPENT.status_gl, dbo.PJPENT.status_in, dbo.PJPENT.status_lb, dbo.PJPENT.status_pa, dbo.PJPENT.status_po, 
                      dbo.PJPENT.user1, dbo.PJPENT.user2, dbo.PJPENT.user3, dbo.PJPENT.user4, dbo.PJPENT.tstamp, dbo.PJPENTEX.tstamp AS TimeStampEx, dbo.PJPENT.MSPData, 
                      dbo.PJPENT.MSPSync, dbo.PJPENT.pe_id31, dbo.PJPENT.pe_id33, dbo.PJPENT.pe_id37, dbo.PJPENT.pe_id38, dbo.PJPENT.status_09, dbo.PJPENT.status_10, 
                      dbo.PJPENT.status_11, dbo.PJPENT.status_12, dbo.PJPENT.status_13, dbo.PJPENT.status_14, dbo.PJPENT.status_15, dbo.PJPENT.status_16, 
                      dbo.PJPENT.status_17, dbo.PJPENT.status_18, dbo.PJPENT.status_19, dbo.PJPENT.status_20, dbo.PJPENTEX.COMPUTED_PC, dbo.PJPENTEX.PE_ID11, 
                      dbo.PJPENTEX.PE_ID15, dbo.PJPENTEX.PE_ID16, dbo.PJPENTEX.PE_ID22
FROM         dbo.PJPENT INNER JOIN
                      dbo.PJPENTEX ON dbo.PJPENT.project = dbo.PJPENTEX.PROJECT AND dbo.PJPENT.pjt_entity = dbo.PJPENTEX.PJT_ENTITY


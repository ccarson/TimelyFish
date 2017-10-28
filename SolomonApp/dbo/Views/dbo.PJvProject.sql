

CREATE VIEW [dbo].[PJvProject]
AS
SELECT     dbo.PJPROJ.alloc_method_cd, dbo.PJPROJ.alloc_method2_cd, dbo.PJPROJ.bf_values_switch, dbo.PJPROJ.billcuryfixedrate, dbo.PJPROJ.billcuryid, 
                      dbo.PJPROJ.billratetypeid, dbo.PJPROJ.budget_type, dbo.PJPROJ.budget_version, dbo.PJPROJEX.computed_date, dbo.PJPROJEX.computed_pc, 
                      dbo.PJPROJ.contract, dbo.PJPROJ.contract_type, dbo.PJPROJ.CpnyId, dbo.PJPROJ.crtd_datetime, dbo.PJPROJEX.crtd_datetime AS CreatedDateTimeEx, 
                      dbo.PJPROJ.crtd_prog, dbo.PJPROJEX.crtd_prog AS CreatedProgramEx, dbo.PJPROJ.crtd_user, dbo.PJPROJEX.crtd_user AS CreatedUserEx, dbo.PJPROJ.CuryId, 
                      dbo.PJPROJ.CuryRateType, dbo.PJPROJ.customer, dbo.PJPROJ.end_date, dbo.PJPROJEX.entered_pc, dbo.PJPROJEX.fee_percent, dbo.PJPROJ.gl_subacct, 
                      dbo.PJPROJ.labor_gl_acct, dbo.PJPROJ.lupd_datetime, dbo.PJPROJEX.lupd_datetime AS LastUpdatedDateTimeEx, dbo.PJPROJ.lupd_prog, 
                      dbo.PJPROJEX.lupd_prog AS LastUpdatedProgramEx, dbo.PJPROJ.lupd_user, dbo.PJPROJEX.lupd_user AS LastUpdatedUserEx, dbo.PJPROJ.manager1, 
                      dbo.PJPROJ.manager2, dbo.PJPROJ.MSPInterface, dbo.PJPROJ.noteid, dbo.PJPROJ.opportunityID, dbo.PJPROJ.pm_id01, dbo.PJPROJ.pm_id02, 
                      dbo.PJPROJ.pm_id03, dbo.PJPROJ.pm_id04, dbo.PJPROJ.pm_id05, dbo.PJPROJ.pm_id06, dbo.PJPROJ.pm_id07, dbo.PJPROJ.pm_id08, dbo.PJPROJ.pm_id09, 
                      dbo.PJPROJ.pm_id10, dbo.PJPROJEX.PM_ID13, dbo.PJPROJEX.PM_ID14, dbo.PJPROJEX.PM_ID15, dbo.PJPROJEX.PM_ID16, dbo.PJPROJEX.PM_ID17, 
                      dbo.PJPROJEX.PM_ID18, dbo.PJPROJEX.PM_ID19, dbo.PJPROJEX.PM_ID24, dbo.PJPROJEX.PM_ID26, dbo.PJPROJEX.PM_ID27, dbo.PJPROJEX.PM_ID28, 
                      dbo.PJPROJEX.PM_ID29, dbo.PJPROJEX.PM_ID30, dbo.PJPROJ.pm_id32, dbo.PJPROJ.pm_id34, dbo.PJPROJ.pm_id36, dbo.PJPROJ.pm_id37, dbo.PJPROJ.pm_id38, 
                      dbo.PJPROJ.pm_id39, dbo.PJPROJ.pm_id40, dbo.PJPROJ.probability, dbo.PJPROJ.project, dbo.PJPROJ.project_desc, dbo.PJPROJEX.proj_date1, 
                      dbo.PJPROJEX.proj_date2, dbo.PJPROJEX.proj_date3, dbo.PJPROJEX.proj_date4, dbo.PJPROJ.purchase_order_num, dbo.PJPROJ.rate_table_id, 
                      dbo.PJPROJEX.rate_table_labor, dbo.PJPROJEX.revision_date, dbo.PJPROJEX.rev_type, dbo.PJPROJ.shiptoid, dbo.PJPROJ.slsperid, dbo.PJPROJ.start_date, 
                      dbo.PJPROJ.status_14, dbo.PJPROJ.status_15, dbo.PJPROJ.status_16, dbo.PJPROJ.status_17, dbo.PJPROJ.status_18, dbo.PJPROJ.status_19, 
                      dbo.PJPROJ.status_20, dbo.PJPROJ.status_ap, dbo.PJPROJ.status_ar, dbo.PJPROJ.status_gl, dbo.PJPROJ.status_in, dbo.PJPROJ.status_lb, dbo.PJPROJ.status_pa, 
                      dbo.PJPROJ.status_po, dbo.PJPROJ.user1, dbo.PJPROJ.user2, dbo.PJPROJ.user3, dbo.PJPROJ.user4, dbo.PJPROJEX.work_comp_cd, dbo.PJPROJEX.work_location, 
                      dbo.PJPROJ.tstamp, dbo.PJPROJEX.tstamp AS TimeStampEx, dbo.PJPROJ.BaseCuryId, dbo.PJPROJ.billing_setup, dbo.PJPROJ.MSPData, dbo.PJPROJ.MSPProj_ID, 
                      dbo.PJPROJ.pm_id31, dbo.PJPROJ.pm_id33, dbo.PJPROJ.pm_id35, dbo.PJPROJ.status_08, dbo.PJPROJ.status_09, dbo.PJPROJ.status_10, dbo.PJPROJ.status_11, 
                      dbo.PJPROJ.status_12, dbo.PJPROJ.status_13, dbo.PJPROJEX.PM_ID11, dbo.PJPROJEX.PM_ID12, dbo.PJPROJEX.PM_ID20, dbo.PJPROJEX.PM_ID21, 
                      dbo.PJPROJEX.PM_ID22, dbo.PJPROJEX.PM_ID23, dbo.PJPROJEX.PM_ID25, dbo.PJPROJEX.rev_flag, dbo.PJPROJ.ProjCuryBudEffDate, 
                      dbo.PJPROJ.ProjCuryBudMultiDiv, dbo.PJPROJ.ProjCuryBudRate, dbo.PJPROJ.ProjCuryId, dbo.PJPROJ.ProjCuryRateType, dbo.PJPROJ.ProjCuryRevenueRec 
FROM         dbo.PJPROJ INNER JOIN
                      dbo.PJPROJEX ON dbo.PJPROJ.project = dbo.PJPROJEX.project


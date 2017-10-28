CREATE PROCEDURE WS_PJPROJ_INSERT
@alloc_method_cd char(4), @alloc_method2_cd char(4), @BaseCuryId char(4), @bf_values_switch char(1), @billcuryfixedrate float, 
@billcuryid char(4), @billing_setup char(1), @billratetypeid char(6), @budget_type char(1), @budget_version char(2), 
@contract char(16), @contract_type char(4), @CpnyId char(10), @crtd_datetime smalldatetime, @crtd_prog char(8), 
@crtd_user char(10), @CuryId char(4), @CuryRateType char(6), @customer char(15), @end_date smalldatetime, @gl_subacct char(24), 
@labor_gl_acct char(10), @lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @manager1 char(10), 
@manager2 char(10), @MSPData char(50), @MSPInterface char(1), @MSPProj_ID int, @noteid int, @opportunityID char(36), 
@pm_id01 char(30), @pm_id02 char(30), @pm_id03 char(16), @pm_id04 char(16), @pm_id05 char(4), @pm_id06 float, @pm_id07 float, 
@pm_id08 smalldatetime, @pm_id09 smalldatetime, @pm_id10 int, @pm_id31 char(30), @pm_id32 char(30), @pm_id33 char(20), 
@pm_id34 char(20), @pm_id35 char(10), @pm_id36 char(10), @pm_id37 char(4), @pm_id38 float, @pm_id39 smalldatetime, 
@pm_id40 int, @probability smallint, 
@ProjCuryId char(4), @ProjCuryRateType char(6), @ProjCuryBudEffDate smalldatetime,
@ProjCuryBudMultiDiv char(1), @ProjCuryBudRate float, @ProjCuryRevenueRec char(1),
@project char(16), @project_desc char(60), @purchase_order_num char(20), 
@rate_table_id char(4), @shiptoid char(10), @slsperid char(10), @start_date smalldatetime, @status_08 char(1), 
@status_09 char(1), @status_10 char(1), @status_11 char(1), @status_12 char(1), @status_13 char(1), @status_14 char(1), 
@status_15 char(1), @status_16 char(1), @status_17 char(1), @status_18 char(1), @status_19 char(1), @status_20 char(1), 
@status_ap char(1), @status_ar char(1), @status_gl char(1), @status_in char(1), @status_lb char(1), @status_pa char(1), 
@status_po char(1), @user1 char(30), @user2 char(30), @user3 float, @user4 float
AS
BEGIN
INSERT INTO [PJPROJ]
([alloc_method_cd], [alloc_method2_cd], [BaseCuryId], [bf_values_switch], [billcuryfixedrate], [billcuryid], [billing_setup], 
[billratetypeid], [budget_type], [budget_version], [contract], [contract_type], [CpnyId], [crtd_datetime], [crtd_prog], 
[crtd_user], [CuryId], [CuryRateType], [customer], [end_date], [gl_subacct], [labor_gl_acct], [lupd_datetime], [lupd_prog], 
[lupd_user], [manager1], [manager2], [MSPData], [MSPInterface], [MSPProj_ID], [noteid], [opportunityID], [pm_id01], [pm_id02], 
[pm_id03], [pm_id04], [pm_id05], [pm_id06], [pm_id07], [pm_id08], [pm_id09], [pm_id10], [pm_id31], [pm_id32], [pm_id33], 
[pm_id34], [pm_id35], [pm_id36], [pm_id37], [pm_id38], [pm_id39], [pm_id40], [probability], 
[ProjCuryId], [ProjCuryRateType], [ProjCuryBudEffDate],
[ProjCuryBudMultiDiv], [ProjCuryBudRate], [ProjCuryRevenueRec],
[project], [project_desc], 
[purchase_order_num], [rate_table_id], [shiptoid], [slsperid], [start_date], [status_08], [status_09], [status_10], [status_11], 
[status_12], [status_13], [status_14], [status_15], [status_16], [status_17], [status_18], [status_19], [status_20], [status_ap], 
[status_ar], [status_gl], [status_in], [status_lb], [status_pa], [status_po], [user1], [user2], [user3], [user4])
VALUES
(@alloc_method_cd, @alloc_method2_cd, @BaseCuryId, @bf_values_switch, @billcuryfixedrate, @billcuryid, @billing_setup, 
@billratetypeid, @budget_type, @budget_version, @contract, @contract_type, @CpnyId, @crtd_datetime, @crtd_prog, @crtd_user, 
@CuryId, @CuryRateType, @customer, @end_date, @gl_subacct, @labor_gl_acct, @lupd_datetime, @lupd_prog, @lupd_user, @manager1, 
@manager2, @MSPData, @MSPInterface, @MSPProj_ID, @noteid, @opportunityID, @pm_id01, @pm_id02, @pm_id03, @pm_id04, @pm_id05, 
@pm_id06, @pm_id07, @pm_id08, @pm_id09, @pm_id10, @pm_id31, @pm_id32, @pm_id33, @pm_id34, @pm_id35, @pm_id36, @pm_id37, @pm_id38, 
@pm_id39, @pm_id40, @probability, 
@ProjCuryId, @ProjCuryRateType, @ProjCuryBudEffDate,
@ProjCuryBudMultiDiv, @ProjCuryBudRate, @ProjCuryRevenueRec,
@project, @project_desc, @purchase_order_num, @rate_table_id, @shiptoid, @slsperid, @start_date, 
@status_08, @status_09, @status_10, @status_11, @status_12, @status_13, @status_14, @status_15, @status_16, @status_17, 
@status_18, @status_19, @status_20, @status_ap, @status_ar, @status_gl, @status_in, @status_lb, @status_pa, @status_po, 
@user1, @user2, @user3, @user4);
END

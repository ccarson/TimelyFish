CREATE PROCEDURE WS_PJPENT_INSERT
@contract_type char(4), @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), @end_date smalldatetime, 
@fips_num char(10), @labor_class_cd char(4), @lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @manager1 char(10), 
@MSPData char(50), @MSPInterface char(1), @MSPSync char(1), @MSPTask_UID int, @noteid int, @opportunityProduct char(36), @pe_id01 char(30), 
@pe_id02 char(30), @pe_id03 char(16), @pe_id04 char(16), @pe_id05 char(4), @pe_id06 float, @pe_id07 float, @pe_id08 smalldatetime, 
@pe_id09 smalldatetime, @pe_id10 int, @pe_id31 char(30), @pe_id32 char(30), @pe_id33 char(20), @pe_id34 char(20), @pe_id35 char(10), 
@pe_id36 char(10), @pe_id37 char(4), @pe_id38 float, @pe_id39 smalldatetime, @pe_id40 int, @pjt_entity char(32), @pjt_entity_desc char(60), 
@project char(16), @start_date smalldatetime, @status_08 char(1), @status_09 char(1), @status_10 char(1), @status_11 char(1), 
@status_12 char(1), @status_13 char(1), @status_14 char(1), @status_15 char(1), @status_16 char(1), @status_17 char(1), 
@status_18 char(1), @status_19 char(1), @status_20 char(1), @status_ap char(1), @status_ar char(1), @status_gl char(1), 
@status_in char(1), @status_lb char(1), @status_pa char(1), @status_po char(1), @user1 char(30), @user2 char(30), @user3 float, @user4 float
AS
BEGIN
INSERT INTO [PJPENT]
([contract_type], [crtd_datetime], [crtd_prog], [crtd_user], [end_date], [fips_num], [labor_class_cd], [lupd_datetime], [lupd_prog], 
[lupd_user], [manager1], [MSPData], [MSPInterface], [MSPSync], [MSPTask_UID], [noteid], [opportunityProduct], [pe_id01], [pe_id02], 
[pe_id03], [pe_id04], [pe_id05], [pe_id06], [pe_id07], [pe_id08], [pe_id09], [pe_id10], [pe_id31], [pe_id32], [pe_id33], [pe_id34], 
[pe_id35], [pe_id36], [pe_id37], [pe_id38], [pe_id39], [pe_id40], [pjt_entity], [pjt_entity_desc], [project], [start_date], [status_08], 
[status_09], [status_10], [status_11], [status_12], [status_13], [status_14], [status_15], [status_16], [status_17], [status_18], 
[status_19], [status_20], [status_ap], [status_ar], [status_gl], [status_in], [status_lb], [status_pa], [status_po], [user1], [user2], 
[user3], [user4])
VALUES
(@contract_type, @crtd_datetime, @crtd_prog, @crtd_user, @end_date, @fips_num, @labor_class_cd, @lupd_datetime, @lupd_prog, @lupd_user, 
@manager1, @MSPData, @MSPInterface, @MSPSync, @MSPTask_UID, @noteid, @opportunityProduct, @pe_id01, @pe_id02, @pe_id03, @pe_id04, @pe_id05, 
@pe_id06, @pe_id07, @pe_id08, @pe_id09, @pe_id10, @pe_id31, @pe_id32, @pe_id33, @pe_id34, @pe_id35, @pe_id36, @pe_id37, @pe_id38, @pe_id39, 
@pe_id40, @pjt_entity, @pjt_entity_desc, @project, @start_date, @status_08, @status_09, @status_10, @status_11, @status_12, @status_13, 
@status_14, @status_15, @status_16, @status_17, @status_18, @status_19, @status_20, @status_ap, @status_ar, @status_gl, @status_in, 
@status_lb, @status_pa, @status_po, @user1, @user2, @user3, @user4);
END

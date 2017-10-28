CREATE PROCEDURE WS_PJBILL_INSERT
@approval_sw char(1), @approver char(10), @BillCuryId char(4), @biller char(10), @billings_cycle_cd char(2), @billings_level char(2), 
@bill_type_cd char(4), @copy_num smallint, @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), @curyratetype char(6), 
@date_print_cd char(2), @fips_num char(10), @inv_attach_cd char(4), @inv_format_cd char(4), @last_bill_date smalldatetime, 
@lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @noteid int, @pb_id01 char(30), @pb_id02 char(30), 
@pb_id03 char(16), @pb_id04 char(16), @pb_id05 char(4), @pb_id06 float, @pb_id07 float, @pb_id08 smalldatetime, @pb_id09 smalldatetime, 
@pb_id10 int, @pb_id11 char(30), @pb_id12 char(30), @pb_id13 char(4), @pb_id14 char(4), @pb_id15 char(4), @pb_id16 char(4), 
@pb_id17 char(2), @pb_id18 char(2), @pb_id19 char(2), @pb_id20 char(2), @project char(16), @project_billwith char(16), 
@retention_method char(2), @retention_percent float, @user1 char(30), @user2 char(30), @user3 float, @user4 float
AS
BEGIN
INSERT INTO [PJBILL]
([approval_sw], [approver], [BillCuryId], [biller], [billings_cycle_cd], [billings_level], [bill_type_cd], [copy_num], 
[crtd_datetime], [crtd_prog], [crtd_user], [curyratetype], [date_print_cd], [fips_num], [inv_attach_cd], [inv_format_cd], 
[last_bill_date], [lupd_datetime], [lupd_prog], [lupd_user], [noteid], [pb_id01], [pb_id02], [pb_id03], [pb_id04], [pb_id05], 
[pb_id06], [pb_id07], [pb_id08], [pb_id09], [pb_id10], [pb_id11], [pb_id12], [pb_id13], [pb_id14], [pb_id15], [pb_id16], [pb_id17], 
[pb_id18], [pb_id19], [pb_id20], [project], [project_billwith], [retention_method], [retention_percent], [user1], [user2], [user3], [user4])
VALUES
(@approval_sw, @approver, @BillCuryId, @biller, @billings_cycle_cd, @billings_level, @bill_type_cd, @copy_num, @crtd_datetime, 
@crtd_prog, @crtd_user, @curyratetype, @date_print_cd, @fips_num, @inv_attach_cd, @inv_format_cd, @last_bill_date, @lupd_datetime, 
@lupd_prog, @lupd_user, @noteid, @pb_id01, @pb_id02, @pb_id03, @pb_id04, @pb_id05, @pb_id06, @pb_id07, @pb_id08, @pb_id09, @pb_id10, 
@pb_id11, @pb_id12, @pb_id13, @pb_id14, @pb_id15, @pb_id16, @pb_id17, @pb_id18, @pb_id19, @pb_id20, @project, @project_billwith, 
@retention_method, @retention_percent, @user1, @user2, @user3, @user4);
END

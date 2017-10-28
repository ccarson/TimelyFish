CREATE PROCEDURE WS_PJPROJEM_INSERT
@access_data1 char(1), @access_data2 char(32), @access_insert char(1), @access_update char(1), @access_view char(1), 
@crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), @employee char(10), @labor_class_cd char(4), 
@lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @noteid int, @project char(16), @pv_id01 char(32), 
@pv_id02 char(32), @pv_id03 char(16), @pv_id04 char(16), @pv_id05 char(4), @pv_id06 float, @pv_id07 float, @pv_id08 smalldatetime, 
@pv_id09 smalldatetime, @pv_id10 int, @user1 char(30), @user2 char(30), @user3 float, @user4 float
AS
BEGIN
INSERT INTO [PJPROJEM]
([access_data1], [access_data2], [access_insert], [access_update], [access_view], [crtd_datetime], [crtd_prog], [crtd_user], 
[employee], [labor_class_cd], [lupd_datetime], [lupd_prog], [lupd_user], [noteid], [project], [pv_id01], [pv_id02], [pv_id03], 
[pv_id04], [pv_id05], [pv_id06], [pv_id07], [pv_id08], [pv_id09], [pv_id10], [user1], [user2], [user3], [user4])
VALUES
(@access_data1, @access_data2, @access_insert, @access_update, @access_view, @crtd_datetime, @crtd_prog, @crtd_user, @employee, 
@labor_class_cd, @lupd_datetime, @lupd_prog, @lupd_user, @noteid, @project, @pv_id01, @pv_id02, @pv_id03, @pv_id04, @pv_id05, 
@pv_id06, @pv_id07, @pv_id08, @pv_id09, @pv_id10, @user1, @user2, @user3, @user4);
END

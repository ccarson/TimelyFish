CREATE PROCEDURE WS_PJPROJEx_INSERT
@computed_date smalldatetime, @computed_pc float, @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), 
@entered_pc float, @fee_percent float, @lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @noteid int, 
@PM_ID11 char(30), @PM_ID12 char(30), @PM_ID13 char(16), @PM_ID14 char(16), @PM_ID15 char(4), @PM_ID16 float, @PM_ID17 float, 
@PM_ID18 smalldatetime, @PM_ID19 smalldatetime, @PM_ID20 int, @PM_ID21 char(30), @PM_ID22 char(30), @PM_ID23 char(16), 
@PM_ID24 char(16), @PM_ID25 char(4), @PM_ID26 float, @PM_ID27 float, @PM_ID28 smalldatetime, @PM_ID29 smalldatetime, 
@PM_ID30 int, @proj_date1 smalldatetime, @proj_date2 smalldatetime, @proj_date3 smalldatetime, @proj_date4 smalldatetime, 
@project char(16), @rate_table_labor char(4), @revision_date smalldatetime, @rev_flag char(1), @rev_type char(2), 
@work_comp_cd char(6), @work_location char(6)
AS
BEGIN
INSERT INTO [PJPROJEX]
([computed_date], [computed_pc], [crtd_datetime], [crtd_prog], [crtd_user], [entered_pc], [fee_percent], [lupd_datetime], 
[lupd_prog], [lupd_user], [noteid], [PM_ID11], [PM_ID12], [PM_ID13], [PM_ID14], [PM_ID15], [PM_ID16], [PM_ID17], [PM_ID18], 
[PM_ID19], [PM_ID20], [PM_ID21], [PM_ID22], [PM_ID23], [PM_ID24], [PM_ID25], [PM_ID26], [PM_ID27], [PM_ID28], [PM_ID29], 
[PM_ID30], [proj_date1], [proj_date2], [proj_date3], [proj_date4], [project], [rate_table_labor], [revision_date], 
[rev_flag], [rev_type], [work_comp_cd], [work_location])
VALUES
(@computed_date, @computed_pc, @crtd_datetime, @crtd_prog, @crtd_user, @entered_pc, @fee_percent, @lupd_datetime, @lupd_prog, 
@lupd_user, @noteid, @PM_ID11, @PM_ID12, @PM_ID13, @PM_ID14, @PM_ID15, @PM_ID16, @PM_ID17, @PM_ID18, @PM_ID19, @PM_ID20, @PM_ID21, 
@PM_ID22, @PM_ID23, @PM_ID24, @PM_ID25, @PM_ID26, @PM_ID27, @PM_ID28, @PM_ID29, @PM_ID30, @proj_date1, @proj_date2, 
@proj_date3, @proj_date4, @project, @rate_table_labor, @revision_date, @rev_flag, @rev_type, @work_comp_cd, @work_location);
End

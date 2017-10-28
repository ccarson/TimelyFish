CREATE PROCEDURE WS_PJPROJMX_INSERT
@acct char(16), @acct_billing char(16), @acct_overmax char(16), @acct_overmax_offset char(16), @crtd_datetime smalldatetime, 
@crtd_prog char(8), @crtd_user char(10), @gl_acct_overmax char(10), @gl_acct_offset char(10), @lupd_datetime smalldatetime, 
@lupd_prog char(8), @lupd_user char(10), @noteid int, @Max_amount float, @Max_units float, @mx_id01 char(30), @mx_id02 char(30), 
@mx_id03 char(16), @mx_id04 char(16), @mx_id05 char(4), @mx_id06 float, @mx_id07 float, @mx_id08 smalldatetime, 
@mx_id09 smalldatetime, @mx_id10 int, @pjt_entity char(32), 
@ProjCury_Max_amount float, @ProjCuryEffDate smalldatetime, @ProjCuryId char(4),
@ProjCuryMultiDiv char(1), @ProjCuryRate float, @ProjCuryRateType char(6),
@project char(16), @user1 char(30), @user2 char(30), 
@user3 float, @user4 float
AS
BEGIN
INSERT INTO [PJPROJMX]
([acct], [acct_billing], [acct_overmax], [acct_overmax_offset], [crtd_datetime], [crtd_prog], [crtd_user], [gl_acct_overmax], 
[gl_acct_offset], [lupd_datetime], [lupd_prog], [lupd_user], [noteid], [Max_amount], [Max_units], [mx_id01], [mx_id02], 
[mx_id03], [mx_id04], [mx_id05], [mx_id06], [mx_id07], [mx_id08], [mx_id09], [mx_id10], [pjt_entity], 
[ProjCury_Max_amount], [ProjCuryEffDate], [ProjCuryId],
[ProjCuryMultiDiv], [ProjCuryRate], [ProjCuryRateType],
[project], [user1], 
[user2], [user3], [user4])
VALUES
(@acct, @acct_billing, @acct_overmax, @acct_overmax_offset, @crtd_datetime, @crtd_prog, @crtd_user, @gl_acct_overmax, 
@gl_acct_offset, @lupd_datetime, @lupd_prog, @lupd_user, @noteid, @Max_amount, @Max_units, @mx_id01, @mx_id02, @mx_id03, 
@mx_id04, @mx_id05, @mx_id06, @mx_id07, @mx_id08, @mx_id09, @mx_id10, @pjt_entity, 
@ProjCury_Max_amount, @ProjCuryEffDate, @ProjCuryId,
@ProjCuryMultiDiv, @ProjCuryRate, @ProjCuryRateType,
@project, @user1, @user2, @user3, @user4);
END

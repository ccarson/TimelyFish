
CREATE PROCEDURE WS_PJREVCAT_INSERT 
	@Acct char(16), @Amount float, @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), @lupd_datetime smalldatetime,
	@lupd_prog char(8), @lupd_user char(10), @NoteId int, @pjt_entity char(32), 
	@ProjCury_Amount float, @ProjCury_Rate float, @ProjCuryEffDate smalldatetime, @ProjCuryId char(4),
    @ProjCuryMultiDiv char(1), @ProjCuryRate float, @ProjCuryRateType char(6),
	@project char(16), @Rate float, @rc_id01 char(30),
	@rc_id02 char(30), @rc_id03 char(16), @rc_id04 char(16), @rc_id05 char(4), @rc_id06 float, @rc_id07 float, @rc_id08 smalldatetime,
	@rc_id09 smalldatetime, @rc_id10 smallint, @RevId char(4), @Units float, @user1 char(30), @user2 char(30), @user3 float, @user4 float,
	@User5 char(10), @User6 char(10), @User7 smalldatetime, @User8 smalldatetime 
AS 
BEGIN 
INSERT INTO [PJREVCAT] 
	([Acct], [Amount], [crtd_datetime], [crtd_prog], [crtd_user], [lupd_datetime], [lupd_prog], [lupd_user], [NoteId], [pjt_entity], 
	 [ProjCury_Amount], [ProjCury_Rate], [ProjCuryEffDate], [ProjCuryId],
     [ProjCuryMultiDiv], [ProjCuryRate], [ProjCuryRateType],
	 [project],
	 [Rate], [rc_id01], [rc_id02], [rc_id03], [rc_id04], [rc_id05], [rc_id06], [rc_id07], [rc_id08], [rc_id09], [rc_id10], [RevId], [Units],
	 [user1], [user2], [user3], [user4], [User5], [User6], [User7], [User8]) 
VALUES (@Acct, @Amount, @crtd_datetime, @crtd_prog, @crtd_user,
	@lupd_datetime, @lupd_prog, @lupd_user, @NoteId, @pjt_entity, 
	@ProjCury_Amount, @ProjCury_Rate, @ProjCuryEffDate, @ProjCuryId,
    @ProjCuryMultiDiv, @ProjCuryRate, @ProjCuryRateType,
	@project, @Rate, @rc_id01, @rc_id02, @rc_id03, @rc_id04, @rc_id05,
	@rc_id06, @rc_id07, @rc_id08, @rc_id09, @rc_id10, @RevId, @Units, @user1, @user2, @user3, @user4, @User5, @User6, @User7, @User8); 
END

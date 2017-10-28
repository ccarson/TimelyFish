CREATE PROCEDURE WS_PJEXPHDR_INSERT
     @advance_amt float, @approver char(10), @BaseCuryId char(4), @CpnyId_home char(10), @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10),
     @CuryEffDate smalldatetime, @CuryId char(4), @CuryMultDiv char(1), @CuryRate float, @CuryRateType char(6), @desc_hdr char(40), @docnbr char(10),
     @employee char(10), @fiscalno char(6), @gl_subacct char(24), @lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @NoteId int,
     @report_date smalldatetime, @status_1 char(1), @status_2 char(1), @te_id01 char(30), @te_id02 char(30), @te_id03 char(16), @te_id04 char(16),
     @te_id05 char(4), @te_id06 float, @te_id07 float, @te_id08 smalldatetime, @te_id09 smalldatetime, @te_id10 int, @te_id11 char(30),
     @te_id12 char(20), @te_id13 char(10), @te_id14 char(4), @te_id15 float, @tripnbr char(10), @user1 char(30), @user2 char(30),
     @user3 float, @user4 float
  AS
     BEGIN
      INSERT INTO [PJEXPHDR]
       ([advance_amt], [approver], [BaseCuryId], [CpnyId_home], [crtd_datetime], [crtd_prog], [crtd_user],
        [CuryEffDate], [CuryId], [CuryMultDiv], [CuryRate], [CuryRateType], [desc_hdr], [docnbr],
        [employee], [fiscalno], [gl_subacct], [lupd_datetime], [lupd_prog], [lupd_user], [NoteId],
        [report_date], [status_1], [status_2], [te_id01], [te_id02], [te_id03], [te_id04],
        [te_id05], [te_id06], [te_id07], [te_id08], [te_id09], [te_id10], [te_id11],
        [te_id12], [te_id13], [te_id14], [te_id15], [tripnbr], [user1], [user2],
        [user3], [user4])
      VALUES
       (@advance_amt, @approver, @BaseCuryId, @CpnyId_home, @crtd_datetime, @crtd_prog, @crtd_user,
        @CuryEffDate, @CuryId, @CuryMultDiv, @CuryRate, @CuryRateType, @desc_hdr, @docnbr,
        @employee, @fiscalno, @gl_subacct, @lupd_datetime, @lupd_prog, @lupd_user, @NoteId,
        @report_date, @status_1, @status_2, @te_id01, @te_id02, @te_id03, @te_id04,
        @te_id05, @te_id06, @te_id07, @te_id08, @te_id09, @te_id10, @te_id11,
        @te_id12, @te_id13, @te_id14, @te_id15, @tripnbr, @user1, @user2,
        @user3, @user4);
     END


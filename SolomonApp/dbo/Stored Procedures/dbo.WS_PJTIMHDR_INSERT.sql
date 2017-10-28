            
CREATE PROCEDURE WS_PJTIMHDR_INSERT 
        @approver char(10),           @BaseCuryId char(4),     @cpnyId char(10),             @crew_cd char(7),
        @crtd_datetime smalldatetime, @crtd_prog char(8),      @crtd_user char(10),          @CuryEffDate smalldatetime,
        @CuryId char(4),              @CuryMultDiv char(1),    @CuryRate float,              @CuryRateType char(6),
        @docnbr char(10),             @end_time char(4),       @lupd_datetime smalldatetime, @lupd_prog char(8),
        @lupd_user char(10),          @multi_emp_sw char(1),   @noteid int,                  @percent_comp float,
        @preparer_id char(10),        @project char(16),       @pjt_entity char(32),         @shift char(7),
        @start_time char(4),          @th_comment char(30),    @th_date smalldatetime,       @th_key char(30),
        @th_id01 char(30),            @th_id02 char(30),       @th_id03 char(20),            @th_id04 char(20),
        @th_id05 char(10),            @th_id06 char(10),       @th_id07 char(4),             @th_id08 float,
        @th_id09 smalldatetime,       @th_id10 int,            @th_id11 char(30),            @th_id12 char(30),
        @th_id13 char(20),            @th_id14 char(20),       @th_id15 char(10),            @th_id16 char(10),
        @th_id17 char(4),             @th_id18 float,          @th_id19 smalldatetime,       @th_id20 int,
        @th_status char(1),           @th_type char(2),        @user1 char(30),              @user2 char(30),
        @user3 float,                 @user4 float
AS
  BEGIN
      INSERT INTO [PJTIMHDR]
		([approver],      [BaseCuryId],   [cpnyId],        [crew_cd],
         [crtd_datetime], [crtd_prog],    [crtd_user],     [CuryEffDate],
         [CuryId],        [CuryMultDiv],  [CuryRate],      [CuryRateType],
         [docnbr],        [end_time],     [lupd_datetime], [lupd_prog],
         [lupd_user],     [multi_emp_sw], [noteid],        [percent_comp],
         [preparer_id],   [project],      [pjt_entity],    [shift],
         [start_time],    [th_comment],   [th_date],       [th_key],
         [th_id01],       [th_id02],      [th_id03],       [th_id04],
         [th_id05],       [th_id06],      [th_id07],       [th_id08],
         [th_id09],       [th_id10],      [th_id11],       [th_id12],
         [th_id13],       [th_id14],      [th_id15],       [th_id16],
         [th_id17],       [th_id18],      [th_id19],       [th_id20],
         [th_status],     [th_type],      [user1],         [user2],
         [user3],         [user4])
      VALUES      
		(@approver,       @BaseCuryId,    @cpnyId,         @crew_cd,
         @crtd_datetime,  @crtd_prog,     @crtd_user,      @CuryEffDate,
         @CuryId,         @CuryMultDiv,   @CuryRate,       @CuryRateType,
         @docnbr,         @end_time,      @lupd_datetime,  @lupd_prog,
         @lupd_user,      @multi_emp_sw,  @noteid,         @percent_comp,
         @preparer_id,    @project,       @pjt_entity,     @shift,
         @start_time,     @th_comment,    @th_date,        @th_key,
         @th_id01,        @th_id02,       @th_id03,        @th_id04,
         @th_id05,        @th_id06,       @th_id07,        @th_id08,
         @th_id09,        @th_id10,       @th_id11,        @th_id12,
         @th_id13,        @th_id14,       @th_id15,        @th_id16,
         @th_id17,        @th_id18,       @th_id19,        @th_id20,
         @th_status,      @th_type,       @user1,          @user2,
         @user3,          @user4);
  END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJTIMHDR_INSERT] TO [MSDSL]
    AS [dbo];


            
CREATE PROCEDURE WS_PJTIMDET_INSERT   
       @cert_pay_sw char(1),         @CpnyId_chrg char(10),         @CpnyId_eq_home char(10),      @CpnyId_home char(10),
       @crtd_datetime smalldatetime, @crtd_prog char(8),            @crtd_user char(10),           @docnbr char(10),
       @earn_type_id char(10),       @employee char(10),            @elapsed_time char(4),         @end_time char(4),
       @equip_amt float,             @equip_home_subacct char(24),  @equip_id char(10),            @equip_rate float,
       @equip_rate_cd char(5),       @equip_rate_indicator char(1), @equip_units float,            @equip_uom char(6),
       @gl_acct char(10),            @gl_subacct char(24),          @group_code char(2),           @labor_amt float,
       @labor_class_cd char(4),      @labor_rate float,             @labor_rate_indicator char(1), @linenbr smallint,
       @lupd_datetime smalldatetime, @lupd_prog char(8),            @lupd_user char(10),           @noteid int,
       @ot1_hours float,             @ot2_hours float,              @pjt_entity char(32),          @project char(16),
       @reg_hours float,             @shift char(7),                @start_time char(4),           @SubTask_Name char(50),
       @tl_date smalldatetime,       @tl_id01 char(30),             @tl_id02 char(30),             @tl_id03 char(20),
       @tl_id04 char(20),            @tl_id05 char(10),             @tl_id06 char(10),             @tl_id07 char(4),
       @tl_id08 float,               @tl_id09 smalldatetime,        @tl_id10 int,                  @tl_id11 char(30),
       @tl_id12 char(30),            @tl_id13 char(20),             @tl_id14 char(20),             @tl_id15 char(10),
       @tl_id16 char(10),            @tl_id17 char(4),              @tl_id18 float,                @tl_id19 smalldatetime,
       @tl_id20 int,                 @tl_status char(1),            @union_cd char(10),            @user1 char(30),
       @user2 char(30),              @user3 float,                  @user4 float,                  @work_comp_cd char(6),
       @work_type char(2)
AS
  BEGIN
      INSERT INTO [PJTIMDET]
		([cert_pay_sw],     [CpnyId_chrg],          [CpnyId_eq_home],       [CpnyId_home],
         [crtd_datetime],   [crtd_prog],            [crtd_user],            [docnbr],
         [earn_type_id],    [employee],             [elapsed_time],         [end_time],
         [equip_amt],       [equip_home_subacct],   [equip_id],             [equip_rate],
         [equip_rate_cd],   [equip_rate_indicator], [equip_units],          [equip_uom],
         [gl_acct],         [gl_subacct],           [group_code],           [labor_amt],
         [labor_class_cd],  [labor_rate],           [labor_rate_indicator], [linenbr],
         [lupd_datetime],   [lupd_prog],            [lupd_user],            [noteid],
         [ot1_hours],       [ot2_hours],            [pjt_entity],           [project],
         [reg_hours],       [shift],                [start_time],           [SubTask_Name],
         [tl_date],         [tl_id01],              [tl_id02],              [tl_id03],
         [tl_id04],         [tl_id05],              [tl_id06],              [tl_id07],
         [tl_id08],         [tl_id09],              [tl_id10],              [tl_id11],
         [tl_id12],         [tl_id13],              [tl_id14],              [tl_id15],
         [tl_id16],         [tl_id17],              [tl_id18],              [tl_id19],
         [tl_id20],         [tl_status],            [union_cd],             [user1],
         [user2],           [user3],                [user4],                [work_comp_cd],
         [work_type])
      VALUES      
		(@cert_pay_sw,      @CpnyId_chrg,          @CpnyId_eq_home,        @CpnyId_home,
         @crtd_datetime,    @crtd_prog,            @crtd_user,             @docnbr,
         @earn_type_id,     @employee,             @elapsed_time,          @end_time,
         @equip_amt,        @equip_home_subacct,   @equip_id,              @equip_rate,
         @equip_rate_cd,    @equip_rate_indicator, @equip_units,           @equip_uom,
         @gl_acct,          @gl_subacct,           @group_code,            @labor_amt,
         @labor_class_cd,   @labor_rate,           @labor_rate_indicator,  @linenbr,
         @lupd_datetime,    @lupd_prog,            @lupd_user,             @noteid,
         @ot1_hours,        @ot2_hours,            @pjt_entity,            @project,
         @reg_hours,        @shift,                @start_time,            @SubTask_Name,
         @tl_date,          @tl_id01,              @tl_id02,               @tl_id03,
         @tl_id04,          @tl_id05,              @tl_id06,               @tl_id07,
         @tl_id08,          @tl_id09,              @tl_id10,               @tl_id11,
         @tl_id12,          @tl_id13,              @tl_id14,               @tl_id15,
         @tl_id16,          @tl_id17,              @tl_id18,               @tl_id19,
         @tl_id20,          @tl_status,            @union_cd,              @user1,
         @user2,            @user3,                @user4,                 @work_comp_cd,
         @work_type);
  END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJTIMDET_INSERT] TO [MSDSL]
    AS [dbo];


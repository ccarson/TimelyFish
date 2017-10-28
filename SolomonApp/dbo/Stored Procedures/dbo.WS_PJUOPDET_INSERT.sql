            
CREATE PROCEDURE WS_PJUOPDET_INSERT   
       @crtd_datetime smalldatetime,  @crtd_prog char(8),           @crtd_user char(10),    @docnbr char(10),
       @linenbr smallint,             @lupd_datetime smalldatetime, @lupd_prog char(8),     @lupd_user char(10),
       @noteid int,                   @percent_comp float,          @pjt_entity char(32),   @prod_units float,
       @prod_uom char(6),             @project char(16),            @up_date smalldatetime, @up_id01 char(30),
       @up_id02 char(30),             @up_id03 char(20),            @up_id04 char(20),      @up_id05 char(10),
       @up_id06 char(10),             @up_id07 char(4),             @up_id08 float,         @up_id09 smalldatetime,
       @up_id10 int,                  @up_id11 char(30),            @up_id12 char(30),      @up_id13 char(20),
       @up_id14 char(20),             @up_id15 char(10),            @up_id16 char(10),      @up_id17 char(4),
       @up_id18 float,                @up_id19 smalldatetime,       @up_id20 int,           @up_status char(1),
       @user1 char(30),               @user2 char(30),              @user3 float,           @user4 float
AS
  BEGIN
      INSERT INTO [PJUOPDET]
		([crtd_datetime],  [crtd_prog],     [crtd_user],   [docnbr],
         [linenbr],        [lupd_datetime], [lupd_prog],   [lupd_user],
         [noteid],         [percent_comp],  [pjt_entity],  [prod_units],
         [prod_uom],       [project],       [up_date],     [up_id01],
         [up_id02],        [up_id03],       [up_id04],     [up_id05],
         [up_id06],        [up_id07],       [up_id08],     [up_id09],
         [up_id10],        [up_id11],       [up_id12],     [up_id13],
         [up_id14],        [up_id15],       [up_id16],     [up_id17],
         [up_id18],        [up_id19],       [up_id20],     [up_status],
         [user1],          [user2],         [user3],       [user4])
      VALUES      
		(@crtd_datetime,   @crtd_prog,     @crtd_user,   @docnbr,
         @linenbr,         @lupd_datetime, @lupd_prog,   @lupd_user,
         @noteid,          @percent_comp,  @pjt_entity,  @prod_units,
         @prod_uom,        @project,       @up_date,     @up_id01,
         @up_id02,         @up_id03,       @up_id04,     @up_id05,
         @up_id06,         @up_id07,       @up_id08,     @up_id09,
         @up_id10,         @up_id11,       @up_id12,     @up_id13,
         @up_id14,         @up_id15,       @up_id16,     @up_id17,
         @up_id18,         @up_id19,       @up_id20,     @up_status,
         @user1,           @user2,         @user3,       @user4);
  END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJUOPDET_INSERT] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE WS_PJACCT_INSERT 
	@acct          CHAR(16),      @acct_desc     CHAR(30),      @acct_group_cd CHAR(2),  @acct_status   CHAR(1),
    @acct_type     CHAR(2),       @ca_id01       CHAR(30),      @ca_id02       CHAR(30), @ca_id03       CHAR(16),
    @ca_id04       CHAR(16),      @ca_id05       CHAR(4),       @ca_id06       FLOAT,    @ca_id07       FLOAT,
    @ca_id08       SMALLDATETIME, @ca_id09       SMALLDATETIME, @ca_id10       INT,      @ca_id16       CHAR(30),
    @ca_id17       CHAR(16),      @ca_id18       CHAR(4),       @ca_id19       CHAR(1),  @ca_id20       CHAR(1),
    @crtd_datetime SMALLDATETIME, @crtd_prog     CHAR(8),       @crtd_user     CHAR(10), @id1_sw        CHAR(1),
    @id2_sw        CHAR(1),       @id3_sw        CHAR(1),       @id4_sw        CHAR(1),  @id5_sw        CHAR(1),
    @lupd_datetime SMALLDATETIME, @lupd_prog     CHAR(8),       @lupd_user     CHAR(10), @noteid        INT,
    @sort_num      SMALLINT,      @user1         CHAR(30),      @user2         CHAR(30), @user3         FLOAT,
    @user4         FLOAT
AS
  BEGIN
      INSERT INTO [PJACCT]
		([acct],          [acct_desc], [acct_group_cd], [acct_status],
         [acct_type],     [ca_id01],   [ca_id02],       [ca_id03],
         [ca_id04],       [ca_id05],   [ca_id06],       [ca_id07],
         [ca_id08],       [ca_id09],   [ca_id10],       [ca_id16],
         [ca_id17],       [ca_id18],   [ca_id19],       [ca_id20],
         [crtd_datetime], [crtd_prog], [crtd_user],     [id1_sw],
         [id2_sw],        [id3_sw],    [id4_sw],        [id5_sw],
         [lupd_datetime], [lupd_prog], [lupd_user],     [noteid],
         [sort_num],      [user1],     [user2],         [user3],
         [user4])
      VALUES      
		(@acct,          @acct_desc, @acct_group_cd, @acct_status,
         @acct_type,     @ca_id01,   @ca_id02,       @ca_id03,
         @ca_id04,       @ca_id05,   @ca_id06,       @ca_id07,
         @ca_id08,       @ca_id09,   @ca_id10,       @ca_id16,
         @ca_id17,       @ca_id18,   @ca_id19,       @ca_id20,
         @crtd_datetime, @crtd_prog, @crtd_user,     @id1_sw,
         @id2_sw,        @id3_sw,    @id4_sw,        @id5_sw,
         @lupd_datetime, @lupd_prog, @lupd_user,     @noteid,
         @sort_num,      @user1,     @user2,          @user3,
         @user4);
  END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJACCT_INSERT] TO [MSDSL]
    AS [dbo];


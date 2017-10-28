
CREATE PROCEDURE WS_PJCOMMUN_INSERT 
	@crtd_datetime    SMALLDATETIME, @crtd_prog        CHAR(8),   @crtd_user        CHAR(10),      @destination      CHAR(50),
    @destination_type CHAR(1),       @email_address    CHAR(100), @exe_caption1     CHAR(30),      @exe_caption2     CHAR(30),
    @exe_caption3     CHAR(30),      @exe_name1        CHAR(100), @exe_name2        CHAR(100),     @exe_name3        CHAR(100),
    @exe_parm1        CHAR(100),     @exe_parm2        CHAR(100), @exe_parm3        CHAR(100),     @exe_type1        CHAR(1),
    @exe_type2        CHAR(1),       @exe_type3        CHAR(1),   @lupd_datetime    SMALLDATETIME, @lupd_prog        CHAR(8),
    @lupd_user        CHAR(10),      @mail_flag        CHAR(1),   @msg_key          CHAR(48),      @msg_status       CHAR(1),
    @msg_suffix       CHAR(2),       @msg_text         CHAR(254), @msg_type         CHAR(6),       @sender           CHAR(50),
    @source_function  CHAR(30),      @subject          CHAR(50)
AS
  BEGIN
      INSERT INTO [PJCOMMUN]
			([crtd_datetime],    [crtd_prog],     [crtd_user],     [destination],
             [destination_type], [email_address], [exe_caption1],  [exe_caption2],
             [exe_caption3],     [exe_name1],     [exe_name2],     [exe_name3],
             [exe_parm1],        [exe_parm2],     [exe_parm3],     [exe_type1],
             [exe_type2],        [exe_type3],     [lupd_datetime], [lupd_prog],
             [lupd_user],        [mail_flag],     [msg_key],       [msg_status],
             [msg_suffix],       [msg_text],      [msg_type],      [sender],
             [source_function],  [subject])
      VALUES      
			(@crtd_datetime,     @crtd_prog,      @crtd_user,      @destination,
             @destination_type,  @email_address,  @exe_caption1,   @exe_caption2,
             @exe_caption3,      @exe_name1,      @exe_name2,      @exe_name3,
             @exe_parm1,         @exe_parm2,      @exe_parm3,      @exe_type1,
             @exe_type2,         @exe_type3,      @lupd_datetime,  @lupd_prog,
             @lupd_user,         @mail_flag,      @msg_key,        @msg_status,
             @msg_suffix,        @msg_text,       @msg_type,       @sender,
             @source_function,   @subject);
  END 

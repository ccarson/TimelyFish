            
CREATE PROCEDURE WS_PJFISCAL_INSERT 
	@comment       CHAR(30),      @crtd_datetime SMALLDATETIME, @crtd_prog     CHAR(8),  @crtd_user     CHAR(10),
    @data1         CHAR(30),      @end_date      SMALLDATETIME, @factor        FLOAT,    @fiscalno      CHAR(6),
    @lupd_datetime SMALLDATETIME, @lupd_prog     CHAR(8),       @lupd_user     CHAR(10), @noteid        INT,
    @start_date    SMALLDATETIME, @user1         CHAR(30),      @user2         FLOAT
AS
  BEGIN
      INSERT INTO [PJFISCAL]
		([comment],       [crtd_datetime], [crtd_prog], [crtd_user],
         [data1],         [end_date],      [factor],    [fiscalno],
         [lupd_datetime], [lupd_prog],     [lupd_user], [noteid],
         [start_date],    [user1],         [user2])
      VALUES      
		(@comment,       @crtd_datetime, @crtd_prog, @crtd_user,
         @data1,         @end_date,      @factor,    @fiscalno,
         @lupd_datetime, @lupd_prog,     @lupd_user, @noteid,
         @start_date,    @user1,         @user2);
  END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJFISCAL_INSERT] TO [MSDSL]
    AS [dbo];


			CREATE PROCEDURE WS_PJUTPER_INSERT
			@comment char(30), @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10),
			@end_date smalldatetime, @lupd_datetime smalldatetime,@lupd_prog char(8),@lupd_user char(10),
			@noteid int,@period char(6),@pu_id01 char(30),@pu_id02 char(30),@pu_id03 char(20),@pu_id04 char(20),
			@pu_id05 char(10),@pu_id06 char(10),@pu_id07 char(4),@pu_id08 float,@pu_id09 smalldatetime,
			@pu_id10 int,@start_date smalldatetime,@user1 char(30),@user2 char(30),@user3 float,@user4 float
            AS
            BEGIN
            INSERT INTO [PJUTPER]
            ([comment],
			 [crtd_datetime], [crtd_prog], [crtd_user], [end_date], [lupd_datetime], [lupd_prog],
			 [lupd_user], [noteid], [period], [pu_id01], [pu_id02], [pu_id03], [pu_id04],
			 [pu_id05], [pu_id06], [pu_id07], [pu_id08], [pu_id09], [pu_id10], [start_date],
			 [user1], [user2], [user3], [user4])
            VALUES
            (@comment, @crtd_datetime, @crtd_prog, @crtd_user, @end_date, @lupd_datetime,
			 @lupd_prog, @lupd_user, @noteid, @period, @pu_id01, @pu_id02,
			 @pu_id03, @pu_id04, @pu_id05, @pu_id06, @pu_id07, @pu_id08,
			 @pu_id09, @pu_id10, @start_date, @user1, @user2, @user3, @user4);
            END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJUTPER_INSERT] TO [MSDSL]
    AS [dbo];


CREATE PROCEDURE WS_PJUTTYPE_INSERT
     @available char(1), @column_nbr smallint, @crtd_datetime smalldatetime, @crtd_prog char(8),
     @crtd_user char(10), @direct char(1), @lupd_datetime smalldatetime, @lupd_prog char(8),
     @lupd_user char(10), @NoteId int, @user1 char(30), @user2 char(30),
     @user3 float, @user4 float, @ut_id01 char(30), @ut_id02 char(30),
     @ut_id03 char(20), @ut_id04 char(20), @ut_id05 char(10), @ut_id06 char(10),
     @ut_id07 char(4), @ut_id08 float, @ut_id09 smalldatetime, @ut_id10 int,
     @utilization_desc char(30), @utilization_type char(4)
 AS
  BEGIN
     INSERT INTO [PJUTTYPE]
        ([available], [column_nbr], [crtd_datetime], [crtd_prog],
         [crtd_user], [direct], [lupd_datetime], [lupd_prog],
         [lupd_user], [NoteId], [user1], [user2],
         [user3], [user4], [ut_id01], [ut_id02],
         [ut_id03], [ut_id04], [ut_id05], [ut_id06],
         [ut_id07], [ut_id08], [ut_id09], [ut_id10],
         [utilization_desc], [utilization_type])
     VALUES
         (@available, @column_nbr, @crtd_datetime, @crtd_prog,
         @crtd_user, @direct, @lupd_datetime, @lupd_prog,
         @lupd_user, @NoteId, @user1, @user2,
         @user3, @user4, @ut_id01, @ut_id02,
         @ut_id03, @ut_id04,@ut_id05, @ut_id06,
         @ut_id07, @ut_id08, @ut_id09, @ut_id10,
         @utilization_desc, @utilization_type);
  END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJUTTYPE_INSERT] TO [MSDSL]
    AS [dbo];


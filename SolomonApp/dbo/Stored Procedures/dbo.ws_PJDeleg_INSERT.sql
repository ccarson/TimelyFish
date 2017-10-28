
   CREATE PROCEDURE ws_PJDeleg_INSERT
                      @BP_user_id char(50), @cpnyid char(10), @crtd_datetime smalldatetime, @crtd_prog char(8),
                      @crtd_user char(10), @date_end smalldatetime, @date_start smalldatetime, @delegate_flag char(1),
                      @delegate_to_ID char(50), @delegate_type char(1), @De_id01 char(30), @De_id02 char(30),
                      @De_id03 char(16), @De_id04 char(16), @De_id05 char(4), @De_id06 float,
                      @De_id07 float, @De_id08 smalldatetime, @De_id09 smalldatetime, @De_id10 int,
                      @Doc_type char(4), @EmpID char(10), @Employee char(10), @lupd_datetime smalldatetime,
                      @lupd_prog char(8), @lupd_user char(10), @noteid int, @user_id char(50),
                      @User1 char(30), @User2 char(30), @User3 float, @User4 float
   AS
     BEGIN
          INSERT INTO [PJDeleg]
            ([BP_user_id], [cpnyid], [crtd_datetime], [crtd_prog],
             [crtd_user], [date_end], [date_start], [delegate_flag],
             [delegate_to_ID], [delegate_type], [De_id01], [De_id02],
             [De_id03], [De_id04], [De_id05], [De_id06],
             [De_id07], [De_id08], [De_id09], [De_id10],
             [Doc_type], [EmpID], [Employee], [lupd_datetime],
             [lupd_prog], [lupd_user], [noteid], [user_id],
             [User1],[User2], [User3], [User4])
          VALUES
            (@BP_user_id, @cpnyid, @crtd_datetime, @crtd_prog,
             @crtd_user, @date_end, @date_start, @delegate_flag,
             @delegate_to_ID, @delegate_type, @De_id01, @De_id02,
             @De_id03, @De_id04, @De_id05, @De_id06,
             @De_id07, @De_id08, @De_id09, @De_id10,
             @Doc_type, @EmpID, @Employee, @lupd_datetime,
             @lupd_prog, @lupd_user, @noteid, @user_id,
             @User1, @User2, @User3, @User4);
            End

GO
GRANT CONTROL
    ON OBJECT::[dbo].[ws_PJDeleg_INSERT] TO [MSDSL]
    AS [dbo];


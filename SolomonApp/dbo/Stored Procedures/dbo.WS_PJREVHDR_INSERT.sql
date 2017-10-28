
CREATE PROCEDURE WS_PJREVHDR_INSERT
@approved_by1 char(10),@approved_by2 char(10),@approved_by3 char(10),@approver char(10),@Change_Order_Num char(16),
@Create_Date smalldatetime,@crtd_datetime smalldatetime,@crtd_prog char(8),@crtd_user char(10),@end_date smalldatetime,
@Est_Approve_Date smalldatetime,@lupd_datetime smalldatetime,@lupd_prog char(8),@lupd_user char(10),@NoteId int,@Post_Date smalldatetime,
@Post_Period char(6),@Preparer char(10),@Project char(16),@RevId char(4),@RevisionType char(2),@Revision_Desc char(60),@rh_id01 char(30),
@rh_id02 char(30),@rh_id03 char(16),@rh_id04 char(16),@rh_id05 char(4),@rh_id06 float,@rh_id07 float,@rh_id08 smalldatetime,
@rh_id09 smalldatetime,@rh_id10 smallint,@start_date smalldatetime,@status char(2),@update_type char(1),@User1 char(30),@User2 char(30),
@User3 float,@User4 float,@User5 char(10),@User6 char(10),@User7 smalldatetime,@User8 smalldatetime
AS
BEGIN
INSERT INTO [PJREVHDR]([approved_by1],[approved_by2],[approved_by3],[approver],[Change_Order_Num],[Create_Date],[crtd_datetime],
[crtd_prog],[crtd_user],[end_date],[Est_Approve_Date],[lupd_datetime],[lupd_prog],[lupd_user],[NoteId],[Post_Date],[Post_Period],
[Preparer],[Project],[RevId],[RevisionType],[Revision_Desc],[rh_id01],[rh_id02],[rh_id03],[rh_id04],[rh_id05],[rh_id06],[rh_id07],
[rh_id08],[rh_id09],[rh_id10],[start_date],[status],[update_type],[User1],[User2],[User3],[User4],[User5],[User6],[User7],[User8])
VALUES
(@approved_by1,@approved_by2,@approved_by3,@approver,@Change_Order_Num,@Create_Date,@crtd_datetime,@crtd_prog,@crtd_user,@end_date,
@Est_Approve_Date,@lupd_datetime,@lupd_prog,@lupd_user,@NoteId,@Post_Date,@Post_Period,@Preparer,@Project,@RevId,@RevisionType,
@Revision_Desc,@rh_id01,@rh_id02,@rh_id03,@rh_id04,@rh_id05,@rh_id06,@rh_id07,@rh_id08,@rh_id09,@rh_id10,@start_date,@status,@update_type,
@User1,@User2,@User3,@User4,@User5,@User6,@User7,@User8);
END

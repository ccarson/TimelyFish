
CREATE PROCEDURE WS_PJREVTSK_INSERT
@contract_type char(4), @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), @end_date smalldatetime, @fips_num char(10), 
@lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), @manager1 char(10), @NoteId int, @pe_id01 char(30), @pe_id02 char(30), 
@pe_id03 char(16), @pe_id04 char(16), @pe_id05 char(4), @pe_id06 float, @pe_id07 float, @pe_id08 smalldatetime, @pe_id09 smalldatetime, 
@pe_id10 int, @pjt_entity char(32), @pjt_entity_desc char(60), @project char(16), @revid char(4), @rt_id01 char(30), @rt_id02 char(30), @rt_id03 char(16), 
@rt_id04 char(16), @rt_id05 char(4), @rt_id06 float, @rt_id07 float, @rt_id08 smalldatetime, @rt_id09 smalldatetime, @rt_id10 int, @start_date smalldatetime, 
@user1 char(30), @user2 char(30), @user3 float, @user4 float, @User5 char(10), @User6 char(10), @User7 smalldatetime, @User8 smalldatetime 
AS 
BEGIN 
INSERT INTO [PJREVTSK] ([contract_type], [crtd_datetime], [crtd_prog], [crtd_user], [end_date], [fips_num], [lupd_datetime], [lupd_prog], [lupd_user], 
[manager1], [NoteId], [pe_id01], [pe_id02], [pe_id03], [pe_id04], [pe_id05], [pe_id06], [pe_id07], [pe_id08], [pe_id09], [pe_id10], [pjt_entity], 
[pjt_entity_desc], [project], [revid], [rt_id01], [rt_id02], [rt_id03], [rt_id04], [rt_id05], [rt_id06], [rt_id07], [rt_id08], [rt_id09], [rt_id10], 
[start_date], [user1], [user2], [user3], [user4], [User5], [User6], [User7], [User8]) 
VALUES (@contract_type, @crtd_datetime, @crtd_prog, @crtd_user, @end_date, @fips_num, @lupd_datetime, @lupd_prog, @lupd_user, @manager1, @NoteId, 
@pe_id01, @pe_id02, @pe_id03, @pe_id04, @pe_id05, @pe_id06, @pe_id07, @pe_id08, @pe_id09, @pe_id10, @pjt_entity, @pjt_entity_desc, @project, @revid, 
@rt_id01, @rt_id02, @rt_id03, @rt_id04, @rt_id05, @rt_id06, @rt_id07, @rt_id08, @rt_id09, @rt_id10, @start_date, @user1, @user2, @user3, @user4, @User5, 
@User6, @User7, @User8);
END

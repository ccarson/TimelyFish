CREATE PROCEDURE WS_PJADDR_INSERT
@ad_id01 char(30), @ad_id02 char(30), @ad_id03 char(16), @ad_id04 char(16), @ad_id05 char(4), @ad_id06 char(4), @ad_id07 float, 
@ad_id08 smalldatetime, @addr_key char(48), @addr_key_cd char(2), @addr_type_cd char(2), @addr1 char(60), @addr2 char(60), 
@city char(30), @comp_name char(60), @country char(3), @crtd_datetime smalldatetime, @crtd_prog char(8), @crtd_user char(10), 
@email char(80), @fax char(15), @individual char(30), @lupd_datetime smalldatetime, @lupd_prog char(8), @lupd_user char(10), 
@phone char(15), @state char(3), @title char(30), @zip char(10), @user1 char(30), @user2 char(30), @user3 float, @user4 float
AS
BEGIN
INSERT INTO [PJADDR]
([ad_id01], [ad_id02], [ad_id03], [ad_id04], [ad_id05], [ad_id06], [ad_id07], [ad_id08], [addr_key], [addr_key_cd], [addr_type_cd], 
[addr1], [addr2], [city], [comp_name], [country], [crtd_datetime], [crtd_prog], [crtd_user], [email], [fax], [individual], 
[lupd_datetime], [lupd_prog], [lupd_user], [phone], [state], [title], [zip], [user1], [user2], [user3], [user4])
VALUES
(@ad_id01, @ad_id02, @ad_id03, @ad_id04, @ad_id05, @ad_id06, @ad_id07, @ad_id08, @addr_key, @addr_key_cd, @addr_type_cd, @addr1, @addr2, 
@city, @comp_name, @country, @crtd_datetime, @crtd_prog, @crtd_user, @email, @fax, @individual, @lupd_datetime, @lupd_prog, @lupd_user, 
@phone, @state, @title, @zip, @user1, @user2, @user3, @user4);
End

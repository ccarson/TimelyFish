
Create Proc PJPROJEM_AAE
	@project	VarChar(16),
	@prog 		VarChar(8),
	@user 		VarChar(10)
as

INSERT INTO [PJPROJEM]
	(
	[access_data1],[access_data2],[access_insert],[access_update],[access_view],[crtd_datetime],[crtd_prog],
	[crtd_user],[employee],[labor_class_cd],[lupd_datetime],[lupd_prog],[lupd_user],[noteid],[project],
	[pv_id01],[pv_id02],[pv_id03],[pv_id04],[pv_id05],[pv_id06],[pv_id07],[pv_id08],[pv_id09],[pv_id10],
	[user1],[user2],[user3],[user4]
	)
	VALUES
	(
	space(1),space(1),space(1),space(1),space(1),GetDate(),@prog,@user,'*',space(1),GetDate(),@prog,
	@user,0,@project,space(1),space(1),space(1),space(1),space(1),0,0,'','',0,space(1),space(1),0,0
	)
	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEM_AAE] TO [MSDSL]
    AS [dbo];


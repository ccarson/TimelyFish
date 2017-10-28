 CREATE PROCEDURE WOPJContrl_Control_Data_Set
	@Control_Type	varchar( 2 ),
	@Control_Code	varchar( 30 ),
	@Control_Data	varchar( 255 ),
	@Control_Desc	varchar( 30 ),
	@UserID		varchar( 10 ),
	@ProgID		varchar( 8 )

AS

	if @Control_Data = ''
		Delete From PJContrl
		Where	Control_Type = @Control_Type
			and Control_code = @Control_Code
	else
		BEGIN
		If Not Exists(Select * from PJContrl Where Control_Type = @Control_Type and Control_Code = @Control_Code)
			Insert	Into PJContrl(
			Control_Code,
			Control_Data,
			Control_Desc,
			Crtd_DateTime, Crtd_Prog, Crtd_User,
			LUpd_DateTime, LUpd_Prog, LUpd_User,
			Control_Type)
			VALUES(@Control_Code, '', @Control_Desc,
			GetDate(), @ProgID, @UserID,
			GetDate(), @ProgID, @UserID, 'PA')

		Update	PJContrl
		Set	Control_Data = @Control_Data,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @ProgID,
			LUpd_User = @UserID
		Where	Control_Type = @Control_Type
			and Control_Code = @Control_Code

		END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WOPJContrl_Control_Data_Set] TO [MSDSL]
    AS [dbo];


 CREATE PROC ProcErrLog_Del
	@Crtd_Prog		char(8),
	@Crtd_User		char(10)
AS
SET NOCOUNT ON
	DELETE 	ProcErrLog
	WHERE 	Crtd_Prog = @Crtd_Prog AND Crtd_User = @Crtd_User
	RETURN 0	--NO ERROR ENCOUNTERED



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProcErrLog_Del] TO [MSDSL]
    AS [dbo];


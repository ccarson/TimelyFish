 CREATE PROC ProcErrLog_Chk
	@Crtd_Prog		char(8),
	@Crtd_User		char(10)
AS
SET NOCOUNT ON

	SELECT 	Crtd_Prog, Crtd_User, RTRIM(ExecString), ErrNo, RTRIM(ErrDesc)
	FROM 	ProcErrLog
	WHERE 	Crtd_Prog = @Crtd_Prog AND Crtd_User = @Crtd_User
	ORDER 	BY Crtd_User, Crtd_Prog, SortKey DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProcErrLog_Chk] TO [MSDSL]
    AS [dbo];


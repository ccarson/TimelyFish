 Create	Procedure SCM_10400_DebugOff
As
	Set	NoCount On
	Update	INSetup
		Set	S4Future10 = 0
	Print	'Debug has been turned off!'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_DebugOff] TO [MSDSL]
    AS [dbo];


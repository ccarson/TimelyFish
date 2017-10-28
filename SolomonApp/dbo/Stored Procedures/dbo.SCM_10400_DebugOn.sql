 Create	Procedure SCM_10400_DebugOn
As
	Set	NoCount On
	Update	INSetup
		Set	S4Future10 = 1
	Print	'Debug has been turned on!'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_DebugOn] TO [MSDSL]
    AS [dbo];


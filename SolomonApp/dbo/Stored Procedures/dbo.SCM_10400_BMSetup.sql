 Create	Procedure SCM_10400_BMSetup
As

	Select	*
		From	BMSetup (NoLock)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_BMSetup] TO [MSDSL]
    AS [dbo];


 Create	Procedure SCM_RptCompany_RIID
	@RIID SmallInt

as

	SELECT * FROM RptCompany Where RI_ID = @RIID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_RptCompany_RIID] TO [MSDSL]
    AS [dbo];


 Create Procedure INTran_CheckSiteIDDelete
	@parmSiteID varchar (10)
as

	Select 	Count(*)
	From 	INTran
	where 	SiteID = @parmSiteID
	  and	Rlsed = 0


GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTran_CheckSiteIDDelete] TO [MSDSL]
    AS [dbo];


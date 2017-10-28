 Create Proc BM_Component_Kit @KitId varchar (30) as
    Select * from Component where
	KitId = @KitId and
	KitSiteId = ''
    Order by CmpnentId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BM_Component_Kit] TO [MSDSL]
    AS [dbo];


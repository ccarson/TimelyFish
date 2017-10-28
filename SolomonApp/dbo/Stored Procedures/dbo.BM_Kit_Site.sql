 Create Proc BM_Kit_Site @parm1 varchar (30), @parm2 varchar (10) as
	Select * from Kit, Site Where
		Kit.KitId = @Parm1 and
		Kit.Siteid like @Parm2 and
		Kit.Status = 'A' and
		Kit.Siteid = Site.Siteid
	Order by Kit.Kitid, Kit.Siteid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BM_Kit_Site] TO [MSDSL]
    AS [dbo];


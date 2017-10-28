 Create Proc BMComponent_kitid_subassy @KitId varchar (30), @Site varchar (10), @Parm3 varchar (30) as
	Select DISTINCT CmpnentId from Component where
		Kitid = @KitID and
		KitSiteid = @Site and
		CmpnentId like @Parm3 and
		Status = 'A' and
		SubKitStatus <> 'N'
	order by Component.CmpnentId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMComponent_kitid_subassy] TO [MSDSL]
    AS [dbo];


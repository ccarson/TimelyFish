 Create Procedure BMComponent_WU_All @CmpnentID varchar (30), @Status varchar (1), @Site varchar (10) as
	Select * from Component where
		CmpnentID = @CmpnentID
		and Status = @Status
		and SiteID like @Site
		Order by Cmpnentid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMComponent_WU_All] TO [MSDSL]
    AS [dbo];


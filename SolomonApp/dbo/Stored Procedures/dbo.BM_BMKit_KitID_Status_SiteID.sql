 Create Proc BM_BMKit_KitID_Status_SiteID @KitID varchar ( 30), @Status varchar (1), @Site varchar (10) as
	Select * from Kit where
		Kit.Kitid like @KitID
		and Kit.Status like @Status
		and Kit.Siteid like @Site
		and Kit.KitType = 'B'
		Order by Kit.Kitid,Kit.Status,Kit.Siteid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BM_BMKit_KitID_Status_SiteID] TO [MSDSL]
    AS [dbo];


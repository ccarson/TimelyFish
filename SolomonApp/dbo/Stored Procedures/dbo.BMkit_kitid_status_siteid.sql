 -- 11320
-- bkb 10/05/99
Create Proc BMkit_kitid_status_siteid @KitID varchar ( 30), @Status varchar (1), @Site varchar (10) as
	Select * from Kit where
		Kit.Kitid like @KitID
		and Kit.Status like @Status
		and Kit.Siteid like @Site
		and Kit.SiteId <> ''
		Order by Kit.Kitid,Kit.Status,Kit.Siteid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMkit_kitid_status_siteid] TO [MSDSL]
    AS [dbo];


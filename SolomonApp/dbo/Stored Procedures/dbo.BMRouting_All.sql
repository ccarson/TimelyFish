 -- 11320
-- bkb 10/13/99
Create Proc BMRouting_All @KitID varchar ( 30), @Status varchar (1), @Site varchar (10) as
	Select * from Routing where
		KitId like @KitID
		and Status like @Status
		and SiteID like @Site
		order by KitId, SiteID, Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMRouting_All] TO [MSDSL]
    AS [dbo];


 Create Proc BMCostRollup_All @KitId varchar ( 30), @SiteId varchar ( 10), @Status varchar ( 1) as
	Select * from Kit
		where Kitid like @KitId and
			SiteId like @SiteId and
			Status <> @Status
        	order by KitId, SiteId, Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMCostRollup_All] TO [MSDSL]
    AS [dbo];


 Create Proc BMCostRollup_Sel @KitId varchar ( 30), @SiteId varchar ( 10), @Status varchar ( 1) as
	Select * from Kit
		where Kitid like @KitId and
			SiteId like @Siteid and
			Status like @Status
        	order by KitId, SiteId, Status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMCostRollup_Sel] TO [MSDSL]
    AS [dbo];


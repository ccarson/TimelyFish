 --bkb 9/15/00 4.21 clsBMCostRollup
Create Procedure BMComp_Cost_Rollup @CmpnentID varchar ( 30), @SiteId varchar ( 10), @KitStatus varchar ( 1) as
		Select * from Component where
			CmpnentId = @CmpnentID and
			SiteId = @SiteId and
			KitStatus = @KitStatus and
			Status = 'A' and
			(SubKitStatus = 'N' or SubKitStatus = 'A' or SubKitStatus = '')
		Order by CmpnentID, SiteID, KitStatus



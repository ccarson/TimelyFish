 Create Proc SCM_11250_RtgStep_PV @KitID varchar ( 30), @SiteID varchar ( 10), @StepNbr varchar ( 5) as
            Select * from RtgStep where
		KitId = @KitID and
		SiteID = @SiteID and
		(RtgStatus = 'A' or RtgStatus = 'P') and
		StepNbr LIKE @StepNbr
            Order by KitId, SiteId, RtgStatus, StepNbr



 Create Proc BMRtgStep_Kit_Site_RStat @KitID varchar ( 30), @SiteID varchar ( 10), @RtgStatus varchar ( 1),
	@StepNbr varchar ( 5) as
            Select * from RtgStep where
		KitId = @KitID and
		SiteID = @SiteID and
		RtgStatus = @RtgStatus
		and StepNbr like @StepNbr
            Order by KitId, SiteId, RtgStatus, StepNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BMRtgStep_Kit_Site_RStat] TO [MSDSL]
    AS [dbo];


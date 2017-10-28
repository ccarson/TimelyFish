 CREATE Procedure IRBucket_FillforPlan @InvtId varchar(30), @CurrentPerDate SmallDateTime, @SiteID VarChar(10) AS
Set NoCount On
Declare @DaysToLookAhead Float
Set @DaysToLookAhead = 0.0
Select @DaysToLookAhead = (Select IsNull(DaysAheadToHave,0) from IR_BuckDaysAhead Where InvtId = @InvtId)
Select @DaysToLookAhead = (Select Isnull(@DaysToLookAhead,0))
-- Update IRBucket, fill in QtyIn, QtyOut, QtyOutFCast, QtyOutFirm
-- Clear all prior info
Update IRBucket Set QtyIn = 0.0, QtyOut = 0.0, QtyOutFCast = 0.0, QtyOutFirm = 0.0, QtyStart = 0.0, QtyEnd = 0.0, QtyOutPast = 0.0, QtyInPast = 0.0, DesiredQty = 0.0
-- Fill in In and Firm out
Update IRBucket Set
 QtyIn = IsNull((Select Sum(IsNull(QtyNeeded,0)) from IRRequirement where IRRequirement.InvtId = @InvtId and IRRequirement.SiteId Like @SiteId and DueDate between DateStart and DateEnd and DocumentType in ('PO','PL')),0),
 QtyOutFirm = IsNull((Select Sum(IsNull(QtyNeeded,0)) from IRRequirement where IRRequirement.InvtId = @InvtId and IRRequirement.SiteId Like @SiteId and DueDate between DateStart and DateEnd and DocumentType in ('SO','PLR','SH')),0)

-- Now see if can fill in forecast amounts
	if exists (select * from sysobjects where id = object_id(N'[dbo].[IR_ProdForecast]') and OBJECTPROPERTY(id, N'IsView') = 1)
	Begin
	-- View does exist, so run the update
		Update IRBucket Set QtyOutFcast = IsNull((Select Sum(IsNull(ForecastQtySales,0)) from IR_ProdForeCast where IR_ProdForeCast.InvtId = @InvtId and IR_ProdForeCast.SiteID Like @SiteID and ForeCastDay between Convert(DateTime,DateStart) and convert(DateTime,DateEnd)),0)
	End
-- Reduce forecast for current bucket
Update IRBucket Set
	QtyOutFcast = (QtyOutFcast - isnull((select Sum(IsNull(QtyShip,0)) from SOShipline,SoShipHeader where SoShipLine.InvtId = @InvtId and Soshipheader.shipperid = soshipline.shipperid and soshipheader.status = 'C' and soshipheader.cancelled = 0 and ShipDateAct between DateStart and DateEnd),0))
	Where @CurrentPerDate <= DateEnd
-- Now go update the first bucket with all PAST DUE items
Update IRBucket
 Set
 QtyInPast = IsNull((Select Sum(IsNull(QtyNeeded,0)) from IRRequirement where IRRequirement.InvtId = @InvtId and IRRequirement.SiteId Like @SiteId and DueDate < DateStart and DocumentType in ('PO','PL')),0),
 QtyOutPast = IsNull((Select Sum(IsNull(QtyNeeded,0)) from IRRequirement where IRRequirement.InvtId = @InvtId and IRRequirement.SiteId Like @SiteId and DueDate < DateStart and DocumentType in ('SO','PLR','SH')),0)
	where DateStart = (Select Min(B.DateStart) from IRBucket B)
-- Set QtyOut to be larger of the two values (Forecast or Actual)
Update IRBucket Set QtyOut = (Case When (QtyOutFcast > QtyOutFirm) Then QtyOutFcast Else QtyOutFirm END)
Update IRBucket Set DesiredQty = (Select isnull(Sum(isnull(B.QtyOut,0)),0) From IRBucket B where DateAdd(dd,@DaysToLookAhead, IRBucket.DateStart) between  B.DateStart and B.DateEnd And IRBucket.DateStart Not Between B.DateStart and B.DateEnd)
-- Add in extra qty
Update IRBucket Set DesiredQty = DesiredQty + IsNull((Select Max(IsNull(QtyDesired,0)) From IRAddOnHand where IRAddOnHand.InvtID = @InvtID and IRAddOnHand.OnDate Between IRBucket.DateStart and IRBucket.DateEnd),0)
Set NoCount Off



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRBucket_FillforPlan] TO [MSDSL]
    AS [dbo];


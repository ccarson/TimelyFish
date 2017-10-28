 CREATE Procedure IRRequire_MovePOToDay @InvtId VarChar(30), @SiteID VarChar(10),  @FromDate SmallDateTime, @ToDate SmallDateTime AS
	-- Want to move ONLY 1 Planned In Item here!
	Select top 1 QtyNeeded from IRRequirement where InvtId = @InvtId and SiteID Like @SiteID and DueDatePlan = @FromDate Order by DueDate, DocumentId
Set NoCount ON
	Update IRRequirement set DueDatePlan = @ToDate
	where
		InvtId = @InvtId
		and SiteID Like @SiteID
		 and DocumentId in (Select top 1 B.DocumentId from IRRequirement B where B.InvtId = @InvtId and B.DueDatePlan = @FromDate Order by B.DueDate, B.DocumentId)
		 and DocOtherRef1 in (Select top 1 B.DocOtherRef1 from IRRequirement B where B.InvtId = @InvtId and B.DueDatePlan = @FromDate Order by B.DueDate, B.DocumentId)
		 and DocOtherRef2 in (Select top 1 B.DocOtherRef2 from IRRequirement B where B.InvtId = @InvtId and B.DueDatePlan = @FromDate Order by B.DueDate, B.DocumentId)
Set NoCount OFF



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRRequire_MovePOToDay] TO [MSDSL]
    AS [dbo];


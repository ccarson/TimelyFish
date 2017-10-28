 CREATE Procedure IRRequire_MoveCanc @InvtId VarChar(30), @SiteID VarChar(10) , @ExcludeDate SmallDateTime AS
	Select * from IRRequirement where InvtId = @InvtId and SiteID Like @SiteID and DueDatePlan = @ExcludeDate  and Revised = 0 order by DueDate,DueDatePlan,DocumentId



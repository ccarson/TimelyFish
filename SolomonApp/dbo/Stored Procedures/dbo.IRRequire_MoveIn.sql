 CREATE Procedure IRRequire_MoveIn @InvtId VarChar(30), @SiteID VarChar(10), @DaysAllowed int, @ExcludeDate SmallDateTime AS
	Select * from IRRequirement where InvtId = @InvtId and SiteID Like @SiteID and DueDatePlan <> @ExcludeDate and DateDiff(dd,DueDatePlan,DueDate) > @DaysAllowed and Revised = 0 order by DueDate,DueDatePlan,DocumentId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRRequire_MoveIn] TO [MSDSL]
    AS [dbo];


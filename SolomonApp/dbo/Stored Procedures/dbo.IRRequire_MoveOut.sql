 CREATE Procedure IRRequire_MoveOut @InvtId VarChar(30), @SiteID VarChar(10), @DaysAllowed int, @ExcludeDate SmallDateTime AS
	Select * from IRRequirement where InvtId = @InvtId and SiteID Like @SiteID and DueDatePlan <> @ExcludeDate and DateDiff(dd,DueDate,DueDatePlan) > @DaysAllowed and Revised = 0  order by DueDate,DueDatePlan,DocumentId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRRequire_MoveOut] TO [MSDSL]
    AS [dbo];


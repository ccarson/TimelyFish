 CREATE Procedure IRRequire_SetDDPlan @InvtId VarChar(30), @SiteID VarChar(10) AS
Update IRRequirement set DueDatePlan = DueDate where InvtId = @InvtId and SiteID Like @SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRRequire_SetDDPlan] TO [MSDSL]
    AS [dbo];


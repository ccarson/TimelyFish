 CREATE Procedure IRRequire_SetDDPOs @InvtId VarChar(30), @MaxDate SmallDateTime, @SiteID VarChar(10) AS
	Update IRRequirement set DueDatePlan = @MaxDate where InvtId = @InvtId and SiteID Like @SiteID and DocumentType in ('PO','PL')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRRequire_SetDDPOs] TO [MSDSL]
    AS [dbo];


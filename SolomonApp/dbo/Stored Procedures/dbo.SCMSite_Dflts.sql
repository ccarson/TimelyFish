 Create Procedure SCMSite_Dflts
	@CpnyID Varchar(10),
	@SiteID Varchar(10)
AS
	Select  CpnyID,SiteID,DfltRepairBin,DfltVendorBin
	From 	Site
	Where 	CpnyID = @CpnyID
		And SiteID = @SiteID
	ORDER BY CpnyID,SiteId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCMSite_Dflts] TO [MSDSL]
    AS [dbo];


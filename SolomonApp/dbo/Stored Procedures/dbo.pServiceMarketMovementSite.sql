CREATE PROC [dbo].[pServiceMarketMovementSite] 
	@BegDate smalldatetime,
	@EndDate smalldatetime,
	@SiteID int,
	@Company varchar(3)
AS
DECLARE @strCpny varchar(3)
IF @Company='CFM' BEGIN SET @strCpny='CFM' END ELSE BEGIN SET @strCpny=0 END
Select * from dbo.vMarketMovementFilter where MovementDate between @BegDate and @EndDate and SourceSiteID=@SiteID
	and (isnull(Lupd_User,0)=@Company or isnull(Lupd_User,0)=@strCpny)
Order by MovementDate, HeadTypeID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pServiceMarketMovementSite] TO [MSDSL]
    AS [dbo];


--*************************************************************

--	Purpose:Distance and Rates from Contact to Packer
--	Author: Charity Anderson
--	Date: 3/17/2005
--	Usage: Transporation Module
--	Parms: source SiteContactID, Show LockerPlants
--	      
--*************************************************************
Create PROC [dbo].[pXT100SitetoPackerMileage]
		(@parm1 as varchar(6), @parm2 as smallint)

as
IF @parm2=1 
    BEGIN
	SELECT c.ContactName, mm.*,
		BaseRate= mr.rate
	FROM    
		vCFContactMilesMatrix mm WITH (NOLOCK)
		JOIN cftPacker p WITH (NOLOCK) on mm.DestSite=p.ContactID
		JOIN cftContact c WITH (NOLOCK) on p.ContactID=c.COntactID
		LEFT JOIN cftMileageRate mr WITH (NOLOCK) on Ceiling(mm.OneWayMiles) between mr.LowMiles and mr.HighMiles
		where mm.SourceSite=@parm1
		order by mm.OneWayMiles,c.ContactName
    END
ELSE
    BEGIN
	SELECT c.ContactName, mm.*,
		BaseRate= mr.Rate
	FROM    
		vCFContactMilesMatrix mm WITH (NOLOCK)
		JOIN cftPacker p WITH (NOLOCK) on mm.DestSite=p.ContactID
		JOIN cftContact c WITH (NOLOCK) on p.ContactID=c.COntactID
		LEFT JOIN cftMileageRate mr WITH (NOLOCK) on Ceiling(mm.OneWayMiles) between mr.LowMiles and mr.HighMiles
		where mm.SourceSite=@parm1 and p.TrackTotals=-1
		order by mm.OneWayMiles,c.ContactName
    END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100SitetoPackerMileage] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100SitetoPackerMileage] TO [MSDSL]
    AS [dbo];


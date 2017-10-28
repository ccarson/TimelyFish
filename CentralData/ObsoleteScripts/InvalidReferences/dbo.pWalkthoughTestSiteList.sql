--used in Health Assurance Test app to list sites needing walkthroughs (for Tattoo requirements) 
--with PigMovements scheduled within a specified date range (tomorrow to endDate)

CREATE PROC [dbo].[pWalkthoughTestSiteList] 
	@EndDate as smalldatetime
AS

Select  min(MovementDate) as MovementDate, hs.ContactID as SourceContactID
FROM [$(SolomonApp)].dbo.cftPM pm
JOIN [$(SolomonApp)].dbo.cftHealthService hs on pm.SourceContactID=hs.ContactID 
LEFT JOIN [$(SolomonApp)].dbo.cftContact c on pm.SourceContactID=c.ContactID
WHERE Cast(pm.MovementDate + ' ' + SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) as smalldatetime)  between GetDate() and @EndDate+5
	and pm.MovementDate>DateAdd(day,30,VetVisitDate)
	--and MovementSystem=1
	and TattooFlag<>0
	and c.ContactName not between 'C027' and 'C037' and rtrim(c.ContactName) not in ('C023','C025') 
Group by hs.ContactID 

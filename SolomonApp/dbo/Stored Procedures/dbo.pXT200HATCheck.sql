CREATE PROC dbo.pXT200HATCheck (@PMID varchar(10))

AS
BEGIN

	(select pre.pmid, pre.movementdate
	 from 
		(Select pm.pmid, pm.movementdate, pm.DestContactID ,HTP.[Days] as Days
		 from cftPM pm 
		 inner Join [dbo].[cfv_HAT_PMSchedule] HTP on PM.DestContactID = HTP.[siteID] and pm.[TranSubTypeID] = HTP.[TranTypeID]
		 where PMTypeID='01'
			AND TranSubTypeID is not null
			AND HTP.[Timing] like 'Post') post
		inner join 
		(Select pm.pmid, pm.movementdate, pm.SourceContactID  ,HTP.[Days] as Days   
		from cftPM pm 
		inner Join [dbo].[cfv_HAT_PMSchedule] HTP on PM.SourceContactID = HTP.[siteID] and pm.[TranSubTypeID] = HTP.[TranTypeID]
			Where PMTypeID='01'
			AND TranSubTypeID is not null
			AND HTP.[Timing] like 'Pre') pre
		on pre.[SourceContactID] = post.[DestContactID]
	where DATEADD(day,-pre.days,pre.[MovementDate]) < DATEADD(day,post.days,post.[MovementDate]) 
    and pre.[MovementDate] > post.[MovementDate]
    and post.pmid = @PMID
    
    UNION
    
	select post.pmid, post.movementdate
	 from 
		(Select pm.pmid, pm.movementdate, pm.DestContactID ,HTP.[Days] as Days
		 from cftPM pm 
		 inner Join [dbo].[cfv_HAT_PMSchedule] HTP on PM.DestContactID = HTP.[siteID] and pm.[TranSubTypeID] = HTP.[TranTypeID]
		 where PMTypeID='01'
			AND TranSubTypeID is not null
			AND HTP.[Timing] like 'Post') post
		inner join 
		(Select pm.pmid, pm.movementdate, pm.SourceContactID  ,HTP.[Days] as Days   
		from cftPM pm 
		inner Join [dbo].[cfv_HAT_PMSchedule] HTP on PM.SourceContactID = HTP.[siteID] and pm.[TranSubTypeID] = HTP.[TranTypeID]
			Where PMTypeID='01'
			AND TranSubTypeID is not null
			AND HTP.[Timing] like 'Pre') pre
		on pre.[SourceContactID] = post.[DestContactID]
	where DATEADD(day,-pre.days,pre.[MovementDate]) < DATEADD(day,post.days,post.[MovementDate]) 
    and pre.[MovementDate] > post.[MovementDate]
    and pre.pmid =  @PMID )	
END
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT200HATCheck] TO [MSDSL]
    AS [dbo];


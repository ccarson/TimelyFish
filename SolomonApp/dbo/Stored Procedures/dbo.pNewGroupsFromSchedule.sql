
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

Create Procedure dbo.pNewGroupsFromSchedule 
	@RefDate as smalldatetime
	
	As
	Select cs.ContactName as SourceSite, s.SourceBarnNbr as SourceBarn,d.DestContactID as SiteContactID,c.ContactName as SiteName, 
	b.BarnNbr, b.Assigned, b.FirstFillDate from 
	(Select Distinct DestContactID, DestBarnNbr from cftPM pm 
	where MovementDate between @RefDate and @RefDate+6) d
JOIN
	(select DestContactID as ContactID,
		BarnNbr = pm.DestBarnNBr, 
		Assigned = Sum(IsNull(EstimatedQty,0)), 
		FirstFillDate = Min(pm.MovementDate), 
		LastFillDate = Max(pm.MovementDate)
		
		from dbo.cftPM pm
		RIGHT OUTER JOIN cftBarn vb ON pm.DestContactID = vb.ContactID and pm.DestBarnNBr = vb.BarnNbr
		Where pm.MovementDate between @RefDate-21 and @RefDate+27 
		
		and isnull(DeleteFlag,0)=0
		Group By pm.DestContactID, DestBarnNbr, FacilityTypeID
		) b


on d.DestContactID=b.ContactID and d.DestBarnNbr=b.BarnNbr

LEFT JOIN cftPigGroup pg

ON d.DestContactID=pg.SiteContactID and d.DestBarnNbr=pg.BarnNbr and pg.PGStatusID<>'I' and pg.PGStatusID<>'T'
JOIN cftContact c on d.DestContactID=c.ContactID
JOIN (Select Distinct SourceContactID, SOurceBarnNbr, DestContactID, DestBarnNbr from cftPM
	where MovementDate between @RefDate and @RefDate+6) s 
ON d.DestContactID=s.DestContactID and d.DestBarnNbr=s.DestBarnNbr
Join cftContact cs on s.SourceContactID=cs.ContactID
where pg.PigGroupID is null

 
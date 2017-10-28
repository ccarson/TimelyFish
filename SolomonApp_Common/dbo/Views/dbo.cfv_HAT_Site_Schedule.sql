


CREATE VIEW [dbo].[cfv_HAT_Site_Schedule]
AS

Select HAT.[ScheduleID]
	  ,HAT.[TestDate]
	  ,HAT.SiteContactID
	  ,s.ContactName as SiteName
	  ,isnull(HAT.[TestComment],'') as TestComment
	  ,HAT.[SPID] as SPID
      ,SCH.[Protocol_Type] 
	  ,Name = 
		CASE SCH.[Timing] 
			WHEN 'Pre' THEN SCH.[Name] +', Pre Ship'
			WHEN 'Post' THEN SCH.[Name] +', Post Arrival'
			ELSE SCH.[Name]
		END	
      ,SCH.[Site] as TestSite
      ,SCH.[SiteID] as TestSiteID
      ,SCH.[Type]
      ,SCH.[SampleQty]
      ,isnull(SCH.[Comment],'') as Comment
      ,isnull(SCH.[Frequency],'') as Frequency
	  ,SCH.[LAB]
	  ,HAT.[Status]


from cft_HAT_Schedule HAT 
inner JOIN cftContact s WITH (NOLOCK) on HAT.SiteContactID=s.ContactID
inner Join [dbo].[cfv_HAT_HTP_Schedule] SCH on HAT.SiteContactID = SCH.[siteID] and HAT.SPID = SCH.SPID
Where SCH.[Active_cde] = 'A'
















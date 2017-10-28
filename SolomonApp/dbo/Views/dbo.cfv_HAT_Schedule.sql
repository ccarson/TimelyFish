




CREATE VIEW [dbo].[cfv_HAT_Schedule]
AS

Select HAT.[ScheduleID]
	  ,HAT.SiteContactID
	  ,S.ContactName as FarmName
	  ,HAT.VetContactID
	  ,isnull(VET.ContactName, '') as VetName
	  ,isnull(HAT.DeliveredBy, '') as DeliveredBy
	  ,HAT.LabID
	  ,isnull(LAB.Name, '') as LabName
	  ,HAT.[SPID] as SPID
	  ,LT.Lab
	  ,HAT.[TestDate]
      ,HAT.[LabDate]
      ,HAT.[ExpireDate]
      ,HAT.[CaseID]
      ,isnull(HAT.[ResultsFileURL], '') as ResultsFileURL
      ,isnull(HAT.[ApprovedBy], '') as ApprovedBy
      ,HAT.[Status]
      ,isnull(HAT.[TestComment],'') as TestComment
	     ,RS.Results_Processed

from cft_HAT_Schedule HAT 
inner JOIN cftContact s WITH (NOLOCK) on HAT.SiteContactID=s.ContactID
left join cftContact vet WITH (NOLOCK) on HAT.VetContactID= Vet.ContactID
left join [dbo].[cft_HAT_Lab] lab WITH (NOLOCK) on HAT.LabID = lab.LabID
left join [dbo].[cfv_HAT_LabTests] LT WITH (NOLOCK) on HAT.SPID = LT.SPID
left join [dbo].[cft_HAT_Results] RS WITH (NOLOCK) on HAT.CaseID = RS.CaseID

























CREATE VIEW [dbo].[cfv_HAT_Vet_Schedule]
AS

Select HAT.[ScheduleID]
	  ,HAT.SiteContactID
	  ,S.ContactName as FarmName
	  ,HAT.VetContactID
	  ,isnull(VET.ContactName, '') as VetName
	  ,HAT.[TargetDate]
	  ,HAT.[ActualTestDate]
      ,HAT.[ExpireDate]
    --  ,isnull(HAT.[ApprovedBy], '') as ApprovedBy
      ,HAT.[Status]
     -- ,isnull(HAT.[TestComment],'') as TestComment

from cft_HAT_Vet_Schedule HAT  (nolock)
inner JOIN cftContact s WITH (NOLOCK) on HAT.SiteContactID=s.ContactID
left join cftContact vet WITH (NOLOCK) on HAT.VetContactID= Vet.ContactID
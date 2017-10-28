



-- ==========================================================================================================
-- Date			Author				Change Description
-- ----------   ------------------	-------------------------------------------------------------------------
-- 6/01/2016	ddahle				Created new view, like cfvSite, to only show active sites.
--									Used in VFD Dispatch app for Pronto Forms
--
-- ==========================================================================================================
CREATE View [dbo].[cfv_Dispatch_VFDs] (DispatchID
	  ,SiteName
	  ,MedName
      ,Eff_DT
      ,Expire_DT
	  ,MillName
      ,NBRToFeed
      ,PigGroupID
      ,SPInstructions
	  ,VetName
	  ,VFDID
	  ,VFDStatus
	  ,ErrorMsg) as

    SELECT VFD.[IDVFDDispatch] 
	  ,cs.ContactName as SiteName
	  ,md.NameSelect as MedName
      ,[Eff_DT]
      ,[Expire_DT]
	  ,cm.ContactName as MillName
      ,[NBRToFeed]
      ,[PigGroupID]
      ,[SPInstructions]
	  ,cv.ContactName as VetName
	  ,VFD.ReferenceNumber as VFDID
	  ,CASE
			When vfd.void = 1 then 'Void'
			When vfd.Expire_DT < getdate() then 'Expired'
			When VFD.ReferenceNumber IS NULL AND VFD.Results_Msg IS NULL Then 'Inserted'
			When VFD.ReferenceNumber IS NULL AND VFD.Results_Msg IS NOT NULL Then 'Error'
			When VFD.ReferenceNumber IS Not NULL AND VFD.Results_Msg IS NOT NULL Then 'Rejected'
			When VFD.ReferenceNumber IS NOT NULL AND dr.Results_XML IS NULL Then 'Dispatched'
			ELSE 'Active'
		END,
		VFD.Results_Msg as ErrorMsg
	  
      
  FROM [SolomonApp].[dbo].[cft_VFDDispatch] VFD WITH (NOLOCK) 
  JOIN [SolomonApp].[dbo].[cftContact] cs WITH (NOLOCK) on vfd.ContactId = cs.ContactId
  JOIN [SolomonApp].[dbo].[cftContact] cm WITH (NOLOCK) on vfd.MillID = cm.ContactId
  JOIN [SolomonApp].[dbo].[cftContact] cv WITH (NOLOCK) on vfd.VetID = cv.ContactId
  JOIN [SolomonApp].[dbo].[cft_VFDMed] md WITH (NOLOCK) on vfd.DrugID = md.IDVFDMed
  Left Join [SolomonApp].[dbo].[cft_FormResults] dr WITH (NOLOCK) on vfd.ReferenceNumber = dr.ReferenceNumber 
		



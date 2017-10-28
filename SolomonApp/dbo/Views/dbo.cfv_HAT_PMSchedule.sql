




CREATE VIEW [dbo].[cfv_HAT_PMSchedule]
AS
SELECT PH.SPID
	  ,farm.[ContactName] as site
	  ,farm.[ContactID] as siteID
      ,MS.Timing
      ,MS.[Days]
      ,MS.[TranTypeID]
  FROM [SolomonApp].[dbo].[cft_HAT_ProtocolHdr] PH
   join [SolomonApp].[dbo].[cft_HAT_GroupSample] GS on PH.SPID = GS.[SPID] and GS.[Expire_DT] is null
   join [SolomonApp].[dbo].[cft_HAT_Group] GP on GS.[GroupID] = GP.[GroupID] and GP.[Active_cde] like 'A' 
   join [SolomonApp].[dbo].[cft_HAT_SiteGroup] SG on GP.[GroupID] = SG.[GroupID] and SG.[Expire_DT] is null
   join [SolomonApp].[dbo].[cftContact] farm on SG.[ContactID] = farm.[ContactID]
   join [SolomonApp].[dbo].[cft_HAT_MovementSample] MS on PH.SPID = MS.[SPID] and MS.[Expire_DT] is null
  
  Where PH.[Protocol_Type] like 'Movement' AND PH.[Active_cde] like 'A'
   group by 
      PH.SPID
      ,farm.[ContactName]
      ,farm.[ContactID]
	  ,MS.Timing
      ,MS.[Days]
      ,MS.[TranTypeID]




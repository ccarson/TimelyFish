





CREATE VIEW [dbo].[cfv_HAT_HTP_Schedule]
AS
SELECT PH.SPID,
	  farm.[ContactName] as site,
	  farm.[ContactID] as siteID,
	  GP.[Name] as 'Group',
	  GP.[GroupID] as GroupID,
	  PH.[Name]
	  ,PH.[desc]
	  ,samp.[Method] as 'Type'
      ,PH.[Active_cde]
      ,PS.[SampleQty]
      ,PS.[Comment]
      ,PH.[Protocol_Type]
      ,LT.LAB
      ,Mon.[Frequency]
      ,MS.Timing
      ,MS.[Days]
      ,MS.MovementID
  FROM [dbo].[cft_HAT_ProtocolHdr] PH
   join [dbo].[cft_HAT_GroupSample] GS on PH.SPID = GS.[SPID] and GS.[Expire_DT] is null
   join [dbo].[cft_HAT_Group] GP on GS.[GroupID] = GP.[GroupID] and GP.[Active_cde] like 'A' 
   join [dbo].[cft_HAT_SiteGroup] SG on GP.[GroupID] = SG.[GroupID] and SG.[Expire_DT] is null
   join [dbo].[cftContact] farm on SG.[ContactID] = farm.[ContactID]
  left join [dbo].[cft_HAT_ProtocolSample] PS on PH.SPID = PS.[SPID] and PS.[Expire_DT] is null
  left join [dbo].[cft_HAT_Sample] samp on PS.[SampleID] = samp.[SampleID] and samp.[Active_cde] like 'A' 
  left join [dbo].[cfv_HAT_LabTests] LT on PH.SPID = LT.[SPID] 
  left join [dbo].[cft_HAT_Monitor] Mon on PH.SPID = Mon.[SPID] and Mon.[Expire_DT] is null
  left join [dbo].[cfv_HAT_MovementSample] MS on PH.SPID = MS.SPID 
   group by 
      PH.SPID
      ,farm.[ContactName]
      ,farm.[ContactID]
      ,GP.[Name]
	  ,PH.[desc]
      ,GP.[GroupID]
      ,PH.[Name],PH.[Active_cde]
      ,PS.[SampleQty]
      ,PS.[Comment]
      ,PH.[Protocol_Type],samp.[Method] 
      ,LT.LAB
      ,Mon.[Frequency]
	  ,MS.Timing
      ,MS.[Days]
      ,MS.MovementID




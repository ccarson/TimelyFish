


CREATE VIEW [caredata].[CFV_Sow_Delete]
AS
SELECT  
	    SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  , ID.[tattoo] as AlternateID
      , IH.deletion_date as deletion_date
	
  FROM [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  inner join [caredata].[BH_IDENTITIES] ID (NOLOCK) on IH.[identity_id] = ID.[identity_id]
  left join [caredata].[EXTERNAL_FARMS] ef (NOLOCK) on sowHdr.Origin_id = ef.farm_ID
  
Where  IH.deletion_date IS Not NULL 
and farm.site_id not in(99,101)	-- 20140708 sripley  remove access to farm 1 (not a valid site)



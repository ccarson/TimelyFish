



CREATE VIEW [dbo].[CFV_SowOrigin]
AS

SELECT farm.[farm_name] AS FarmID
      ,XF.[longname] as Name

  FROM[$(PigCHAMP)].[caredata].[EXTERNAL_FARMS] XF
  inner join[$(PigCHAMP)].[careglobal].[FARMS] farm (NOLOCK) on XF.site_id = farm.[site_id] 
  where [deletion_date] is null
   and [disabled] = 0

union

  SELECT distinct
		Null as FarmID
      ,[longname] as Name
  FROM[$(PigCHAMP)].[caredata].[EXTERNAL_FARMS]
  where [site_id] is null
   and [deletion_date] is null
   and [disabled] = 0



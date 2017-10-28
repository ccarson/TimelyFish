CREATE VIEW [CFV_SowBreeder]
AS

SELECT 
       farm.[farm_name] AS FarmID
      ,[initials]
      ,[last_name] as Name
      ,[first_name] as BreederID
      ,[disabled]
      ,[synonym]
      ,[deletion_date]
  FROM[$(PigCHAMP)].[caredata].[SUPERVISORS] sup
  inner join[$(PigCHAMP)].[careglobal].[FARMS] farm (NOLOCK) on sup.site_id = farm.[site_id] 





CREATE VIEW [dbo].[CFV_SowBreeder]
AS

SELECT 
       farm.[farm_name] AS FarmID
      ,[initials]
      ,[last_name] as Name
      ,[first_name] as BreederID
      ,[disabled]
      ,[synonym]
      ,[deletion_date]
  FROM [caredata].[SUPERVISORS] sup
  inner join [careglobal].[FARMS] farm (NOLOCK) on sup.site_id = farm.[site_id] 



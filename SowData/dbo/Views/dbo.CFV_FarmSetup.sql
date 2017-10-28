



CREATE VIEW [dbo].[CFV_FarmSetup]
AS

SELECT [site_id]
      ,[farm_number] as ContactID
      ,[farm_name] as FarmID
      ,[farm_name]+'.TXT' as SourceExtractFile
      ,'G:\PC4\' +[farm_name] as PCDirectory
	  ,6 as PadSowIDLength
      ,5 as PadAlternateIDLength
	  ,'A' as Status
  FROM [$(PigCHAMP)].[careglobal].[FARMS]
  where main_site_id <> -1





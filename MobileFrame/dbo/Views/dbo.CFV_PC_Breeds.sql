





CREATE VIEW 
    [dbo].[CFV_PC_Breeds]
AS
SELECT  Distinct
		     CAST(ATP.[TAGNBR] as varchar(12)) as 'Primary'
			,CAST(ATA.[TAGNBR] as varchar(20)) as 'ALTERNATE'
			,CAST(FRM.NAME as varchar(8))as Farm
			,MFU.NAME as 'Created_By'
			,Isnull(ME.ENTEREDDATE, ME.CREATE_DATE) as CREATE_DATE
			,ME.[EVENTDATE] as MATINGDATE
			,ME.[MATINGHOUR]
			,ME.[MATINGNBR]
		    ,ME.EVENTTHDATE MATINGTHOUSDATE
			,CAST(OB.Name as varchar(12)) as Breeder
			,CAST(OB.[BREEDERID] as varchar(3)) as BreederID
			,CAST(SEM.NAME as varchar(6)) as Semen
			,ME.[ID] as MFID
			,ME.SYNCSTATUS
			,ME.GROUPNAME
			
FROM  [dbo].CFT_ANIMAL AS AN WITH (NOLOCK) 
						 JOIN [dbo].[CFT_FARMANIMAL] FA (NOLOCK) on AN.ID  = FA.ANIMALID 
						 JOIN [dbo].[CFT_FARM] FRM (NOLOCK) on FA.FARMID  = FRM.ID 
						 JOIN [dbo].[CFT_ANIMALEVENTS] ME (NOLOCK) ON AN.ID  = ME.ANIMALID 
						 JOIN [dbo].[CFT_EVENTTYPE] ET (NOLOCK) ON ME.EVENTTYPEID  = ET.ID     
						 JOIN [dbo].[CFT_BREEDER] AS OB With (NOLOCK) on ME.[BREEDERID]  = OB.ID   	
						 JOIN [dbo].[CFT_GENETICS] AS SEM	with (NOLOCK) on ME.[SEMENID]  = SEM.ID   	
						 LEFT JOIN [dbo].[MF_USER] MFU (NOLOCK) ON MFU.ID = ME.DEVICEID
						 CROSS APPLY (Select Top 1 [TAGNBR] From [dbo].[CFT_ANIMALTAG] AS ATP WITH (NOLOCK) Where
						 AN.ID  = ATP.[ANIMALID] AND ATP.[PRIMARYTAG] = 1 AND ATP.[ISCURRENT] = 1) ATP
						 OUTER APPLY (Select Top 1 [TAGNBR] From [dbo].[CFT_ANIMALTAG] AS ATA WITH (NOLOCK) Where
						 AN.ID  = ATA.[ANIMALID] AND ATA.[PRIMARYTAG] = 0) ATA
						 Where ET.[EVENTTYPE] Like 'Mating' --AND ME.SYNCSTATUS = 'NEW'
AND ME.[DELETED_BY] = -1 
AND FA.[DELETED_BY] = -1

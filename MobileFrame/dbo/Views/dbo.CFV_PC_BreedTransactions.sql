





CREATE VIEW 
    [dbo].[CFV_PC_BreedTransactions]
AS
SELECT     Distinct 
			CAST(ATP.[TAGNBR] as varchar(12)) as 'Primary'
			,CAST(ATA.[TAGNBR] as varchar(20)) as 'ALTERNATE'
			,CAST(FRM.NAME as varchar(8))as Farm
			,MFU.NAME as 'Created_By'
			,Isnull(AE.ENTEREDDATE, AE.CREATE_DATE) as CREATE_DATE
			,AE.[EVENTDATE]
			,AE.[EVENTTHDATE]
			,CASE ET.[EVENTNAME]
				WHEN 'POSITIVE' Then 'POSITIVE'
				WHEN 'Preg Test Positive' Then 'POSITIVE'
				WHEN 'Observed Heat' Then 'HEAT NS'
				WHEN 'Abortion' Then 'ABORTION'
				WHEN 'Preg Test Negative' Then 'NEGATIVE'
				ELSE CAST(ET.[EVENTNAME] as varchar(20))
			End as 'EventType'
			,AE.[ID] as MFID
			,AE.SYNCSTATUS
FROM  [dbo].CFT_ANIMAL AS AN WITH (NOLOCK) 
						JOIN [dbo].[CFT_FARMANIMAL] FA (NOLOCK) on AN.ID  = FA.ANIMALID 
						JOIN [dbo].[CFT_FARM] FRM (NOLOCK) on FA.FARMID  = FRM.ID 
						JOIN [dbo].[CFT_ANIMALEVENTS] AE (NOLOCK) ON AN.ID  = AE.ANIMALID  
						JOIN [dbo].[CFT_EVENTTYPE] ET (NOLOCK) ON AE.EVENTTYPEID  = ET.ID  
						LEFT JOIN [dbo].[MF_USER] MFU (NOLOCK) ON MFU.ID = AE.DEVICEID
						CROSS APPLY (Select Top 1 [TAGNBR] From [dbo].[CFT_ANIMALTAG] AS ATP WITH (NOLOCK) Where
						AN.ID  = ATP.[ANIMALID] AND ATP.[PRIMARYTAG] = 1 AND ATP.[ISCURRENT] = 1) ATP
						OUTER APPLY (Select Top 1 [TAGNBR] From [dbo].[CFT_ANIMALTAG] AS ATA WITH (NOLOCK) Where
						AN.ID  = ATA.[ANIMALID] AND ATA.[PRIMARYTAG] = 0) ATA
Where ET.[EVENTTYPE] like 'Breed'
AND AE.[DELETED_BY] = -1 
AND FA.[DELETED_BY] = -1

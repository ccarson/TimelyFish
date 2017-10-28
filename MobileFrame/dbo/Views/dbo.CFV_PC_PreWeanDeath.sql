﻿



CREATE VIEW 
    [dbo].[CFV_PC_PreWeanDeath]
AS
SELECT Distinct	
		     CAST(ATP.[TAGNBR] as varchar(12)) as 'Primary'
			,CAST(FRM.NAME as varchar(8))as Farm
			,MFU.NAME as 'Created_By'
			,Isnull(AE.ENTEREDDATE, AE.CREATE_DATE) as CREATE_DATE
			,AE.[EVENTDATE]
			,AE.[EVENTTHDATE]
			,AE.[QTY]
			,CAST(ET.[EVENTNAME] as varchar(20)) as 'EventType'
			,AE.REMOVALREASONID
			,Case when AE.REMOVALREASONID IS null or AE.REMOVALREASONID < 0 Then ''  ELSE RS.EVENTNAME END as 'Removal Desc'
			,AE.[ID] as MFID
			,AE.SYNCSTATUS
			,AE.EVENTNBR
			,LOC.ROOM
			,LOC.CRATE
			,DATEDIFF(d,FE.EVENTDATE,AE.EVENTDATE) as 'Age'
FROM  [dbo].CFT_ANIMAL AS AN WITH (NOLOCK) 
	JOIN [dbo].[CFT_FARMANIMAL] FA (NOLOCK) on AN.ID  = FA.ANIMALID 
	JOIN [dbo].[CFT_FARM] FRM (NOLOCK) on FA.FARMID  = FRM.ID 
	JOIN [dbo].[CFT_ANIMALEVENTS] AE (NOLOCK) ON AN.ID  = AE.ANIMALID  
	JOIN [dbo].[CFT_EVENTTYPE] ET (NOLOCK) ON AE.EVENTTYPEID  = ET.ID  
	LEFT JOIN [dbo].[MF_USER] MFU (NOLOCK) ON MFU.ID = AE.DEVICEID
	CROSS APPLY (Select Top 1 [TAGNBR] From [dbo].[CFT_ANIMALTAG] AS ATP WITH (NOLOCK) Where
		AN.ID  = ATP.[ANIMALID] AND ATP.[PRIMARYTAG] = 1 AND ATP.[ISCURRENT] = 1) ATP
	CROSS APPLY (Select TOP 1 EVENTDATE, LOCATIONID FROM dbo.CFT_ANIMALEVENTS FE
					 JOIN [MobileFrame].[dbo].[CFT_EVENTTYPE] ETM (NOLOCK) ON FE.EVENTTYPEID = ETM.ID AND ETM.EVENTNAME = 'Farrowing'	
					 where FE.PARITYNBR = AE.PARITYNBR AND FE.ANIMALID = AE.ANIMALID AND FE.[DELETED_BY] = -1) FE
	Left join [MobileFrame].[dbo].[CFT_LOCATION] LOC on LOC.ID = FE.LOCATIONID
	Outer Apply (select top 1 RS.EVENTNAME from [dbo].[CFT_EVENTTYPE] RS where DATALENGTH(RS.REASONID) > 0 and AE.REMOVALREASONID = RS.REASONID) RS
 					 


Where ET.[EVENTNAME] = 'Prewean Death'
AND AE.[DELETED_BY] = -1 
AND FA.[DELETED_BY] = -1


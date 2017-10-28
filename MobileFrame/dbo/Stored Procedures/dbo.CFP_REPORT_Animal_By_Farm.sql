







-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	9/26/2017
-- Description:	MobileFrame Animal By Farm
-- Parameters: 	@TableName, 
--		@FarmName,
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
10/07/2017	DDAHLE,				Initial Build.

========================================================================================================
*/
CREATE PROCEDURE [dbo].[CFP_REPORT_Animal_By_Farm] 
@Tag nvarchar(10),
@FarmName nvarchar(30)

AS

SELECT     
			CAST(ATP.[TAGNBR] as varchar(12)) as SowID
			,CAST(ATA.[TAGNBR] as varchar(20)) as 'ALTERNATE'
			,AN.ORIGIN
			,GEN.NAME as 'Gentics'
			,F.NAME as Farm
			,AE.EVENTNBR
			,AE.EVENTDATE AS EventDate
			,DATEDIFF(DAY, '9/27/1971', AE.EVENTDATE) % 1000 as 'PicDay'
			,AE.PARITYNBR AS Parity
			,ET.EVENTNAME as EventName
			,ST.NAME as 'STATUS'
			,Case
				When ET.EVENTTYPE Like 'Mating' Then AE.GROUPNAME +' - ' +PS.NAME +' M:' +CAST(AE.MATINGNBR as nvarchar(2)) +' B:' +CAST(AE.BREEDINGNBR as nvarchar(2)) +' PS:' +CAST(AE.PARITYSERVICENBR as nvarchar(2)) 
				When ET.EVENTTYPE Like 'Farrowing' Then ' BA:' +CAST(AE.BORNALIVE as nvarchar(2)) +' SB:' +CAST(AE.STILLBORN as nvarchar(2)) +' MUM:' +CAST(AE.MUMMY as nvarchar(2)) +' Set:'+CAST(isNull(AE.SETNBR, 0) as nvarchar(2))  +' GL:' +CAST(AE.GESTATIONLENGTH as nvarchar(3))
				When ET.EVENTTYPE Like 'Arrival' Then ET.EVENTNAME
				When ET.EVENTTYPE Like 'Piglet' and ET.[EVENTNAME] IN ('Wean','Part Wean') Then CAST(IsNull(AE.QTY,'')  as nvarchar(3)) +' Wean age:' +CAST(DATEDIFF(d,FE.EVENTDATE,AE.EVENTDATE)as nvarchar(3))
				When ET.EVENTTYPE Like 'Piglet' and ET.[EVENTNAME] = 'Nurse On' Then CAST(IsNull(AE.QTY,'')  as nvarchar(3))
				When ET.EVENTTYPE Like 'Piglet' and ET.[EVENTNAME] = 'Foster' Then CAST(IsNull(AE.QTY,'')  as nvarchar(3))
				When ET.EVENTTYPE Like 'Piglet' and ET.[EVENTNAME] = 'Prewean Death' then CAST(IsNull(AE.QTY,'')  as nvarchar(3)) + Case when AE.REMOVALREASONID IS null or AE.REMOVALREASONID < 0 Then '' ELSE ' - ' +RS.EVENTNAME END
				When ET.EVENTTYPE Like 'Removal' Then ET.EVENTNAME + Case when AE.REMOVALREASONID IS null or AE.REMOVALREASONID < 0 Then ''  ELSE ' - ' +RS.EVENTNAME END
				Else ''
			End as 'Details'
			
			
FROM    dbo.CFT_ANIMAL AS AN WITH (NOLOCK) 
		JOIN dbo.CFT_ANIMALEVENTS AS AE WITH (NOLOCK) ON AN.ID  = AE.ANIMALID
		LEFT JOIN [MobileFrame].[dbo].[CFT_STATUS] St on AE.[ANIMALSTATUS] = ST.[STATUSID]
		LEFT JOIN [MobileFrame].[dbo].[CFT_STATUS] PS on AE.[PREVSTATUS] = PS.[STATUSID]
		LEFT JOIN [MobileFrame].[dbo].[CFT_GENETICS] GEN on GEN.ID = AN.GENETICSID
		JOIN [MobileFrame].[dbo].[CFT_EVENTTYPE] ET (NOLOCK) ON AE.EVENTTYPEID  = ET.ID 
		CROSS APPLY (Select Top 1 [TAGNBR] From [MobileFrame].[dbo].[CFT_ANIMALTAG] AS ATP WITH (NOLOCK) Where
						 AN.ID = ATP.[ANIMALID] AND ATP.[PRIMARYTAG] = 1 AND ATP.[ISCURRENT] = 1) ATP
		OUTER APPLY (Select Top 1 [TAGNBR] From [dbo].[CFT_ANIMALTAG] AS ATA WITH (NOLOCK) Where
		AN.ID  = ATA.[ANIMALID] AND ATA.[PRIMARYTAG] = 0) ATA 
		LEFT Join [MobileFrame].[dbo].[CFT_FARM] F on f.ID = AE.SOURCEFARMID
		outer Apply (select top 1 RS.EVENTNAME from [dbo].[CFT_EVENTTYPE] RS where DATALENGTH(RS.REASONID) > 0 and AE.REMOVALREASONID = RS.REASONID) RS
		OUTER APPLY (Select TOP 1 EVENTDATE FROM dbo.CFT_ANIMALEVENTS FE
					 JOIN [MobileFrame].[dbo].[CFT_EVENTTYPE] ETM (NOLOCK) ON FE.EVENTTYPEID = ETM.ID AND ETM.EVENTNAME = 'Farrowing'	
					 where FE.PARITYNBR = AE.PARITYNBR AND FE.ANIMALID = AE.ANIMALID AND FE.[DELETED_BY] = -1) FE


		Where ATP.[TAGNBR] = @Tag and F.NAME like @FarmName
		and AE.DELETED_BY = -1
		and F.DELETED_BY = -1
		
		ORDER BY EVENTNBR, EventDate 

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_REPORT_Animal_By_Farm] TO [CorpReports]
    AS [dbo];


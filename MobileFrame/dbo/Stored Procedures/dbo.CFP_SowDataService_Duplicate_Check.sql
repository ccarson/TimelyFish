




-- ======================================================================================
-- Author:	Doran Dahle
-- Create date:	10/11/2017
-- Description:	SowDataService_Duplicate_Check
-- Parameters: 	StartDate, FarmName
-- ======================================================================================
/* 
========================================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
10/11/2017	DDAHLE,				Initial Build.

========================================================================================================
*/
CREATE PROCEDURE [dbo].[CFP_SowDataService_Duplicate_Check] 
@StartDate DateTime,
@FarmName nvarchar(30),
@Result Bit OUTPUT

AS
Begin
IF 0 < ANY (
  Select Count(*)
  from CFT_ANIMALEVENTS AE
  JOIN [MobileFrame].[dbo].[CFT_EVENTTYPE] ET (NOLOCK) ON AE.EVENTTYPEID  = ET.ID
  CROSS APPLY (Select Top 1 [TAGNBR] From [MobileFrame].[dbo].[CFT_ANIMALTAG] AS ATP WITH (NOLOCK) Where
						  AE.ANIMALID  = ATP.[ANIMALID] AND ATP.[PRIMARYTAG] = 1 AND ATP.[ISCURRENT] = 1) ATP
  JOIN [dbo].[CFT_FARMANIMAL] FA (NOLOCK) on AE.ANIMALID  = FA.ANIMALID 
  JOIN [dbo].[CFT_FARM] FRM (NOLOCK) on FA.FARMID  = FRM.ID 
  where AE.DELETED_BY = -1 and AE.EVENTDATE > @StartDate And FRM.Name = @FarmName
  and et.EVENTNAME not like 'Prewean Death'
  group by FRM.NAME,ATP.[TAGNBR], AE.ANIMALID, ET.EVENTNAME, EVENTTYPEID, EVENTDATE, MATINGNBR
    Having count(*) > 1)
Set @result = CAST(1 AS bit)
Else 
Set @result = CAST(0 AS bit)	 
	
END
		

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_SowDataService_Duplicate_Check] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_SowDataService_Duplicate_Check] TO [MFSowData]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CFP_SowDataService_Duplicate_Check] TO [MFSDUApp]
    AS [dbo];


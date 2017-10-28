
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2016-01-09  Doran Dahle Changed to include HIN.

===============================================================================
*/



CREATE Procedure [dbo].[pXF165IncorrectFP] 
as 
SELECT PG.[PigGroupID] as PigGroupID
      ,PG.[FeedPlanID] as currentFPID
	  ,FPL.[FeedPlanID] as correctFPID
	  ,PG.[FeedMillContactID] as FeedMillContactID
      ,PG.[PigGenderTypeID] as PigGenderTypeID 
      ,PG.[PigProdPhaseID] as PigProdPhaseID
      ,PG.[PigSystemID] as PigSystemID 
	  ,PG.CF08 as flowID
	  ,'' as Room
	  ,0 as Selected
  FROM [SolomonApp].[dbo].[cftPigGroup] PG With (NOLOCK)
  JOIN [SolomonApp].[dbo].[cftFeedPlanLink] FPL With (NOLOCK) ON PG.[FeedMillContactID] = FPL.[MillID] 
												and PG.[PigSystemID] = FPL.[SystemID] 
												and PG.[PigGenderTypeID]= FPL.[GenderID]
												and PG.CF08 = FPL.[FlowID]
  where PG.[PGStatusID] in ('A','F') 
  and PG.[PigProdPhaseID] in ('WTF','NUR','FIN','HIN') 
  and PG.[FeedPlanID] not like FPL.[FeedPlanID]
  and PG.[PigGroupID] not in (Select [PigGroupID] FROM [SolomonApp].[dbo].[cftFeedPlanInd] With (NOLOCK))-- where [Crtd_DateTime] > getdate())
  and PG.[PigGroupID] not in (Select [PigGroupID] FROM [SolomonApp].[dbo].[cftPigGroupRoom] With (NOLOCK))

Union
  
 SELECT PG.[PigGroupID] as PigGroupID
      ,PGR.[FeedPlanID] as currentFPID
	  ,FPL.[FeedPlanID] as correctFPID
	  ,PG.[FeedMillContactID] as FeedMillContactID
      ,PGR.[PigGenderTypeID] as PigGenderTypeID
      ,PG.[PigProdPhaseID] as PigProdPhaseID
      ,PG.[PigSystemID] as PigSystemID
	  ,PG.CF08 as flowID
	  ,PGR.[RoomNbr] as Room
	   ,0 as Selected
  FROM [SolomonApp].[dbo].[cftPigGroup] PG With (NOLOCK)
  JOIN [SolomonApp].[dbo].[cftPigGroupRoom] PGR With (NOLOCK) ON PG.[PigGroupID] = PGR.[PigGroupID]
  JOIN [SolomonApp].[dbo].[cftFeedPlanLink] FPL With (NOLOCK) ON PG.[FeedMillContactID] = FPL.[MillID] 
												and PG.[PigSystemID] = FPL.[SystemID] 
												and PGR.[PigGenderTypeID]= FPL.[GenderID]
												and PGR.IndPln = 0
												and PG.CF08 = FPL.[FlowID]
 
  where PG.[PGStatusID] in ('A','F') 
  and PG.[PigProdPhaseID] in ('WTF','NUR','FIN','HIN') 
  and PGR.[FeedPlanID] not like FPL.[FeedPlanID]

  Order by PG.[PigGroupID]
	




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF165IncorrectFP] TO [MSDSL]
    AS [dbo];


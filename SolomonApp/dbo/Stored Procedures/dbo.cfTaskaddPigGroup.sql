
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  Stored Procedure dbo.cfTaskaddPigGroup    Script Date: 9/3/2004 12:18:11 PM ******/

CREATE  procedure cfTaskaddPigGroup

As

DECLARE proj_cursor CURSOR
FOR
SELECT pjt_entity, project
FROM pjpent
Where Left(pjt_entity,2)='PG'
OPEN proj_cursor

DECLARE @TaskIDVal as int
DECLARE @TaskIDChar varchar(6)


FETCH NEXT FROM proj_cursor INTO @TaskIDChar, @TaskIDVal
WHILE(@@FETCH_STATUS <> -1)
	Begin
	
	PRINT @TaskIDChar
	PRINT @TaskIDVal


	INSERT into cftPigGroup (ActCloseDate,BarnNbr,Comment,Crtd_DateTime,Crtd_Prog,Crtd_User,EstCloseDate,EstInventory,
	EstStartDate,EstStartWeight,EstTopDate,FeedGrouping,FeedMillContactID,FeedPlanID,LegacyGroupID,
	Lupd_DateTime,Lupd_Prog,Lupd_User,NoteID,PGStatusID,PigFlowTypeID,PigGenderTypeID,PigGroupID,PigProdPhaseID,
	ProjectID,SiteContactID,TaskID)
	
	Select '1/1/1900','1','',getdate(),'PAPRJ','SYSADMIN','1/1/1900',0,
	0,0,'1/1/1900','','','','',
	getdate(),'PAPRJ','SYSADMIN',0,'A',0,'',
	PigGroupID=Left(@TaskIDChar,6),'',
	Project=@TaskIDVal,
	SiteContactID=RTRIM(@TaskIDVal),TaskID=@TaskIDChar

	FETCH NEXT FROM proj_cursor INTO @TaskIDChar, @TaskIDVal
CONTINUE

End

CLOSE proj_cursor
DEALLOCATE proj_cursor



 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfTaskaddPigGroup] TO [MSDSL]
    AS [dbo];


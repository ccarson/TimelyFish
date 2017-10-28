
--*************************************************************
--	Purpose:  Fill the cftPigGroupMaster table
--	Author: Sue Matter
--	Date: 9/28/2006
--	Usage: Essbase Extract cfvMasterGroupActStart
--	Parms: None
--*************************************************************

CREATE PROCEDURE dbo.cfpFillPigGroupMaster
AS

--clear the cftPigGroupMaster table
DELETE FROM cftPigGroupMaster

DECLARE @SvcMgr AS varchar(6), @Status As varchar(2), @CostFlag As Integer,
@ProdPod As varchar(3), @GenderB As Integer, @GenderG As Integer, 
@GenderM As Integer, @PigCount As Integer, @MasterGroup As varchar(10),
@MSvcMgr AS varchar(6), @MStatus As varchar(2), @MCostFlag As Integer,
@MProdPod As varchar(3), @MGenderB As varchar(6), @MGenderG As varchar(6), 
@MGenderM As varchar(6), @MPigCount As Integer,
@MasterCount As Integer, @Gender As varchar(6),@MGender As varchar(6),@SvcEff AS Datetime,@MSvcEff AS Datetime

--create cursor for all master group records
--create cursor for each pig group with this master group
DECLARE CursorMasterGroups CURSOR FAST_FORWARD
	     	FOR Select RTrim(CF03) 
		From dbo.cftPigGroup
		Where PGStatusID<>'X' AND ISNULL(CF03,'')<>''
		Group by CF03
OPEN CursorMasterGroups


--Look up all groups by the master then create the master group record
FETCH NEXT FROM CursorMasterGroups INTO @MasterGroup

--Begin loop for each of the master records
While @@FETCH_STATUS=0
--While @MasterGroup>''
	BEGIN
		--Set defaults
		SET @MStatus = 'I'
		SET @MCostFlag = 2
		SET @MGenderM = 'M'
		SET @MPigCount = 0
		SET @GenderM = 0
		SET @GenderB = 0
		SET @GenderG = 0
		SET @MSvcMgr=''
		SET @MSvcEff='01/01/1900'
		PRINT 'Current Master Group is '+ @MasterGroup 

		DECLARE CursorMasterSubGroups CURSOR FAST_FORWARD
	     	FOR Select PGStatusID, CostFlag, PigProdPodID, PigGenderTypeID, StartQty, SvcMgrContactId, EffectiveDate 
		From cfvPigGroupManager
		Where PGStatusID<>'X' AND CF03=@MasterGroup
		OPEN CursorMasterSubGroups

		FETCH NEXT FROM CursorMasterSubGroups INTO @Status, @CostFlag, @ProdPod, @Gender, @PigCount, @Svcmgr, @SvcEff 
		PRINT 'SubGroup Status1 is '+ @Status
		While @@FETCH_STATUS=0
			BEGIN	
			PRINT 'SubGroup Status is '+ @Status
--			PRINT 'Master Group Pig Total is '+ @MPigCount
			IF @Status<>'I' 
				BEGIN
					SET @MStatus='A'
				END
			PRINT 'Master Group Status is '+ @MStatus
			IF @CostFlag<>'2'
				BEGIN
					SET @MCostFlag='1'
				END
			PRINT 'Group cost flag '+ CAST(@CostFlag As Char(1)) 
			PRINT 'Master Group cost flag '+ CAST(@MCostFlag As Char(1)) 
			IF @PigCount>@MPigCount
				BEGIN
				--Use start count of this group to determine Pod assignement
					SET @MPigCount=@PigCount
					SET @MProdPod=@ProdPod
				END
--			PRINT 'Master Group Pig Count '+ Str$(@PigCount) 
			IF @Gender='B'
				BEGIN
					SET @GenderB=@GenderB + @PigCount
				END
			ELSE IF @Gender='G'
				BEGIN
					SET @GenderG=@GenderG + @PigCount
				END
			ELSE BEGIN SET @GenderM=@GenderM + @PigCount END
			IF @MSvcMgr<>@SvcMgr AND @SvcEff>@MSvcEff 
				BEGIN 
					SET @MSvcMgr=@SvcMgr 
					SET @MSvcEff=@SvcEff
				END
				PRINT 'Service Manager ' + @SvcMgr
				PRINT 'Master Manager ' + @MSvcMgr
			 	PRINT 'Eff Date '+ CAST(@SvcEff As Char(11))
			 	PRINT 'Eff Date Master '+ CAST(@MSvcEff As Char(11))


			FETCH NEXT FROM CursorMasterSubGroups INTO @Status, @CostFlag, @ProdPod, @Gender, @PigCount, @Svcmgr, @SvcEff 				 
			END
			CLOSE CursorMasterSubGroups
			DEALLOCATE CursorMasterSubGroups
		--determine the gender based on totals
		SET @MasterCount=@GenderM + @GenderG + @GenderB
		PRINT 'Master Group count  '+ CAST(@MasterCount As Char(10)) 		
		If @GenderB> @MasterCount *.7 
		BEGIN
			SET @MGender='B'
		END
		ELSE IF @GenderG>@MasterCount * .7
		BEGIN
			SET @MGender='G'
		END
		ELSE SET @MGender='M'
		PRINT 'Master Group B Count  '+ CAST(@GenderB As Char(10)) 		
		PRINT 'Master Group G Count  '+ CAST(@GenderG As Char(10)) 		
		PRINT 'Master Group Gender  '+ @MGender 		

	--store the value for status and gender and cost flag for each group based on criteria
	INSERT INTO cftPigGroupMaster ([CF01],[CF02],[CF03],[CF04],[CF05],[CF06],[CF07],[CF08],
	[CF09],[CF10],[CF11],[CF12],[Crtd_DateTime],[Crtd_Prog],[Crtd_User],
	[Lupd_DateTime],[Lupd_Prog],[Lupd_User],[MActCloseDate],[MActStartDate],
	[MBarnNbr],[MCostFlag],[MCpnyID],[MDescription],[MEstCloseDate],[MEstInventory],
	[MEstStartDate],[MEstStartWeight],[MEstTopDate],[MInitialPigValue],
	[MPGStatusID],[MPigFlowTypeID],[MPigGenderTypeID],[MPigGroupID],
	[MPigProdPhaseID],[MPigProdPodID],[MPigSystemID],[MPriorFeedQty],
	[MProjectID],[MPurchCountry],[MPurchFlag],[MSplitSrcPigGroupID],
	[MSiteContactID],[MSvcMgrContactID],[MTaskID])
	VALUES('','','','','1900-01-01','1900-01-01',0,0,0,0,0,0,GetDate(),'SQL','SMATTER',GetDate(),'SQL','SMATTER',
		'1900-01-01','1900-01-01','',@MCostFlag,'','','1900-01-01',0,'1900-01-01',
		0,'1900-01-01',0,@MStatus,
		'',@MGender,@MasterGroup,'',@MProdPod,'',0,'','',0,'','',@MSvcMgr,'')

		--store master group record in cftPigGroupMaster
		--get next master group record
		FETCH NEXT FROM CursorMasterGroups INTO @MasterGroup
	END
CLOSE CursorMasterGroups
DEALLOCATE CursorMasterGroups


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfpFillPigGroupMaster] TO PUBLIC
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfpFillPigGroupMaster] TO [MSDSL]
    AS [dbo];



Create Procedure dbo.pUnAssignLevel
	@Parent varchar(20),
	@LevelID varchar(5),
	@EffectiveDate smalldatetime
AS
DECLARE csr_Level CURSOR
	FOR Select Distinct ProductionPhaseBioSecurityLevelID FROM ProductionPhaseBioSecurityLevel 
		WHERE ProductionTypeProductionPhaseID=@Parent and ProductionPhaseBioSecurityLevelID like @LevelID
	OPEN csr_Level
	DECLARE @curLevel int
	FETCH NEXT FROM csr_Level INTO @curLevel
	WHILE (@@FETCH_STATUS <>-1)
	BEGIN
		exec pUnAssignSite @curLevel,'%',@EffectiveDate
	FETCH NEXT FROM csr_Level INTO @curLevel
	END
	CLOSE csr_Level
	DEALLOCATE csr_Level
	
	UPDATE ProductionPhaseBioSecurityLevel
		Set ProductionTypeProductionPhaseID=NULL
		WHERE EffectiveDate=@EffectiveDate
		AND ProductionPhaseBioSecurityLevelID like @LevelID
		
	INSERT INTO ProductionPhaseBioSecurityLevel
		Select ProductionPhaseBioSecurityLevelID,Null,'',0,@EffectiveDate
		FROM (Select Max(EffectiveDate) as EffectiveDate,ProductionPhaseBioSecurityLevelID From ProductionPhaseBioSecurityLevel
			WHERE EffectiveDate<@EffectiveDate
			AND ProductionTypeProductionPhaseID=@Parent
			AND ProductionPhaseBioSecurityLevelID like @LevelID
			GROUP BY ProductionPhaseBioSecurityLevelID,ProductionTypeProductionPhaseID) derived

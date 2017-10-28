
Create Procedure dbo.pUnAssignPhase
	@Parent varchar(20),
	@PhaseID varchar(5),
	@EffectiveDate smalldatetime
AS
DECLARE csr_Phase CURSOR
	FOR Select Distinct ProductionTypeProductionPhaseID FROM ProductionTypeProductionPhase 
		WHERE SystemProductionTypeID=@Parent and PigProductionPhaseID like @PhaseID
	OPEN csr_Phase
	DECLARE @curPhase int
	FETCH NEXT FROM csr_Phase INTO @curPhase
	WHILE (@@FETCH_STATUS <>-1)
	BEGIN
		exec pUnAssignLevel @curPhase,'%',@EffectiveDate
	FETCH NEXT FROM csr_Phase INTO @curPhase
	END
	CLOSE csr_Phase
	DEALLOCATE csr_Phase
	
	UPDATE ProductionTypeProductionPhase
		Set SystemProductionTypeID=NULL
		WHERE EffectiveDate=@EffectiveDate
		AND PigProductionPhaseID like @PhaseID
		
	INSERT INTO ProductionTypeProductionPhase
		Select ProductionTypeProductionPhaseID,Null,PigProductionPhaseID,@EffectiveDate
		FROM (Select Max(EffectiveDate) as EffectiveDate,ProductionTypeProductionPhaseID,PigProductionPhaseID From ProductionTypeProductionPhase
			WHERE EffectiveDate<@EffectiveDate
			AND SystemProductionTypeID=@Parent
			AND PigProductionPhaseID like @PhaseID
			GROUP BY ProductionTypeProductionPhaseID,PigProductionPhaseID) derived

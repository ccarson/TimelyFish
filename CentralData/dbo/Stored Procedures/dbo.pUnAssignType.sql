
Create Procedure dbo.pUnAssignType
	@Parent varchar(20),
	@TypeID varchar(5),
	@EffectiveDate smalldatetime
AS
DECLARE csr_Type CURSOR
	FOR Select Distinct SystemProductionTypeID FROM SystemProductionType
		WHERE BioSecuritySystemID=@Parent and PigProductionTypeID like @TypeID
	OPEN csr_Type
	DECLARE @curType int
	FETCH NEXT FROM csr_Type INTO @curType
	WHILE (@@FETCH_STATUS <>-1)
	BEGIN
		exec pUnAssignPhase @curType,'%',@EffectiveDate
	FETCH NEXT FROM csr_Type INTO @curType
	END
	CLOSE csr_Type
	DEALLOCATE csr_Type
	
	UPDATE SystemProductionType
		Set BioSecuritySystemID=NULL
		WHERE EffectiveDate=@EffectiveDate
		AND PigProductionTypeID like @TypeID
		
	INSERT INTO SystemProductionType
		Select SystemProductionTypeID,Null,PigProductionTypeID,@EffectiveDate
		FROM (Select Max(EffectiveDate) as EffectiveDate,SystemProductionTypeID,PigProductionTypeID From SystemProductionType
			WHERE EffectiveDate<@EffectiveDate
			AND BioSecuritySystemID=@Parent
			AND PigProductionTypeID like @TypeID
			GROUP BY SystemProductionTypeID,PigProductionTypeID) derived

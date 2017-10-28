
Create Procedure dbo.pUnAssignSystem
	@Parent varchar(20),
	@SystemID varchar(5),
	@EffectiveDate smalldatetime
AS
DECLARE csr_System CURSOR
	FOR Select Distinct BioSecuritySystemID FROM BioSecuritySystem
		WHERE BioSecurityID=@Parent and PigSystemID like @SystemID
	OPEN csr_System
	DECLARE @curSystem int
	FETCH NEXT FROM csr_System INTO @curSystem
	WHILE (@@FETCH_STATUS <>-1)
	BEGIN
		exec pUnAssignType @curSystem,'%',@EffectiveDate
	FETCH NEXT FROM csr_System INTO @curSystem
	END
	CLOSE csr_System
	DEALLOCATE csr_System
	
	UPDATE BioSecuritySystem
		Set BioSecurityID=NULL
		WHERE EffectiveDate=@EffectiveDate
		AND BioSecuritySystemID like @SystemID
		
	INSERT INTO BioSecuritySystem
		Select BioSecuritySystemID,PigSystemID,@EffectiveDate,Null
		FROM (Select Max(EffectiveDate) as EffectiveDate,BioSecuritySystemID,PigSystemID From BioSecuritySystem
			WHERE EffectiveDate<@EffectiveDate
			AND BioSecurityID=@Parent
			AND PigSystemID like @SystemID
			GROUP BY BioSecuritySystemID,PigSystemID) derived

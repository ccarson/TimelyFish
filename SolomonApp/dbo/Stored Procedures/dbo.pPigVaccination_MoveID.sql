Create Proc pPigVaccination_MoveID
	@MoveID int
	As
	select * From dbo.PigVaccination
		Where PigMovementID = @MoveID
		Order By PigVaccinationID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pPigVaccination_MoveID] TO [MSDSL]
    AS [dbo];


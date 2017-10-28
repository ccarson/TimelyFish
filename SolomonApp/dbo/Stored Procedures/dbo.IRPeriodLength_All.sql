 Create Procedure IRPeriodLength_All @CpnyID VarChar(10), @SetupID VarChar(2), @LineNbrStart SmallInt, @LineNbrEnd SmallInt AS
Select * from IRPeriodLength
	Where
		CpnyID like @CpnyID And
		SetupID Like @SetupID And
		LineNbr Between @LineNbrStart and @LineNbrEnd
	Order by CpnyID, SetupID, LineNbr



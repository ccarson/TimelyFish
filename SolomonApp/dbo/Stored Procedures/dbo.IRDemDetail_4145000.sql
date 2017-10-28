 CREATE Procedure IRDemDetail_4145000
	@DemandFormulaID VarChar(10)
As
Select
	*
From
	 IRDemDetail
Where
	DemandID Like @DemandFormulaID

Order By
	DemandID,
	PriorPeriodNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[IRDemDetail_4145000] TO [MSDSL]
    AS [dbo];


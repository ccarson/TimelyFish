 CREATE Procedure IRLTDetail_4145000
	@LeadFormulaID VarChar(10)
As
Select
	*
From
	 IRLTDetail
Where
	LeadTimeID Like @LeadFormulaID
Order By
	LeadTimeID,
	PriorPeriodNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



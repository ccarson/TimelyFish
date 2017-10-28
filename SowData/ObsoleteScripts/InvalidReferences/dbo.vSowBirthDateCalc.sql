--*************************************************************
--	Purpose:Calculate Sow Birthdate based on the first mating
--	
--	Author: Charity Anderson
--	Date: 3/21/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vSowBirthDateCalc
AS
Select FarmID, SowID, MatingDate as EntryDate,
Days=(Select Top 1 NbrDays from SowBreedDaysFromBirth where EffectiveDate<=MatingDate
		order by EffectiveDate DESC)
From vSowBirthDateCalc1


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowBirthDateCalc] TO [se\analysts]
    AS [dbo];


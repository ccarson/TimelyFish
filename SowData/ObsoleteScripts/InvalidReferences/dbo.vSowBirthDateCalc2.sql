--*************************************************************
--	Purpose:Calculate Sow Birthdate based on the first mating
--	
--	Author: Charity Anderson
--	Date: 3/21/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vSowBirthDateCalc2
AS
Select FarmID, SowID, EntryDate,Days, EntryDate-Days as BDate
From vSowBirthDateCalc


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowBirthDateCalc2] TO [se\analysts]
    AS [dbo];


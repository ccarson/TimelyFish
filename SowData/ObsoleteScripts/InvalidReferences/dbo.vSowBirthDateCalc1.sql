--*************************************************************
--	Purpose:Calculate Sow Birthdate based on the first mating
--	
--	Author: Charity Anderson
--	Date: 3/21/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vSowBirthDateCalc1
AS
Select FarmID, SowID, min(WeekOFDate) as MatingDate
From SowMatingEvent me
JOIN SowMultiplierFarm m on me.FarmID=m.Multiplier
where me.MatingNbr=1
Group by FarmID, SowID

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowBirthDateCalc1] TO [se\analysts]
    AS [dbo];


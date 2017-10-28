--*************************************************************
--	Purpose:Calculate Sow Birthdate based on the first mating
--	
--	Author: Charity Anderson
--	Date: 3/21/2005
--	Usage: SowGenetic Royalties
--	Parms:
--*************************************************************
CREATE VIEW dbo.vSowBirthDateCalcTemp
AS
Select s.FarmID, s.SowID,
EntryDate=Case when b.SowID is null then
	s.EntryWeekOfDate else b.EntryWeekOfDate end,
Days=
Case when b.SowID is null then 
	(Select Top 1 NbrDays from SowBreedDaysFromBirth where EffectiveDate<=s.EntryDate
		order by EffectiveDate desc)
else
	(Select Top 1 NbrDays from SowBreedDaysFromBirth where EffectiveDate<=b.EntryDate
		order by EffectiveDate desc)
end
From Sow s
LEFT JOIN Sow b on s.SowID=b.SowID and s.Origin=b.FarmID


GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vSowBirthDateCalcTemp] TO [se\analysts]
    AS [dbo];


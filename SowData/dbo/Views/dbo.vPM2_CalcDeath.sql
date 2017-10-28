CREATE VIEW [dbo].[vPM2_CalcDeath]
AS
Select 
swe.FarmID, swe.SowID, swe.WeekOfDate, swe.SowParity,cd.SortCode, cd.FirstOnCode,swe.SortCode as WeanCode,
Qty as WeanQty,
BornAlive=isnull((Select sum(QtyBornAlive) from 
			SowFarrowEventTemp where SowID=swe.SowID and SowParity=swe.SowParity 
			and SortCode between cd.FirstOnCode and swe.SortCode),0),
NurseOn=isnull((Select sum(Qty) from 
			SowNurseEventTemp where SowID=swe.SowID and SowParity=swe.SowParity 
			and SortCode between cd.FirstOnCode and swe.SortCode),0),
PigDeath=isnull((Select sum(Qty) from 
			SowPigletDeathEventTemp where SowID=swe.SowID and SowParity=swe.SowParity 
			and SortCode between cd.FirstOnCode and swe.SortCode),0)
 from SowWeanEventTemp swe 
JOIN vPM_CalcDeath cd on swe.SowID=cd.SowID and swe.SowParity=cd.SowParity and swe.SortCode=cd.SortCode
--where swe.SowID='012377'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[vPM2_CalcDeath] TO [se\analysts]
    AS [dbo];


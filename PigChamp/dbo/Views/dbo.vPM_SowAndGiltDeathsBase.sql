

CREATE VIEW [dbo].[vPM_SowAndGiltDeathsBase] (FarmID, SowID, WeekOfDate, SowGenetics, SowParity)
	As 
	SELECT FarmID, SowID, RemovalWeekOfDate, Genetics, 
		SowParity = IsNull((SELECT Max(Parity) FROM caredata.cfv_SowParity Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= RemovalDate),s.InitialParity)
		FROM caredata.cfv_Sow s
		WHERE RemovalType In('DEATH','DESTROYED') 



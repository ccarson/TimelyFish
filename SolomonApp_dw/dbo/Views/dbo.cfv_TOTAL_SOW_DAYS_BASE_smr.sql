



-- ==================================================================
-- Author:		Mike Zimanski
-- Create date: 10/13/2010
-- Description:	Total Sow Days by Farm
-- ==================================================================
CREATE VIEW [dbo].[cfv_TOTAL_SOW_DAYS_BASE_smr]
	(FarmID, SowID, EntryDate, RemovalDate, WeekOfDate, SowGenetics, SowParity, SowDays)
	AS
	SELECT s.FarmID, s.SowID, s.EntryDate, s.RemovalDate, wd.WeekOfDate, s.Genetics, 
		SowParity = (SELECT Max(Parity) 
					 FROM [$(PigCHAMP)].[caredata].[CFV_SowParity]	-- 201503 move off of sowdata db
					 Where FarmID = s.FarmID and SowID = s.SowID AND EffectiveDate <= wd.WeekEndDate)
		,
		SowDays = (CASE (datediff(day, wd.WeekOfDate -1, RemovalDate))
			WHEN 1 THEN 1
			WHEN 2 THEN 2
			WHEN 3 THEN 3
			WHEN 4 THEN 4
			WHEN 5 THEN 5
			WHEN 6 THEN 6
			ELSE 7
			END) 
			-- Subtract any days from entry if entry after beginning of week
			- (CASE 7-(datediff(day,s.EntryDate,wd.WeekEndDate))
				WHEN 1  THEN 1
				WHEN 2 THEN 2
				WHEN 3 THEN 3
				WHEN 4 THEN 4
				WHEN 5 THEN 5
				WHEN 6 THEN 6
				ELSE 0
				END)
		FROM [$(SolomonApp)].dbo.cftWeekDefinition wd
		LEFT JOIN [$(PigCHAMP)].caredata.cfv_sow s ON s.EntryDate <= wd.WeekEndDate		-- 201503 move off of sowdata db
		AND (IsNull(s.RemovalDate,'1/1/2059')> wd.WeekEndDate Or s.removalweekofdate = wd.weekofdate)






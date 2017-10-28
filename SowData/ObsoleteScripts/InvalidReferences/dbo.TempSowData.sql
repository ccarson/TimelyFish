CREATE view [dbo].[TempSowData]
AS
SELECT     dbo.GetSowFarmIDFromContactID(f.ContactID, f.DelDate) AS FarmId, f.ContactID, dd.WeekOfDate, f.DelDate, f.InvtIdDel, f.OrdNbr, 
                      CASE reversal WHEN 0 THEN qtydel ELSE qtydel * - 1 END AS QtyDel, f.Reversal
FROM         dbo.PreSolomonSowFeed AS f INNER JOIN
                      [$(SolomonApp)].dbo.cftDayDefinition AS dd ON f.DelDate = dd.DayDate	-- changed reference to solomonapp version of the table 20130905
		JOIN WeekDefinitionTemp wd ON dd.WeekOfDate = wd.WeekOfDate
		Where f.InvtIdDel='021M'
UNION
SELECT     dbo.GetSowFarmIDFromContactID(f.ContactId, f.DateDel) AS FarmID, f.ContactId, dd.WeekOfDate, f.DateDel, f.InvtIdDel, f.OrdNbr, 
                      CASE reversal WHEN 0 THEN qtydel ELSE qtydel * - 1 END AS QtyDel, f.Reversal
FROM         [$(SolomonApp)].dbo.cftFeedOrder AS f INNER JOIN			-- removed the earth reference 20130905 smr (saturn retirement)
             [$(SolomonApp)].dbo.cftDayDefinition AS dd ON f.DateDel = dd.DayDate AND f.Status = 'C'	-- changed reference to solomonapp version of the table 20130905
		JOIN WeekDefinitionTemp wd ON dd.WeekOfDate = wd.WeekOfDate
Where f.InvtIdDel='021M'

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[TempSowData] TO [se\analysts]
    AS [dbo];


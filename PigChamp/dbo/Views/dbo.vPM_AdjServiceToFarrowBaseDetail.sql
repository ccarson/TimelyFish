

CREATE VIEW [dbo].[vPM_AdjServiceToFarrowBaseDetail]
AS

SELECT     sme.FarmID, wd.WeekOfDate, sme.SowID, sme.SowGenetics, sme.SowParity
FROM         [$(SolomonApp)].[dbo].[cftWeekDefinition] AS wd WITH (NOLOCK) LEFT OUTER JOIN
                      caredata.cfv_SowMatingEvent AS sme WITH (NOLOCK) ON sme.EventDate BETWEEN wd.WeekOfDate - 115 AND wd.WeekOfDate - 109 LEFT OUTER JOIN
                          (SELECT     FarmID, SowID, EventDate, WeekOfDate, RemovalType, PrimaryReason, SowParity, SowGenetics
                            FROM          caredata.cfv_SowRemoveEvent WITH (Nolock)
                            WHERE      (PrimaryReason IN ('DEPOP', 'DEPOPULATION')) AND (EventDate >= '10/4/2009') AND (EventDate <= '12/12/2009')) AS re ON 
                      sme.FarmID = re.FarmID AND sme.SowID = re.SowID AND sme.SowParity = re.SowParity
WHERE     (sme.MatingNbr = 1) AND (sme.SowID NOT IN
                          (SELECT DISTINCT SowID
                            FROM          caredata.cfv_SowFarrowEvent WITH (NOLOCK)
                            WHERE      (FarmID = sme.FarmID) AND (SowID = sme.SowID) AND (EventDate BETWEEN wd.WeekOfDate - 7 AND wd.WeekOfDate - 1 OR
                                                   EventDate BETWEEN wd.WeekOfDate + 7 AND wd.WeekOfDate + 13))) AND (re.PrimaryReason IS NULL)
UNION
SELECT     FarmID, WeekOfDate, SowID, SowGenetics, SowParity
FROM         caredata.cfv_SowFarrowEvent AS sfe WITH (NOLOCK)





CREATE   VIEW cfvStartInvVsCapacity
AS

--*************************************************************
--	Purpose: Pig Group Capacity calc by Barn or Room
--	Author: Eric Lind
--	Date: 3/8/2005
--	Usage: CF616StartInv Report
--	Parameters: --
--*************************************************************

SELECT 
   c.ContactName,
   pg.BarnNbr,
   pgr.RoomNbr,
   pg.PigGroupID,
   MIN(pg.Description) As Description,
   MIN(gs.StartDate) AS StartDate,        --- Start Date of pig group
   
   (SELECT Sum(t.Qty * t.InvEffect)       --- Current Inventory of pig group
     FROM cftPGInvTran t 
     WHERE t.PigGroupID = pg.PigGroupID 
     AND t.Reversal<>'1') 
   AS CurrentInv,

    CASE                                  --- Capacity of Barn (or Room)
      WHEN (SELECT Count(pgr1.RoomNbr) FROM cftPigGroupRoom pgr1
             WHERE pgr1.PigGroupID = pg.PigGroupID) = 1
         THEN max(b.StdCap) * max(rm.BrnCapPrct)
      ELSE
         max(b.StdCap )
    END
   AS Capacity

-- max(b.StdCap) AS BarnCap                 --- Standard Capacity of barn
              
   
FROM cftPigGroup pg
JOIN cftContact c ON c.ContactID = pg.siteContactID            -- For Site Name
JOIN cftBarn b ON b.BarnNbr = pg.BarnNbr                       -- For Barn Capacity
    AND b.ContactID = pg.SiteContactID                         
JOIN cfv_GroupStart gs ON gs.TaskID = ('PG' + pg.PigGroupID)   -- For Start Date  
LEFT JOIN cftPigGroupRoom pgr ON pgr.PigGroupID = pg.PigGroupID
LEFT JOIN cftRoom rm ON rm.contactID = b.contactID AND rm.BarnNbr = b.BarnNbr


WHERE pg.PGStatusID IN ('A', 'T')     --- Active and Ten. Closed groups


GROUP BY c.ContactName, pg.BarnNbr, pg.PigGroupID, pgr.RoomNbr




CREATE VIEW [dbo].[vPBI_Matings]
AS

-- ===================================================================
-- Author:	John Maas
-- Create date: 08/04/2017
-- Description:	This view provides valuable data for Mating Event
/*************************
** Change History
**************************
** PR   Date			Author			Description 
** --   --------		-------			------------------------------------
** 1    08/04/2017		John Maas		CREATED
**
*******************************/
-- ===================================================================


SELECT me.animalid, 
       at.tagnbr                                AS [SowID], 
       me.groupname, 
       f.NAME                                   AS [MatingFarm], 
       me.eventdate                             AS [MatingDate], 
       CONVERT(VARCHAR(10), me.eventdate, 101)  AS [ShortDate], 
       LEFT(Datename(weekday, me.eventdate), 3) AS [DayName], 
       Datepart(dw, me.eventdate)               AS [DayOfWeek], 
       Datediff(wk, wd.weekenddate, Getdate())  AS [WksBack], 
       s.NAME                                   AS [PrevStatusName], 
       g.NAME                                   AS [SowGenetics], 
       me.paritynbr, 
       1                                        AS [MatingCnt], 
       me.parityservicenbr, 
       me.matingnbr, 
       me.matinghour, 
       b.NAME                                   AS [Breeder], 
       gs.NAME                                  AS [SireGenetics] 
FROM   dbo.cft_animalevents me 
       INNER JOIN dbo.cft_eventtype et 
               ON et.id = me.eventtypeid 
                  AND et.deleted_by = -1 
                  AND et.eventname = 'Mating' 
                  AND me.deleted_by = -1 
       JOIN dbo.cft_status s 
         ON s.id = me.prevstatus 
            AND s. deleted_by = -1 
       LEFT JOIN dbo.cft_animaltag at 
              ON AT.animalid = me.animalid 
                 AND AT.primarytag = 1 
                 AND AT.deleted_by = -1 
       LEFT JOIN dbo.cft_animal a 
              ON a.id = me.animalid 
                 AND a.deleted_by = -1 
       LEFT JOIN dbo.cft_genetics g 
              ON g.id = a.geneticsid 
                 AND g.deleted_by = -1 
       LEFT JOIN dbo.cft_farmanimal fa 
              ON fa.animalid = me.animalid 
                 AND fa.deleted_by = -1 
       LEFT JOIN dbo.cft_farm f 
              ON f.id = fa.farmid 
                 AND f.deleted_by = -1 
       LEFT JOIN dbo.cft_breeder b 
              ON b.id = me.breederid 
                 AND b.deleted_by = -1 
       LEFT JOIN dbo.cft_genetics gs 
              ON gs.id = me.semenid 
                 AND gs.deleted_by = -1 
       LEFT JOIN dbo.cft_weekdefinition wd 
              ON me.groupname = wd.groupname 
                 AND wd.deleted_by = -1 

--where datediff(wk,wd.WEEKENDDATE,getdate())<= @WksBack 




CREATE VIEW [dbo].[vPBI_Farrows]
AS

-- ===================================================================
-- Author:	John Maas
-- Create date: 08/04/2017
-- Description:	This view provides valuable data for Farrows
/*************************
** Change History
**************************
** PR   Date			Author			Description 
** --   --------		-------			------------------------------------
** 1    08/04/2017		John Maas		CREATED
**
*******************************/
-- ===================================================================

SELECT wd.groupname                           AS [EventWeek], 
       ae.eventdate                           AS [FarrowDate], 
       AT.tagnbr                              AS [SowID], 
       g.NAME                                 AS [Genetics], 
       ae.paritynbr, 
       s.NAME                                 AS [PrevStatusName], 
       1                                      AS [FarrowCnt], 
       ae.bornalive, 
       ae.mummy, 
       ae.stillborn, 
       ae.bornalive + ae.mummy + ae.stillborn AS [TotalBorn], 
       f.NAME                                 AS [FarrowFarm], 
       l.room, 
       l.crate, 
       ae.gestationlength 
FROM   dbo.cft_animalevents ae 
       INNER JOIN dbo.cft_eventtype et 
               ON et.id = ae.eventtypeid 
                  AND et.deleted_by = -1 
                  AND et.eventname = 'Farrowing' 
       LEFT JOIN dbo.cft_status s 
              ON s.id = ae.prevstatus 
                 AND s. deleted_by = -1 
       LEFT JOIN dbo.cft_animaltag at 
              ON AT.animalid = ae.animalid 
                 AND AT.primarytag = 1 
                 AND AT.deleted_by = -1 
       LEFT JOIN dbo.cft_animal a 
              ON a.id = ae.animalid 
                 AND a.deleted_by = -1 
       LEFT JOIN dbo.cft_genetics g 
              ON g.id = a.geneticsid 
       LEFT JOIN dbo.cft_farmanimal fa 
              ON fa.animalid = ae.animalid 
                 AND fa.deleted_by = -1 
       LEFT JOIN dbo.cft_farm f 
              ON f.id = fa.farmid 
                 AND f.deleted_by = -1 
       LEFT JOIN dbo.cft_location l 
              ON l.id = ae.locationid 
                 AND l.deleted_by = -1 
       LEFT JOIN dbo.cft_weekdefinition wd 
              ON ae.eventdate BETWEEN wd.weekofdate AND wd.weekenddate 
                 AND wd.deleted_by = -1 
WHERE  ae.deleted_by = -1  

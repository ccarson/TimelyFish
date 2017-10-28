

CREATE VIEW [dbo].[vPBI_FarmWeeklyTargets] 
AS 
  -- =================================================================== 
  -- Author:  John Maas 
  -- Create date: 08/15/2017 
  -- Description:  This view diplays the overall Farm targets by Week. 
/************************* 
** Change History 
************************** 
** PR   Date      Author      Description  
** --   --------    -------      ------------------------------------ 
** 1    08/15/2017    John Maas    CREATED 
** 
*******************************/ 
  -- =================================================================== 
  SELECT ft.farmid, 
         wd.groupname, 
         ft.targetid, 
         f.NAME AS [Farm], 
         ft.targetstartdate, 
         ft.targetenddate, 
         ft.target, 
         ft.animaltype, 
         t.targetname, 
         t.targetdesc 
  FROM   dbo.cft_farm_target ft 
         LEFT JOIN dbo.cft_farm f 
                ON f.id = ft.farmid 
                   AND f.deleted_by = -1 
         INNER JOIN dbo.cft_target t 
                 ON t.id = ft.targetid 
                    AND t.deleted_by = -1 
         INNER JOIN dbo.cft_weekdefinition wd 
                 --The target associates with the first day of the week (Sunday) 
                 --If the Target changes on (Mon-Sat), it is associated with the next week. 
                 ON ft.targetstartdate <= wd.weekenddate 
                    AND Isnull(ft.targetenddate, Getdate()) > wd.weekofdate 
  WHERE  t.active = 1 
         AND ft.animaltype = 0 

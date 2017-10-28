







CREATE VIEW 
    [dbo].[CFV_FB_FarmWeeklyTargets]
AS
  SELECT  
         wd.groupname,
         f.NAME AS [Farm], 
         ft.target, 
		 Case 
			WHEN ft.animaltype = 1 Then 'Gilt'
			WHEN ft.animaltype = 2 Then 'Sow'
			ELSE ''
		 END as ANIMALTYPE,	 
         t.targetname, 
         t.targetdesc,
		 t.TargetType
 FROM dbo.cft_farm_target ft 
    INNER JOIN dbo.cft_farm f 
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


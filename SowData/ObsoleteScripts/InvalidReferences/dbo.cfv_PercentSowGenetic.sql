Create View [dbo].[cfv_PercentSowGenetic] 
as
Select WeekofDate, FarmID,
Round(Cast(Sow_7700/AllMatings as char),2)      AS '7700',
Round(Cast(Sow_7702/AllMatings as char),2)      AS '7702',
Round(Cast(Sow_7121/AllMatings as char),2)      AS '7121',
Round(Cast(Sow_F20/AllMatings  as char),2)      AS 'F20',
Round(Cast(Sow_715/AllMatings as char),2)       AS '715',
Round(Cast(Other/AllMatings as char),2)         AS 'Other',
Round(Cast(AllMatings as char),0)               AS 'AllMatings'
From   

(Select WeekofDate                                                  AS   'WeekofDate',  --Convert(Char,WeekofDate,101)
      CASE When FarmID in ('C27','C28','C29','C30','C31')           Then 'LDC' 
           When FarmID in ('C32','C33','C34','C35','C36','C37')     Then 'ON' 
                              Else Left(FarmID,3)   End Farmid, 
 
 
      convert(numeric(5,2),Sum(Case When SowGenetics = '7700' Then (MatingNbr) Else ' ' End)) 'Sow_7700',
      convert(numeric(5,2),Sum(Case When SowGenetics = '7702' Then (MatingNbr) Else ' ' End)) 'Sow_7702',
      convert(numeric(5,2),Sum(Case When SowGenetics = '7121' Then (MatingNbr) Else ' ' End)) 'Sow_7121',
      convert(numeric(5,2),Sum(Case When SowGenetics = 'F20'  Then (MatingNbr) Else ' ' End)) 'Sow_F20',
      convert(numeric(5,2),Sum(Case When SowGenetics = '715'  Then (MatingNbr) Else ' ' End)) 'Sow_715',
      convert(numeric(5,2),Sum(Case When SowGenetics not in ('7700','7702','7121','F20','715') Then (MatingNbr) Else ' ' End)) 'Other',
      convert(numeric(5,2),Sum(Case When SowGenetics is not null then (MatingNbr) Else ' ' End)) 'AllMatings'

From SowMatingEvent
Where MatingNbr = '1'
Group By FarmID, WeekofDate) HELENE

GO
GRANT VIEW DEFINITION
    ON OBJECT::[dbo].[cfv_PercentSowGenetic] TO [se\analysts]
    AS [dbo];


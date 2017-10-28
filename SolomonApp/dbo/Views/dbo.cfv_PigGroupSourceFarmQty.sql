CREATE view cfv_PigGroupSourceFarmQty as
Select  pg.PigProdPhaseID 'Phase',
     Case When PJ.Project_Desc = 'LDC Farrowing' Then 'LDC' 
              When PJ.Project_Desc = 'ON Farrowing'  Then 'ON'
              When PJ.Project_Desc is null and acct = 'Pig Move In' Then 'M_In'
              When PJ.Project_Desc is null and acct = 'Pig Move Out' Then 'M_Out'
              When PJ.Project_Desc is null and acct = 'Pig Purchase' Then 'Purc'
           When PJ.Project_Desc Like '[C,M]___'   Then Left(PJ.Project_Desc,1)+ Right(Left(PJ.Project_Desc,4),2) 
                      Else Pj.Project_Desc End 'FarmID',
 
IT.piggroupID 'Pig_Group', 
DD.WeekofDate 'WeekofDate', 
   
Sum(Case When Acct = 'Pig Transfer In' Then IT.qty Else ' ' End)                               'Pig_Transfer_In',
Sum(Case When Acct = 'Pig Move In' Then IT.qty Else ' ' End)                                   'Pig_Move_In',
Sum(Case When Acct = 'Pig Purchase' Then IT.qty Else ' ' End)                                  'Pig_Purchase',
Sum(Case When Acct = 'Pig Move Out' Then IT.qty Else ' ' End)                                  'Pig_Move_Out',
Sum(Case When Acct In ('Pig Move Out','Pig Move In','Pig Purchase','Pig Transfer In') 
      Then 
            (Case When Acct In ('Pig Move In','Pig Purchase','Pig Transfer In') Then it.qty Else (it.qty*-1) End)
                  Else 0 End) 'Total_Group'
 
 
From cftPGInvTran IT
Left Join PJProj PJ
On IT.SourceProject=PJ.Project
Left Join cftPigGroup PG
On IT.PigGroupID=PG.PigGroupID
Left Join dbo.cfvDayDefinition_WithWeekInfo DD
On PG.ActStartDate=DD.DayDate
Where Acct In ('Pig Transfer In','Pig Purchase','Pig Move In', 'Pig Move Out')
And PG.PigProdPhaseID = 'NUR'
And IT.Reversal <> '1'
And PG.PGStatusID = 'I'
And PG.ActStartDate > '1-1-2006'
Group By IT.PigGroupID, PG.PigProdPhaseID, PG.ActStartDate, PJ.Project_Desc, DD.WeekofDate, Acct

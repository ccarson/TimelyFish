create view [cfv_PigGroupSireQty_remove] as

Select rtrim('PG'+Pig_Group) 'Pig_Group', WeekofDate, Qty_TR4, Qty_280, Qty_Other, Total,
      Case When Qty_TR4 >= (0.7*Total) Then 'Sire_TR4'
             When Qty_280 >= (0.7*Total) Then 'Sire_280'
                  Else 'Unknown' End 'Sire'
From
(Select Pig_Group, WeekofDate, Total, 
Round(Qty_TR4-((Qty_TR4/Total)*Pig_Move_Out),1) 'Qty_TR4',
Round(Qty_280-((Qty_280/Total)*Pig_Move_Out),1) 'Qty_280',
Round(Qty_Other-((Qty_Other/Total)*Pig_Move_Out),1) 'Qty_Other'
 
 
From
 
 
(Select Pig_Group, WeekofDate, Sum(Pig_Move_Out) 'Pig_Move_Out', Sum(Prorated_TR4) 'Qty_TR4', Sum(Prorated_280) 'Qty_280', Sum(Prorated_Other) 'Qty_Other', Sum(Total_Group) 'Total'
From
 
(Select pig_group, pgs.weekofdate, pgs.farmid, Pig_Move_Out, Pig_Move_In, Pig_Purchase, Pig_Transfer_In,
 
Sum((Pig_Transfer_In*Sire_TR4)-(Pig_Move_Out*Sire_TR4))                    'Prorated_TR4',
Sum((Pig_Transfer_In*Sire_280)-(Pig_Move_Out*Sire_280))                     'Prorated_280',
Case When Total_Group > 0 and Sire_TR4 is null and Sire_280 is null and Sire_Other is null  
 
           Then Sum(Total_Group)      
                  Else Sum((Pig_Transfer_In*Sire_Other)-(Pig_Move_Out*Sire_other))        
                        End 'Prorated_Other',
 
Sum(Total_Group)     'Total_Group'
 
From
 

cfv_PigGroupSourceFarmQty AS PGS 
 
 
Left Join Helene.SowData.DBO.cfv_PercentSireGenetic SME
On PGS.FarmID=SME.FarmID
And DateAdd(Week, 19,SME.WeekofDate) = PGS.WeekofDate
 
 
Group By Pig_Group, Phase, PGS.FarmID, PGS.WeekofDate, Pig_Move_In, Pig_Purchase
 
,pig_move_out
,pig_transfer_in
,sire_tr4
,sire_280
,sire_other
,total_group) Sub1


Group By Pig_Group, WeekofDate) Sub2) Sub3

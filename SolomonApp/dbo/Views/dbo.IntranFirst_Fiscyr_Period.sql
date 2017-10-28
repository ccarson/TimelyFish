 

Create View IntranFirst_Fiscyr_Period
as
Select Invtid,
       Siteid,
       Fiscyr=Min(Fiscyr),
       PerPost=Min(PerPost)
  From Intran
  Where Fiscyr <> ' '
  Group by Invtid,Siteid

 

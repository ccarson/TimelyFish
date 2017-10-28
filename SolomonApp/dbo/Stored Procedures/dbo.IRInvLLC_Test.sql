 CREATE Procedure IRInvLLC_Test @DateFor smalldatetime As
  Select * from IRInvLLC where Crtd_Datetime Between DateAdd(Second,-1,@DateFor) and DateAdd(Day,1,DateAdd(Second,-1,@DateFor))



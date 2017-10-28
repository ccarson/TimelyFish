 Create Proc ItemHist_First_Intran @Parm1 Char(30), @Parm2 Char(10)
As
Select Fiscyr,PerPost
  from IntranFirst_Fiscyr_Period
  where Invtid =  @Parm1
    and Siteid = @Parm2




GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemHist_First_Intran] TO [MSDSL]
    AS [dbo];


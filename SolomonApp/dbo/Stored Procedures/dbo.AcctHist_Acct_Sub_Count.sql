 /****** Object:  Stored Procedure dbo.AcctHist_Acct_Sub_Count    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AcctHist_Acct_Sub_Count @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24) As
       Select count(Acct) from AcctHist
           where CpnyId = @parm1
             and Acct like @parm2
             and Sub like @parm3



 /****** Object:  Stored Procedure dbo.AcctHist_Acct_Sub_GEFiscYr    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AcctHist_Acct_Sub_GEFiscYr @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 4) as
       Select * from AcctHist
           where Acct   like @parm1
             and Sub    like @parm2
             and FiscYr >=   @parm3
           order by Acct,Sub,FiscYr



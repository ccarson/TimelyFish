 /****** Object:  Stored Procedure dbo.AllocSrc_Acct_Sub    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AllocSrc_Acct_Sub @parm1 varchar ( 10), @parm2 varchar ( 24) as
       Select * from AllocSrc
           where Acct LIKE @parm1
             and Sub  LIKE @parm2
           order by Acct, Sub



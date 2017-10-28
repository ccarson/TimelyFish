 /****** Object:  Stored Procedure dbo.AllocDest_Acct_Sub    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AllocDest_Acct_Sub @parm1 varchar ( 10), @parm2 varchar ( 24) as
       Select * from AllocDest
           where Acct LIKE @parm1
             and Sub  LIKE @parm2
           order by Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AllocDest_Acct_Sub] TO [MSDSL]
    AS [dbo];


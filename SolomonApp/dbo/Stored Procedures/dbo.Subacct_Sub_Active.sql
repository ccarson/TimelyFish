 /****** Object:  Stored Procedure dbo.Subacct_Sub_Active    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc  Subacct_Sub_Active @parm1 varchar ( 24) as
       Select * from Subacct
           where Sub     LIKE  @parm1
             and Active  =      1
           order by Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Subacct_Sub_Active] TO [MSDSL]
    AS [dbo];


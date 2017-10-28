

Create Proc  Subacct_Sub_Active_w @parm1 varchar ( 24) as
       Select sub, descr from Subacct
           where Sub     =  @parm1
             and Active  =      1    


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Subacct_Sub_Active_w] TO [MSDSL]
    AS [dbo];


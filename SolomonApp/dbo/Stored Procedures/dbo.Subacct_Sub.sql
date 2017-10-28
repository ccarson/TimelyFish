 /****** Object:  Stored Procedure dbo.Subacct_Sub    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc  Subacct_Sub @parm1 varchar ( 24) as
       Select * from Subacct
           where Sub  LIKE  @parm1
           order by Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Subacct_Sub] TO [MSDSL]
    AS [dbo];

